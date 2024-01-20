import { Command } from '@tauri-apps/api/shell';
import { dialog } from '@tauri-apps/api';
import * as fs from "@tauri-apps/api/fs";
import * as path from "@tauri-apps/api/path";
import messageBox from './bottombar';
import games from '../../assets/games.json';
import infoManager from './infoManager';
import { download } from "tauri-plugin-upload-api";
import progressBar from '../dashboard';
import { logger } from './logging';
import { WebviewWindow } from "@tauri-apps/api/window"
import { listen } from '@tauri-apps/api/event';
import { invoke } from '@tauri-apps/api/tauri';
import { platform } from '@tauri-apps/api/os';
import { returnCode, payloadJSON } from './types/types';

type gameObject = {
    "long_title": string,
    "short_title": string
    "img": string,
    "img_unset": string,
    "url_trial": string,
    "release_year": number,
    "game_id": string
}

let currPlatform = await infoManager.getPlatform();

function gameIterator() {
    for (const [name, value] of Object.entries(games.modern)) {
        if (localStorage.getItem(name) !== null) {
            let game = document.getElementById(name)
            if (game == null) throw new Error("Game element not found, despite being set in localStorage! Try clearing localStorage.")
            game.style.background = `url(assets/game-images/${value.img})`;
        }
    }
}

function installedGamesIterator() {
    let installedGames = []
    for (const [name] of Object.entries(games["pc-98"])) {
        if (localStorage.getItem(name) !== null) {
            installedGames.push(name)
        }
    }
    for (const [name] of Object.entries(games.modern)) {
        if (localStorage.getItem(name) !== null) {
            installedGames.push(name)
        }
    }
    return installedGames
}

function getGameFile(gameID: string) {
    if (games.validIDs.includes(gameID) == false) throw new Error("Invalid game ID! Valid game IDs are: " + games.validIDs.join(", "));
    let gamePath = localStorage.getItem(gameID);
    let gamePathParsed = JSON.parse(gamePath as string)
    if (gamePath == null) throw new Error("Game path not found! Try clearing localStorage.")
    return gamePathParsed.file
}

// function getGameLocation(gameID: string) {
//     if (games.validIDs.includes(gameID) == false) throw new Error("Invalid game ID! Valid game IDs are: " + games.validIDs.join(", "));
//     let gamePath = localStorage.getItem(gameID);
//     let gamePathParsed = JSON.parse(gamePath as string)
//     if (gamePath == null) throw new Error("Game path not found! Try clearing localStorage.")
//     return gamePathParsed.path
// }

function getGamePath(gameID: string) {
    if (games.validIDs.includes(gameID) == false) throw new Error("Invalid game ID! Valid game IDs are: " + games.validIDs.join(", "));
    let gamePath = localStorage.getItem(gameID);
    let gamePathParsed = JSON.parse(gamePath as string)
    if (gamePath == null) throw new Error("Game path not found! Try clearing localStorage.")
    return gamePathParsed.path
}

function unzip(wineArchive: string, wineDir: string) {
    let unzip = new Command('tar', ['xvf', wineArchive, '-C', wineDir], { cwd: wineDir });
    unzip.execute().then(() => {
        logger.success("Wine unzipped!")
    })
}

