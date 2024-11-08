import { thcrapDownloader } from "./thcrap";
import { APPDATA_PATH } from "./globals";
import * as fs from "@tauri-apps/plugin-fs";
import { download } from "@tauri-apps/plugin-upload";
import { unzip } from "./utils/unzip";
import { logger } from "./lib/logging";
const branchList = document.getElementById("thcrap__branch-list-items")!
const selectedItem = document.getElementById("thcrap__branch-list-selected")!
const downloadButton = document.getElementById("thcrap__download-btn") as HTMLButtonElement;
const progressbar = document.getElementById("thcrap__download-progressbar")!;
const progresstext = document.getElementById("thcrap__download-progress-text") as HTMLSpanElement;
const searchbar = document.getElementById("thcrap__searchbar") as HTMLInputElement;
const patchlist = document.getElementById("thcrap__patchlist") as HTMLDivElement;
const thcrapContinueBtn = document.getElementById("thcrap__continue") as HTMLButtonElement;
const currentFile = document.getElementById("thcrap__currentfile") as HTMLSpanElement;
const thcrap = new thcrapDownloader();
const json = await thcrap.getBranchInfo();
delete json["version-resolve-fix"];

const branchMap = new Map<string, string>();
const patchMap = new Map<string, string>();

const priorityPatches = ["lang_en", "lang_en-4kids", "lang_en-ca", "lang_en-literal", "lang_es", "lang_es-419", "lang_fr", "lang_it", "lang_ko", "lang_ru", "lang_zh-hans", "lang_zh-hant", "lang_en-tyke", "lang_en-yoda"];
const patchItems: string[] = [];

Object.keys(json).forEach((branch) => {
    const branchName = branch.charAt(0).toUpperCase() + branch.slice(1);
    const option = document.createElement("div");
    option.textContent = branchName;
    branchMap.set(branch, thcrap.url + "/" + json[branch].latest);
    branchList.appendChild(option);
    option.addEventListener("click", () => {
        selectedItem.textContent = branchName;
        collapseInput(branchList, option);
    });
});

selectedItem.textContent = branchList.children[0].textContent;

selectedItem.addEventListener("click", () => {
    collapseInput(branchList, branchList.children[0]);
})

function collapseInput(element: HTMLElement, branchItem?: Element) {
    // Unfortunately we have to do calculations here, because webkit2gtk doesn't support calc-size() yet.
    const branchItemHeight = branchItem ? branchItem.clientHeight * element.children.length : 48;
    element.style.height = element.style.height === "0px" ? `${branchItemHeight}px` : "0px";
}

if (await fs.exists(APPDATA_PATH + "/thcrap")) {
    const repo = await loadReposFile();
    await initPatchlist(repo);

}

downloadButton.addEventListener("click", async () => {
    const branch = selectedItem.textContent?.toLowerCase();
    if (!branch) throw new Error("Branch not selected!");
    const url = branchMap.get(branch);
    if (!url) throw new Error("Could not resolve branch URL! Attempted to resolve branch: " + branch);
    let totalBytes = 0;
    await download(url, APPDATA_PATH + "/thcrap.zip", (payload) => {
        totalBytes += payload.progress;
        const total = ((totalBytes / payload.total) * 100);
        progressbar.dataset.progress = total.toString();
        // Cursed math to get a gradient color from red to green.
        const percentageRGB = total / 100
        const red = Math.floor(255 + (87 - 255) * percentageRGB);
        const green = Math.floor(0 + (255 - 0) * percentageRGB);
        const blue = Math.floor(0 + (87 - 0) * percentageRGB);
        const color = `rgb(${red}, ${green}, ${blue})`;
        progressbar.style.width = `${total}%`;
        progressbar.style.backgroundColor = color;
        progresstext.innerText = `${Math.round(total)}%`;
    });
    progresstext.innerText = "Extracting...";
    await unzip(APPDATA_PATH + "/thcrap.zip", APPDATA_PATH + "/thcrap");
    progresstext.innerText = "Done!";
    await fs.remove(APPDATA_PATH + "/thcrap.zip");
    const repo = await loadReposFile();
    const patches = thcrap.crawlNeighbors(repo.neighbors);
    console.log(patches)
    await initPatchlist(repo);
})

async function loadReposFile() {
    const reposFile = await fs.readTextFile(APPDATA_PATH + "/thcrap/repos/thpatch/repo.js");
    const repo = JSON.parse(reposFile);
    return repo;
}

// TODO: Add type for repo.
async function initPatchlist(repo: any) {
    const thcrapPatchlistContainer = document.getElementById("thcrap__patchlist-container") as HTMLElement;
    thcrapPatchlistContainer.style.opacity = "1";
    priorityPatches.forEach((patch) => {
        createPatchItem(patch, repo.patches[patch]);
    });
    Object.keys(repo.patches).forEach((patch) => {
        if (!priorityPatches.includes(patch)) {
            createPatchItem(patch, repo.patches[patch]);
        }
    })

    const start = Date.now();
    const patches = await thcrap.crawlNeighbors(repo.neighbors);
    const end = Date.now();
    console.log(`Crawled ${patches.length} patches in ${end - start}ms`);
    await loadPatchesFromPatchList(patches);
}

async function loadPatchesFromPatchList(patchList: thcrapRepoPatch[]) {
    patchList.forEach((patch) => {
        const patchItem = patch.patches;
        const server = patch.server;
        Object.keys(patchItem).forEach((patch) => {
            createPatchItem(patch, patchItem[patch], server);
        })
    });
}

