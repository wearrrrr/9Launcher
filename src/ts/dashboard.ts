import gamesManager from './lib/games';
import games from '../assets/games.json';
import { WebviewWindow } from "@tauri-apps/api/window"
import modalManager from './lib/modalManager';
// TODO: Support for .5 games

// const pc98Games = ['th01', 'th02', 'th03', 'th04', 'th05']
// const modernGames = ['th06', 'th07', 'th08', 'th09', 'th10', 'th11', 'th12', 'th13', 'th14', 'th15', 'th16', 'th17', 'th18', 'th19']

localStorage.setItem('setupStatus', 'true');

const gameGrid = document.getElementById("games") as HTMLDivElement;
const gamesGridSpinoffs = document.getElementById("games-spinoffs") as HTMLDivElement;

for (const [name, value] of Object.entries(games["pc-98"])) {
    gamesManager.addGame(name, value, gameGrid)
};

for (const [name, value] of Object.entries(games.modern)) {
    gamesManager.addGame(name, value, gameGrid);
}

for (const [name, value] of Object.entries(games.spinoffs)) {
    gamesManager.addGame(name, value, gamesGridSpinoffs);
}

var modal = modalManager.createNewModal({
    footer: true,
    stickyFooter: false,
    closeMethods: [], 
    beforeClose: function() {
        return true;
    }
})
modal.setContent(`
<h2 class="modal-title">Warning! No Wine builds installed! Open wine manager?</h2>
<div class="progress-bar" id="progress-bar">
    <div id="progress-bar-progress"><p id="progress-bar-text">0%</p></div>
</div>`);
modal.addFooterBtn('Download', 'tingle-btn tingle-btn--primary', function() {
    openWineManager()
    modalManager.closeModal(modal)
});
modal.addFooterBtn(`Don't Download (Games won't launch!)`, 'tingle-btn tingle-btn--danger', function() {
    modalManager.closeModal(modal)
});

function openModal() {
    modalManager.openModal(modal);
}


const progressBarProgress = document.getElementById("progress-bar-progress") as HTMLDivElement;
const progressBarText = document.getElementById("progress-bar-text") as HTMLDivElement;

function updateProgressBar(totalDownloaded: number, total: number) {
        const percentage = Math.round((totalDownloaded / total) * 100);
        openWineManager();
        progressBarProgress.style.width = percentage + "%";
        progressBarText.textContent = percentage + "%";
    
}

function finalizeProgressBar() {
    progressBarProgress.style.width = "100%"
    setTimeout(() => {
        modal.close();
    }, 500);
}

function unzipBegin() {
    progressBarProgress.textContent = "Unzipping..."
}

function resetProgressBar() {
    progressBarProgress.style.width = "0%"
}

function openWineManager() {
    new WebviewWindow('wine-manager', {
        url: 'wine-manager.html',
        title: 'Wine Manager',
        width: 500,
        height: 400,
        resizable: false,
    })
}

const funcs = {
    updateProgressBar,
    finalizeProgressBar,
    resetProgressBar,
    openModal,
    unzipBegin,
    openWineManager
}

export default funcs;