const downloadWine = async (archiveName: string) => {
    if (progressBar !== null || progressBar !== undefined) {
        progressBar.wineResetProgressBar();
    }
    const wineDir = await path.appDataDir() + "/wine/";
    const wineArchive = await path.appDataDir() + "/wine/" + archiveName;
    const wineFolder = await path.appDataDir() + "/wine/" + archiveName + "/";
    const wineDirExists = await fs.exists(wineDir);
    const wineArchiveExists = await fs.exists(wineArchive);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.createDir(wineDir);
    if (wineArchiveExists) {
        if (wineFolderExists) return console.log("Wine already unzipped... nothing to do!")
        else unzip(wineArchive, wineDir);
    };
    let totalBytesDownloaded = 0;
    await download(
        `https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${archiveName}/${archiveName}.tar.gz`,
        await path.appDataDir() + `/wine/${archiveName}.tar.gz`,
        (progress, total) => {
            totalBytesDownloaded += progress;
            total = total;
            if (progressBar !== null || progressBar !== undefined) {
                progressBar.wineUpdateProgressBar(totalBytesDownloaded, total);
            }
        }
    ).then(async () => {
        logger.info("Download complete... Unzipping wine!")
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.wineUnzipBegin();
        }
        unzip(wineArchive, wineDir);
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.wineFinalizeProgressBar();
        }
    })
    return returnCode.SUCCESS;
}

async function checkWineExists() {
    let proton755 = await fs.exists(await path.appDataDir() + "wine/GE-Proton7-55/files/bin/wine");
    let proton81 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-1/files/bin/wine");
    let proton82 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-2/files/bin/wine");
    let proton83 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-3/files/bin/wine");

    if (proton755 == false && proton81 == false && proton82 == false && proton83 == false) {
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.wineOpenModal();
        }
    }
}

// async function checkDosboxExists() {
//     let dosboxExists = await fs.exists(await path.appDataDir() + "dosbox/dosbox-x");
//     if (dosboxExists == false) {
//         if (progressBar !== undefined ) {
//             progressBar.dosboxOpenModal();
//         }
//     }
// }
// checkDosboxExists();

const checkIfWineIsNeeded = async () => {
    if (currPlatform != "win32") {
        await checkWineExists();    
    }
}
checkIfWineIsNeeded();

let pc98 = ["th01", "th02", "th03", "th04", "th05"]

async function launchGame(gameObj: gameObject) {
    let gamePath = getGameFile(gameObj.game_id);
    let fileExtension = await path.extname(gamePath);
    let command;
    if (pc98.includes(gameObj.game_id)) {
        switch (currPlatform) {
            case "win32":
                // TODO: Add PC-98 support for Windows
                logger.warn("Windows is in very early beta for PC-98 support! There be dragons!")
                command = new Command("cmd", ["/C", `${await path.appDataDir() + 'bin\\x64\\Release\\dosbox-x.exe'}`, "-set", "machine=pc98", "-c", `IMGMOUNT A: ${gamePath}`, "-c", "A:", "-c", "game", "-nopromptfolder"])
                break;
            case "linux":
                logger.info("Linux detected, running with dosbox-x!")
                if (fileExtension == "hdi") {
                    command = new Command("dosbox-x", ["-c", `IMGMOUNT A: "${gamePath}"`, "-c", "A:", "-c", "game", "-nopromptfolder", "-set", "machine=pc98"], { cwd: await path.appDataDir()});
                }
                break;
        }
    } else {

        switch (currPlatform!) {
            case "win32":
                logger.info("Windows detected, running with cmd!")
                command = new Command("cmd", ["/c", gamePath], { cwd: getGamePath(gameObj.game_id) });
                break;
            case "linux":
                logger.info("Linux detected, running with wine!")
                command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
                break;
            default:
                logger.info("Unknown OS detected, attempting to run with wine! (assuming POSIX based OS)")
                setTimeout(() => {
                    command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
                }, 500);
                break;
            }
    }
    if (command === undefined || command === null) {
        // Getting to this codeblock should be impossible, because the switch case has a default...
        // but I guess typescript doesn't know that.
        logger.fatal("Command is undefined or null!")
        return returnCode.ERROR;
    }
    command.on('close', data => {
        logger.info(`Game closed with code ${data.code} and signal ${data.signal}`)
        if (localStorage.getItem("discordRPC") == "enabled") {
            smartSetRichPresence("Browsing Library");
        }
        return returnCode.SUCCESS;
    });
    let hasMismatched = false;
    command.on('error', error => console.error(`command error: "${error}"`));
    command.stdout.on('data', line => console.log(`command stdout: "${line}"`));
    command.stderr.on('data', async (line) => {
        if (line.includes("wine client error:0: version mismatch")) {
            let shouldKillWineserver = confirm("Wine version mismatch detected! Would you like me to kill wineserver and try again?")
            hasMismatched = true;
            // 'aWaIt' hAs nO eFfEct oN tHe tYpE oF tHiS eXpReSsIoN YES IT DOES AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa
            if (await shouldKillWineserver) {
                const killWineserver = new Command("killall", ["wineserver"]);
                killWineserver.execute().then(() => {
                    console.log("Wineserver killed!")
                    launchGame(gameObj);
                })
                return returnCode.WARNING;
            }
        }
        return returnCode.SUCCESS;
    });
    await command.spawn();
    // this lnk support took me like 2 hours to figure out, before I realized that I could just use a pre-made rust parser. Don't be like me.
    if (!hasMismatched) {
        let isLnk = fileExtension == "lnk" ? true : false;
        if (isLnk && await determineIfLnkIsTHCrap(gamePath) == returnCode.SUCCESS) {
            if (localStorage.getItem("discordRPC") == "enabled") {
                smartSetRichPresence("Playing", gameObj.short_title, isLnk);
            }
            return returnCode.SUCCESS;
        } else {
            if (localStorage.getItem("discordRPC") == "enabled") {
                setGameRichPresence("Playing", gameObj.short_title);
            }
            return returnCode.SUCCESS;
        }
        
    }
    return returnCode.SUCCESS;
}

