import LSUtils from './utils/handleLocalStorage';
import games from '../assets/games.json';

const urlParams = new URLSearchParams(window.location.search);
const gameID = urlParams.get('id')

if (!gameID || games.validIDs.includes(gameID) === false) {
    throw new Error('No game ID provided')
}

const game = games.all[gameID as keyof typeof games.all]

const LSJSON = localStorage.getItem(game.game_id)

let LSItem;

if (LSJSON) {
    LSItem = LSUtils.deserializeLSObject(LSJSON)
}



let title = document.getElementById('game-title')
if (title === null) throw new Error("Couldn't find game title element")
title.textContent += game.short_title + ": "
let gameImage = document.getElementById('game-image')
if (gameImage === null) throw new Error("Couldn't find game image element")
gameImage.setAttribute('src', "/assets/game-images/" + game.img)

async function setNewImage() {
    
}
