import gamesManager from './lib/games';
import games from '../assets/games.json';

// TODO: Support for .5 games

// const pc98Games = ['th01', 'th02', 'th03', 'th04', 'th05']
// const modernGames = ['th06', 'th07', 'th08', 'th09', 'th10', 'th11', 'th12', 'th13', 'th14', 'th15', 'th16', 'th17', 'th18', 'th19']



// function getInstalledGames() {
//     // TODO: This later should return a splash screen of no games being installed!!
//     if (gamesManager.installedGamesIterator().length == 0) throw new Error("Post Setup Install screen not yet implemented... Aborting now.")
//     let installedGames = gamesManager.installedGamesIterator();
//     let installedList = document.getElementById("installed-games");
//     if (installedList == null) throw new Error("Installed games list not found! Aborting now.");
//     for (let i = 0; i < installedGames.length; i++) {
//         const gameKey = installedGames[i] as keyof typeof games.all;
//         console.log(games.all[gameKey].game_id);
//         let game = document.createElement('div');
//         let gameObjectAccessor = games.all[gameKey];
//         game.classList.add('installed-game');
//         game.innerHTML = `
//             <div class="game-card__info ${gameObjectAccessor.game_id}">
//                 <p class="game-card__title">${gameObjectAccessor.short_title}</p>
//             </div>`;
//         game.style.background = `url(/src/assets/game-images/${gameObjectAccessor.img})`;
//         game.style.backgroundSize = "cover";
//         game.addEventListener("click", () => {
//             gamesManager.launchGame(gameObjectAccessor);
//         })
//         installedList.append(game)
//     }
// }
// getInstalledGames()
const gameGrid = document.getElementById("games") as HTMLDivElement;
const gamesGridSpinoffs = document.getElementById("games-spinoffs") as HTMLDivElement;
let installedGames = gamesManager.installedGamesIterator();

for (const [name, value] of Object.entries(games["pc-98"])) {
    addGame(name, value)
};

for (const [name, value] of Object.entries(games.modern)) {
    addGame(name, value);
}

for (const [name, value] of Object.entries(games.spinoffs)) {
    addGame(name, value, gamesGridSpinoffs);
}

function addGame(name: string, value: any, gamesElement: HTMLDivElement = gameGrid as HTMLDivElement) {
    const gameCard = document.createElement('div') as HTMLDivElement;
    gameCard.classList.add('game-card');
    gameCard.dataset.added = value.img;
    gameCard.id = name;
    gameCard.style.background = `url(/src/assets/game-images/${value.img_unset})`;
    gameCard.innerHTML = `
        <div class="game-card__info ${name}">
            <p class="game-card__title">${value.short_title}</p>
        </div>
    `;
    const checkInstallStatus = installedGames.includes(name);
    if (checkInstallStatus) {
        gameCard.style.background = `url(/src/assets/game-images/${value.img})`;
        gameCard.addEventListener('click', async () => {
            gamesManager.launchGame(games.all[name as keyof typeof games.all]);
        })
    } else {
        gameCard.addEventListener('click', async () => {
            gamesManager.installGamePrompt(name, value, gameCard);
        });
    }
    gamesElement.append(gameCard)
}