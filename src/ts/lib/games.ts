import { Command } from '@tauri-apps/api/shell';
import { dialog } from '@tauri-apps/api';
import messageBox from './bottombar';
import games from '../../assets/games.json';

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
            game.style.background = `url(/src/assets/game-images/${value.img})`;
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

async function launchGame(gameObj: gameObject) {
    let gamePath = getGameFile(gameObj.game_id);
    console.log(getGamePath(gameObj.game_id));
    const command = new Command('wine', gamePath, { cwd: getGamePath(gameObj.game_id) });
    command.on('close', data => {
    console.log(`command finished with code ${data.code} and signal ${data.signal}`)
    });
    command.on('error', error => console.error(`command error: "${error}"`));
    command.stdout.on('data', line => console.log(`command stdout: "${line}"`));
    command.stderr.on('data', line => console.log(`command stderr: "${line}"`));
    const child = await command.spawn();
    console.log('pid:', child.pid);
}

async function installGamePrompt(name: string, value: gameObject, gameCard: HTMLElement) {
    await dialog.open({
        multiple: false,
        directory: false,
        filters: [{
            name: `${name} Executable`,
            extensions: ['exe']
        }]
    }).then(async (file) => {
        if (file !== null) {
            const pathComponents: string[] = file.toString().split("/");
            pathComponents.pop();
            const filePath: string = pathComponents.join("/");
            gameCard.style.background = `url(/src/assets/game-images/${value.img})`;
            let gameObject = {
                name: name,
                img: value.img,
                file: file,
                path: filePath
            }
            await messageBox(`${value.short_title} added to library!`, "Success")
            localStorage.setItem(name, JSON.stringify(gameObject));
        } else {
            await messageBox(`No file selected!`, "Error")
        }
    })
    window.location.reload();
}

const funcs = {
    gameIterator,
    installedGamesIterator,
    getGameFile,
    getGamePath,
    launchGame,
    installGamePrompt
}
export default funcs;
export type { gameObject }