function createPatchItem(patch: string, patchTitle: string, resolveURL?: string) {
    if (patchItems.includes(patch)) return;
    patchItems.push(patch);

    const patchItem = document.createElement("div");
    patchItem.classList.add("thcrap__patch-item");
    const patchTitleElement = document.createElement("abbr");
    patchTitleElement.title = patchTitle;
    patchTitleElement.textContent = patchTitle;
    const patchCheckbox = document.createElement("input");
    patchCheckbox.type = "checkbox";
    patchCheckbox.id = patch;
    if (resolveURL) {
        patchItem.dataset.resolve = resolveURL;
    }
    patchTitleElement.addEventListener("click", () => {
        patchCheckbox.checked = !patchCheckbox.checked;
        if (patchCheckbox.checked) {
            patchMap.set(patch, patchTitle);
        } else {
            patchMap.delete(patch);
        }
    });
    patchCheckbox.addEventListener("click", () => {
        if (patchCheckbox.checked) {
            patchMap.set(patch, patchTitle);
        } else {
            patchMap.delete(patch);
        }
    });

    patchItem.appendChild(patchTitleElement);
    patchItem.prepend(patchCheckbox);
    patchlist.appendChild(patchItem);
}

searchbar.addEventListener("input", () => {
    const search = searchbar.value.toLowerCase();
    const patches = patchlist.children;
    for (let i = 0; i < patches.length; i++) {
        const patch = patches[i] as HTMLElement;
        const patchText = patch.textContent?.toLowerCase();
        if (patchText?.includes(search)) {
            patch.style.display = "block";
        } else {
            patch.style.display = "none";
        }
    }
})

thcrapContinueBtn.addEventListener("click", async () => {
    console.log("Downloading patches...");
    console.log(patchMap);
    const patchesToResolve = Array.from(patchMap.keys());
    const fullPatchList: string[] = [];

    patchesToResolve.forEach(async (patch) => {
        fullPatchList.push(patch);
        const patchInfo = await thcrap.getPatchInfo(patch);
        patchInfo.dependencies.forEach(async (dependency: string) => {
            if (!fullPatchList.includes(dependency)) {
                fullPatchList.push(dependency)
            };
            const fileList = await thcrap.downloadFilesList(dependency);
            logger.info("Got file list for " + dependency);
            // Iterate over the files and download them.
            if (!await fs.exists(`${APPDATA_PATH}/thcrap/repos/`)) {
                await fs.mkdir(`${APPDATA_PATH}/thcrap/repos/`);
            }
            const list = Object.keys(fileList);

            for (let i = 0; i < list.length; i++) {
                const file = list[i];

                if (fileList[file] === null) continue;
                const fileURL = `${thcrap.mirror}/${dependency}/${file}`;
                const filePath = `${APPDATA_PATH}/thcrap/repos/${dependency}/${file}`;
                const folderPath = filePath.substring(0, filePath.lastIndexOf("/"));
            
                if (await fs.exists(`thcrap/repos/${dependency}/${file}`, { baseDir: fs.BaseDirectory.AppData })) {
                    continue;
                }
                if (!await fs.exists(`thcrap/repos/${dependency}/`, { baseDir: fs.BaseDirectory.AppData })) {
                    await fs.mkdir(`thcrap/repos/${dependency}/`, { recursive: true, baseDir: fs.BaseDirectory.AppData });
                }
                if (!await fs.exists(folderPath)) {
                    await fs.mkdir(folderPath, { recursive: true });
                }
                currentFile.textContent = file;
                await downloadFile(fileURL, folderPath);
            }
            
            logger.info(`Downloaded all files for ${dependency}!`);
            currentFile.textContent = "Done!";
        });

        /* 
            Now, we have to save the patch file.
            - if it's a language patch, we have to save it into thcrap/repos/thpatch/<patch name>/patch.js
            - if it's a game patch, we have to save it into thcrap/repos/<REPO + PATCH NAME>/patch.js
            - We can ignore dependencies for now, since we are relying on thcrap's auto updater to resolve any that we somehow missed.
        */
       let path;
        if (thcrap.getURLForPatch(patch) == thcrap.srv) {
            path = `thcrap/repos/thpatch/${patch}`;
        } else {
            path = `thcrap/repos/${patch}`;
        }
        if (!await fs.exists(`${path}/`, { baseDir: fs.BaseDirectory.AppData })) {
            await fs.mkdir(`${path}/`, { recursive: true, baseDir: fs.BaseDirectory.AppData });
        }
        await fs.writeTextFile(`${path}/patch.js`, JSON.stringify(patchInfo), { baseDir: fs.BaseDirectory.AppData });

        logger.info(`Downloaded patch ${patch}!`);

        // Now, we have to create a config file for the patch.
        await createConfigFile(fullPatchList, patch);
    });
});


async function createConfigFile(patchlist: string[], patchName: string) {
    const config: thcrapConfigFile = {
        console: false,
        dat_dump: false,
        patched_files_dump: false,
        patches: []
    }
    patchlist.forEach((patch) => {
        if (patch.includes("/")) {
            config.patches.push({
                archive: `repos/${patch}`
            });
        } else {
            config.patches.push({
                archive: `repos/thpatch/${patch}`
            });
        }

    });
    if (!await fs.exists("thcrap/config/", { baseDir: fs.BaseDirectory.AppData })) {
        await fs.mkdir("thcrap/config/", { baseDir: fs.BaseDirectory.AppData });
    }
    await fs.writeTextFile(`thcrap/config/${patchName}.js`, JSON.stringify(config), { baseDir: fs.BaseDirectory.AppData });
}

async function downloadFile(fileURL: string, folderPath: string) {
    return new Promise(async (resolve, reject) => {
        try {
            await download(fileURL, folderPath + "/" + fileURL.substring(fileURL.lastIndexOf("/") + 1));
            resolve(null);
        } catch (e) {
            reject(e);
        }

    });
}