async function determineIfLnkIsTHCrap(filepath: string) {
    // Get array buffer of file, then convert to string, then check if it contains "thcrap"
    let parseResults: parseResults = await invoke("parse_lnk_file", {
        filepath: filepath
    });
    if (parseResults.target_full_path.includes("thcrap_loader.exe")) {
        logger.info("thcrap detected! Enabling advanced rich presence... (this may take a few seconds)")
        return returnCode.SUCCESS;
    } else {
        return returnCode.ERROR;
    }
}

async function installGamePrompt(name: string, value: gameObject, gameCard: HTMLElement) {
    let currentExtensions = ["exe", "lnk", "hdi"]
    if (pc98.includes(value.game_id)) {
        // PC-98 only reasonably supports hdi files, so we don't need to check for anything else.
        currentExtensions = ["hdi"]
    }
    await dialog.open({
        multiple: false,
        directory: false,
        filters: [{
            name: `${name} Executable`,
            extensions: currentExtensions
        }]
    }).then(async (file) => {
        if (file !== null) {
            let filePath: string;
            if (await platform() == "win32") {
                const pathComponents: string[] = file.toString().split("\\");
                pathComponents.pop();
                filePath = pathComponents.join("\\");
            } else {
                const pathComponents: string[] = file.toString().split("/");
                pathComponents.pop();
                filePath = pathComponents.join("/");
            }
            gameCard.style.background = `url(assets/game-images/${value.img})`;
            let gameObject = {
                name: name,
                img: value.img,
                file: file,
                path: filePath,
                showText: true,
            }
            await messageBox(`${value.short_title} added to library!`, "Success");
            localStorage.setItem(name, JSON.stringify(gameObject));
            window.location.reload();
            // This isn't necessary because we are reloading the page, but TS won't shut up about it.
            return returnCode.SUCCESS;
        } else {
            logger.info("No file selected!");
            return returnCode.INFO;
        }
    })
}

let installedGames = installedGamesIterator();

async function gameConfigurator(id: string) {
    new WebviewWindow('configure-game', {
        url: 'configure-game/?id=' + id,
        title: 'Configure Game',
        width: 450,
        height: 300,
        resizable: false,
        center: true,
        fileDropEnabled: false,
        focus: true,
    })
}



