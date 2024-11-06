import { thcrapDownloader } from "./thcrap";
import { APPDATA_PATH } from "./globals";
import * as fs from "@tauri-apps/plugin-fs";
import { download } from "@tauri-apps/plugin-upload";
import { unzip } from "./utils/unzip";
const branchList = document.getElementById("thcrap__branch-list-items")!
const selectedItem = document.getElementById("thcrap__branch-list-selected")!
const downloadButton = document.getElementById("thcrap__download-btn") as HTMLButtonElement;
const progressbar = document.getElementById("thcrap__download-progressbar")!;
const progresstext = document.getElementById("thcrap__download-progress-text") as HTMLSpanElement;
const searchbar = document.getElementById("thcrap__searchbar") as HTMLInputElement;
const patchlist = document.getElementById("thcrap__patchlist") as HTMLDivElement;
const thcrapContinueBtn = document.getElementById("thcrap__continue") as HTMLButtonElement;
const thcrap = new thcrapDownloader();
const json = await thcrap.getBranchInfo();
delete json["version-resolve-fix"];

const branchMap = new Map<string, string>();
const patchMap = new Map<string, string>();

const priorityPatches = ["lang_en", "lang_en-4kids", "lang_en-ca", "lang_en-literal", "lang_es", "lang_es-419", "lang_fr", "lang_it", "lang_ko", "lang_ru", "lang_zh-hans", "lang_zh-hant", "lang_en-tyke", "lang_en-yoda"];

Object.keys(json).forEach((branch) => {
    const branchName = branch.charAt(0).toUpperCase() + branch.slice(1);
    const option = document.createElement("div");
    option.textContent = branchName;
    branchMap.set(branch, thcrap.url + json[branch].latest);
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
    loadReposFile();
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
    loadReposFile();
})

async function loadReposFile() {
    const reposFile = await fs.readTextFile(APPDATA_PATH + "/thcrap/repos/thpatch/repo.js");
    const repos = JSON.parse(reposFile);
    const thcrapPatchlistContainer = document.getElementById("thcrap__patchlist-container") as HTMLElement;
    thcrapPatchlistContainer.style.opacity = "1";
    priorityPatches.forEach((patch) => {
        createPatchItem(patch, repos.patches[patch]);
    });
    Object.keys(repos.patches).forEach((patch) => {
        if (!priorityPatches.includes(patch)) {
            createPatchItem(patch, repos.patches[patch]);
        }
    })
}

function createPatchItem(patch: string, patchTitle: string) {
    const patchItem = document.createElement("div");
    const patchTitleElement = document.createElement("span");
    patchTitleElement.textContent = patchTitle;
    const patchCheckbox = document.createElement("input");
    patchCheckbox.type = "checkbox";
    patchCheckbox.id = patch;
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

    patchesToResolve.forEach(async (patch) => {
        const patchInfo = await thcrap.getPatchInfo(patch);
        console.log(patchInfo);
        patchInfo.dependencies.forEach(async (dependency: string) => {
            const dependencyInfo = await thcrap.fetchDependency(dependency);
            console.log(dependencyInfo);
        });
    });
})