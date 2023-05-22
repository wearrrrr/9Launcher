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

type gameObject = {
    "long_title": string,
    "short_title": string
    "img": string,
    "img_unset": string,
    "url_trial": string,
    "release_year": number,
    "game_id": string
}

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
        logger("Wine unzipped!", "success");
    })
}

const downloadWine = async (archiveName: string) => {
    if (progressBar !== null || progressBar !== undefined) {
        progressBar.resetProgressBar();
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
                progressBar.updateProgressBar(totalBytesDownloaded, total);
            }
        }
    ).then(async () => {
        console.log("Download complete... Unzipping wine!")
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.unzipBegin();
        }
        unzip(wineArchive, wineDir);
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.finalizeProgressBar();
        }
    })
    return "Wine downloaded!";
}

async function checkWineExists() {
    let proton755 = await fs.exists(await path.appDataDir() + "wine/GE-Proton7-55/files/bin/wine");
    let proton81 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-1/files/bin/wine");
    let proton82 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-2/files/bin/wine");
    let proton83 = await fs.exists(await path.appDataDir() + "wine/GE-Proton8-3/files/bin/wine");

    if (proton755 == false && proton81 == false && proton82 == false && proton83 == false) {
        if (progressBar !== null || progressBar !== undefined) {
            progressBar.openModal();
        }
    }
}

const checkIfWineIsNeeded = async () => {
    const platform = await infoManager.getPlatform();
    if (platform == "win32") {
        console.log("Windows detected, skipping wine check!")
    } else {
        await checkWineExists();
    }
}
checkIfWineIsNeeded();

let pc98 = ["th01", "th02", "th03", "th04", "th05"]

async function launchGame(gameObj: gameObject) {
    let gamePath = getGameFile(gameObj.game_id);
    let command;
    if (pc98.includes(gameObj.game_id)) {
        switch (await infoManager.getPlatform()) {
            case "win32":
                // TODO: Add PC-98 support for Windows
                console.log("Windows Unsupported Currently, sorry!")
                break;
            case "linux":
                console.log("Linux detected, running with dosbox-x!")
                command = new Command("dosbox-x", ["-c", `IMGMOUNT A: ${gamePath}`, "-c", "A:", "-c", "autoexec.bat", "-nopromptfolder", "-set", "machine=pc98"], { cwd: await path.appDataDir()});
                break;
        }
    } else {
        switch (await infoManager.getPlatform()) {
            case "win32":
                console.log("Windows detected, running with cmd!")
                command = new Command('cmd', ['/c', gamePath], { cwd: getGamePath(gameObj.game_id) });
                break;
            case "linux":
                console.log("Linux detected, running with wine!")
                console.log(getGamePath(gameObj.game_id))
                console.log(gamePath)
                command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
                break;
            case "darwin":
                console.log("MacOS detected, running with wine!")
                setTimeout(() => {
                    command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
                }, 500);
                break;
            default:
                console.log("Unknown OS detected, attempting to run with wine! (assuming POSIX based OS)")
                setTimeout(() => {
                    command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
                }, 500);
                break;
            }
    }
    command?.on('close', data => {
        console.log(`command finished with code ${data.code} and signal ${data.signal}`)
    });
    command?.on('error', error => console.error(`command error: "${error}"`));
    command?.stdout.on('data', line => console.log(`command stdout: "${line}"`));
    command?.stderr.on('data', line => console.log(`command stderr: "${line}"`));
    const child = await command?.spawn();
    console.log('pid:', child?.pid);
}

async function installGamePrompt(name: string, value: gameObject, gameCard: HTMLElement) {
    await dialog.open({
        multiple: false,
        directory: false,
        filters: [{
            name: `${name} Executable`,
            extensions: ['exe', 'hdi']
        }]
    }).then(async (file) => {
        if (file !== null) {
            const pathComponents: string[] = file.toString().split("/");
            pathComponents.pop();
            const filePath: string = pathComponents.join("/");
            gameCard.style.background = `url(assets/game-images/${value.img})`;
            let gameObject = {
                name: name,
                img: value.img,
                file: file,
                path: filePath
            }
            await messageBox(`${value.short_title} added to library!`, "Success");
            localStorage.setItem(name, JSON.stringify(gameObject));
            window.location.reload();
        } else {
            logger("No File Selected!", "error")
        }
    })
}

let installedGames = installedGamesIterator();

function addGame(name: string, value: gameObject, gamesElement: HTMLDivElement) {
    const gameCard = document.createElement("div");
    gameCard.classList.add('game-card');
    gameCard.dataset.added = value.img;
    gameCard.id = name;
    gameCard.style.background = `url(assets/game-images/${value.img_unset})`;
    gameCard.innerHTML = `
        <div class="game-card__info ${name}">
            <p class="game-card__title">${value.short_title}</p>
        </div>
    `;
    const checkInstallStatus = installedGames.includes(name);
    if (checkInstallStatus) {
        gameCard.style.background = `url(assets/game-images/${value.img})`;
    }
    gamesElement.appendChild(gameCard);
    gameCard.addEventListener('contextmenu', async (e) => {
        e.preventDefault();
        removeGame(name, value, gameCard);
    })
    if (checkInstallStatus) {
        gameCard.style.background = `url(assets/game-images/${value.img})`;
        gameCard.addEventListener('click', async () => {
            launchGame(games.all[name as keyof typeof games.all]);
        })
    } else {
        gameCard.addEventListener('click', async () => {
            installGamePrompt(name, value, gameCard);
        });
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
            logger("Cancelled game removal!", "info")
        }
    } else {
        logger("Game not installed!", "error")
    }
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
}
export var totalBytesDownloaded: any;
export var total: any;
export default funcs;
export type { gameObject }