await listen("update-game", (event: payloadJSON) => {
    localStorage.setItem(event.payload.gameID, event.payload.updatedData);
    logger.success("Game updated!")
    return returnCode.SUCCESS;
})

await listen("refresh-page", () => {
    window.location.reload();
})

await listen("delete-game", async (event) => {
    if (!installedGamesIterator().includes(<string>event.payload)) return logger.error("Game not found!");
    localStorage.removeItem(<string>event.payload);
    window.location.reload();
})

async function checkForCustomImage(id: string) {
    if (!await fs.exists(await path.appDataDir() + "custom-img/" + id + ".png")) return returnCode.ERROR;
    const retrievedImage = await fs.readBinaryFile(await path.appDataDir() + "custom-img/" + id + ".png");
    try {
        return retrievedImage;
    } catch {
        return returnCode.ERROR;
    }
}

async function addGame(name: string, value: gameObject, gamesElement: HTMLDivElement) {
    const gameCard = document.createElement("div");
    gameCard.classList.add('game-card');
    gameCard.dataset.added = value.img;
    gameCard.id = value.game_id;
    gameCard.style.background = `url(assets/game-images/${value.img_unset})`;
    let title = value.short_title;
    if (localStorage.getItem(name) !== null) {
        if (JSON.parse(localStorage.getItem(name)!).showText == false) {
            console.log("here")
            title = "";
        }
    }
    gameCard.innerHTML = `
        <div class="game-card__info ${name}">
            <p class="game-card__title">${title}</p>
        </div>
    `;
    const checkInstallStatus = installedGames.includes(name);
    // if (checkInstallStatus) {
    //     gameCard.style.background = `url(assets/game-images/${value.img})`;
    //     gameCard.addEventListener('contextmenu', async (e) => {
    //         e.preventDefault();
    //         gameConfigurator(value.game_id);
    //     });
    // } else {
    //     gameCard.addEventListener('contextmenu', async (e) => {
    //         e.preventDefault();
    //     })
    // }
    if (checkInstallStatus) gameCard.style.background = `url(assets/game-images/${value.img})`;
    gameCard.addEventListener('contextmenu', async (e) => {
        if (checkInstallStatus) {
            gameCard.style.background = `url(assets/game-images/${value.img})`;
            e.preventDefault();
            gameConfigurator(value.game_id);
        } else {
            e.preventDefault();
        }
    })
    gamesElement.appendChild(gameCard);
    if (checkInstallStatus) {
        gameCard.addEventListener('click', async () => {
            launchGame(games.all[name as keyof typeof games.all]);
        })
    } else {
        gameCard.addEventListener('click', async () => {
            installGamePrompt(name, value, gameCard);
        });
    }
    if (checkInstallStatus) {
        if (await checkForCustomImage(value.game_id) != returnCode.ERROR) {
            logger.success("Custom image found!")
            const customImage = await checkForCustomImage(value.game_id);
            if (customImage !== returnCode.ERROR) {
                let blob = new Blob([customImage as Uint8Array], { type: 'image/png' });
                let url = URL.createObjectURL(blob);
                gameCard.style.background = `url(${url})`;
            }
        }
    }
}

async function removeGame(name: string, value: gameObject, gameCard: HTMLElement) {
    const checkInstallStatus = installedGames.includes(name);
    if (checkInstallStatus) {
        let confirm = await dialog.confirm("This will remove the game from your library, but will not delete the game files.", `Remove ${value.short_title}?`);
        if (confirm) {
            localStorage.removeItem(name);
            gameCard.style.background = `url(assets/game-images/${value.img_unset})`;
            gameCard.addEventListener('click', async () => {
                installGamePrompt(name, value, gameCard);
            });
        } else {
            return;
        }
    } else {
        return logger.error("Game not found!");
    }
}

