import games from '../assets/games.json';
import gameIterator from './lib/games';


const classicGames = document.getElementById('pc-98') as HTMLDivElement;
const gameGrid = document.getElementById('modern-era') as HTMLDivElement;
const nextStep = document.getElementById('next-step') as HTMLDivElement

for (const [name, value] of Object.entries(games["pc-98"])) {
    addGame(name, value)
};

for (const [name, value] of Object.entries(games.modern)) {
    addGame(name, value);
}

for (const [name, value] of Object.entries(games.spinoffs)) {
    addGame(name, value);
}

function addGame(name: string, value: any) {
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
    gameGrid.append(gameCard)
    gameCard.addEventListener('click', async () => {
        gameIterator.installGamePrompt(name, value, gameCard);
    })
}

nextStep.addEventListener('click', () => {
    nextStep.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><style> .spinner_ajPY{transform-origin:center;animation:spinner_AtaB .75s infinite linear; fill: white; } .spinner_aJdX { fill: white; } @keyframes spinner_AtaB{100%{transform:rotate(360deg)}}</style><path d="M12,1A11,11,0,1,0,23,12,11,11,0,0,0,12,1Zm0,19a8,8,0,1,1,8-8A8,8,0,0,1,12,20Z" opacity=".25" class="spinner_aJdX"/><path d="M10.14,1.16a11,11,0,0,0-9,8.92A1.59,1.59,0,0,0,2.46,12,1.52,1.52,0,0,0,4.11,10.7a8,8,0,0,1,6.66-6.61A1.42,1.42,0,0,0,12,2.69h0A1.57,1.57,0,0,0,10.14,1.16Z" class="spinner_ajPY"/></svg>`
    nextStep.style.width = "100px";
    nextStep.style.justifyContent = "center"
    setTimeout(() => {
        window.location.href = "/dashboard.html"
      }, 2000);
})

gameIterator.gameIterator();

