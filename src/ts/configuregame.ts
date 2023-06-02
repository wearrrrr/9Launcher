import games from '../assets/games.json';
import * as dialog from "@tauri-apps/api/dialog"
import * as fs from "@tauri-apps/api/fs"
import * as path from "@tauri-apps/api/path"
import { logger } from "./lib/logging";
import { emit } from "@tauri-apps/api/event"

const urlParams = new URLSearchParams(window.location.search);
const gameID = urlParams.get('id')

if (!gameID || games.validIDs.includes(gameID) === false) {
    throw new Error('No game ID provided')
}

const game = games.all[gameID as keyof typeof games.all]

let customImagesDir = await path.appDataDir() + 'custom-img/'
let title = document.getElementById('game-title')
let gameImage = document.getElementById('game-image')

async function setupConfigureMenu() {
    if (title === null) throw new Error("Couldn't find game title element")
    title.textContent += game.short_title + ": "
    if (gameImage === null) throw new Error("Couldn't find game image element")
    if (game.img === null) throw new Error("Game image is null")
    gameImage.setAttribute('src', "/assets/game-images/" + game.img)
    let deleteGame = document.getElementById('delete-game')
    if (deleteGame === null) throw new Error("Couldn't find delete game element")
    deleteGame.addEventListener('click', async () => {
        removeGame()
    })
}
setupConfigureMenu()
async function removeGame() {
            let confirm = await dialog.confirm("This will remove the game from your library, but will not delete the game files.", `Remove ${game.short_title}?`);
            if (confirm) {
                emit("delete-game", game.game_id)
                window.close();
            } else {
                logger("Cancelled game removal!", "info")
            }
}

async function setCurrentImage() {
    if (!await fs.exists(customImagesDir + game.game_id + '.png')) return
    let image = await fs.readBinaryFile(customImagesDir + game.game_id + '.png')
    let blob = new Blob([image], { type: 'image/png' })
    let url = URL.createObjectURL(blob)
    if (gameImage === null) throw new Error("Couldn't find game image element")
    gameImage.setAttribute('src', url)
}
setCurrentImage()

async function setNewImage() {
    
    if (!await fs.exists(customImagesDir)) {
        await fs.createDir(customImagesDir)
    }
    let newImage = await dialog.open({
        multiple: false,
        directory: false,
        filters: [
        { 
            name: "Images",
            extensions: ["jpg", "png", "gif"]
        }
        ]
    })
    if (newImage === undefined) return
    fs.copyFile((newImage as string), customImagesDir + game.game_id + '.png')
    let image = await fs.readBinaryFile(customImagesDir + game.game_id + '.png')
    let blob = new Blob([image], { type: 'image/png' })
    let url = URL.createObjectURL(blob)
    if (gameImage === null) throw new Error("Couldn't find game image element")
    gameImage.setAttribute('src', url)
    emit("refresh-page")
    window.location.reload()
}

async function resetImage() {
    if (!await fs.exists(customImagesDir + game.game_id + '.png')) return
    fs.removeFile(await path.appDataDir() + 'custom-img/' + game.game_id + '.png')
    gameImage!.setAttribute('src', "/assets/game-images/" + game.img)
    emit("refresh-page")
    window.location.reload()
}

document.getElementById('image-setting-change')?.addEventListener('click', setNewImage)
document.getElementById('image-setting-reset')?.addEventListener('click', resetImage)
let showText = document.getElementById('show-text') as HTMLInputElement
showText?.addEventListener('click', async () => {
    await fs.writeTextFile(game.game_id + "-show-text", showText.checked.toString(), { dir: fs.BaseDirectory.AppData })
})