let dataJSONRetryCount = 1;
async function setSmartGameRichPresence(state: string, game_name: string = "") {
    // This only applies for games, so we don't have to worry about the state being "Browsing Library"
    const shmPath = "/dev/shm/9launcher/data.json";
    const shmExists = await fs.exists(shmPath);
    if (!shmExists) {
        if (dataJSONRetryCount > 3) {
            logger.error("Data JSON not found after 3 retries! Falling back to generic rich presence...");
            setGameRichPresence(state, game_name);
            return;
        }
        logger.warn(`Data JSON not found! Retrying in 5 seconds... (${dataJSONRetryCount}/3)`);
        dataJSONRetryCount++;
        setTimeout(() => {
            setSmartGameRichPresence(state, game_name);
        }, 5000)
        return;
    } else {
        logger.success("Data JSON found! Reading...");
        const JSONData = await fs.readTextFile(shmPath);
        try {
            let JSONDataParsed = JSON.parse(JSONData);
            recursiveUpdateSmartRichPresence(state, game_name, JSONDataParsed);
        } catch {
            console.error("Failed to parse shm file! Could be corrupt. Falling back to generic rich presence...");
            setGameRichPresence(state, game_name);
        }
    }
}

function getGameNameFromId(gameID: number) {
    // This function returns a short_title from the game ID that is passed to it. GameID is a number like 0, 1, 2, etc. we will use this to get the data at the index of games.modern
    let gameName = Object.keys(games.modern)[gameID];
    return games.modern[gameName as keyof typeof games.modern].short_title;
}


// TODO: add typing for shmData. It's a JSON object, but I'm lazy.
async function recursiveUpdateSmartRichPresence(state: string, game_name: string = "", shmData: any) {
    const shmPath = "/dev/shm/9launcher/data.json";
    const shmExists = await fs.exists(shmPath);
    if (localStorage.getItem("discordRPC") == "enabled") {
        if (shmData.stage == "0" || shmData.gamestate == "1") {
            shmData.stage = "In Menu"
        } else {
            shmData.stage = `Stage ${shmData.stage}`
        }

        await invoke("update_advanced_game_activity", {
            state: `${getGameNameFromId(shmData.game)} - ${shmData.stage}`,
            details: `${shmData.lives} lives left, ${shmData.bombs} bombs left, ${shmData.score} points`,
            large_image: `${shmData.game}`,
            small_image: `${shmData.game}`,
        })
        if (!shmExists) {
            // Reset the initial timestamp so that elapsed time doesn't carry over to the next launch
            await invoke("reset_initial_timestamp");
            setGameRichPresence("Browsing Library");
            return;
        }
    }
    let newShmData = await fs.readTextFile(shmPath);
    setTimeout(() => {
        recursiveUpdateSmartRichPresence(state, game_name, JSON.parse(newShmData));
    }, 300)
}

async function smartSetRichPresence(state: string, game_name: string = "", isThcrap: boolean = false) {
    console.log(isThcrap)
    if (!isThcrap) {
        setGameRichPresence(state, game_name);
    } else {
        // We can safely assume we are running inside thcrap, so we can gather more information about the game state from lib9launcher
        setSmartGameRichPresence(state, game_name);
    }
}

async function setGameRichPresence(state: string = "Browsing Library", game_name: string = "") {
    
    let appstate;
    if (state == "Playing") {
        appstate = `Playing ${game_name}`;
        await invoke("set_activity_game", {
            state: `${appstate}`,
            details: ``,
        })
    } else {
        appstate = "Browsing Library"
        await invoke("set_activity_generic", {
            state: `${appstate}`,
            details: ``,
        })
    }

}
if (localStorage.getItem("discordRPC") == "enabled") {
    setGameRichPresence("Browsing Library");
}


const funcs = {
    gameIterator,
    installedGamesIterator,
    getGameFile,
    getGamePath,
    launchGame,
    installGamePrompt,
    addGame,
    unzip,
    downloadWine,
    checkForCustomImage,
}
export var totalBytesDownloaded: any;
export var total: any;
export { removeGame, setGameRichPresence }
export default funcs;