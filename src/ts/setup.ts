import games from '../assets/games.json';

const gameGrid = document.getElementById('modern-era') as HTMLDivElement;

for (const [name, value] of Object.entries(games.modern)) {
    const gameCard = document.createElement('div') as HTMLDivElement;
    gameCard.classList.add('game-card');
    gameCard.style.background = `url(/src/assets/game-images/${value.img})`;
    gameCard.style.backgroundSize = 'cover';
    gameCard.style.backgroundPosition = 'center';
    gameCard.innerHTML = `
        <div class="game-card__info ${name}">
            <p class="game-card__title">${value.short_title}</p>
        </div>
    `;
    gameGrid.append(gameCard)
}

console.log(games)