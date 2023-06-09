import gamesManager from './lib/games';
import games from '../assets/games.json';
import { WebviewWindow } from "@tauri-apps/api/window"
import modalManager from './lib/modalManager';
import * as pc98manager from './lib/pc98manager';
// TODO: Support for .5 games

// const pc98Games = ['th01', 'th02', 'th03', 'th04', 'th05']
// const modernGames = ['th06', 'th07', 'th08', 'th09', 'th10', 'th11', 'th12', 'th13', 'th14', 'th15', 'th16', 'th17', 'th18', 'th19']

localStorage.setItem('setupStatus', 'true');

const gameGrid = document.getElementById("games") as HTMLDivElement;
const gamesGridSpinoffs = document.getElementById("games-spinoffs") as HTMLDivElement;

for (const [name, value] of Object.entries(games["pc-98"])) {
    await gamesManager.addGame(name, value, gameGrid)
};

for (const [name, value] of Object.entries(games.modern)) {
    await gamesManager.addGame(name, value, gameGrid);
}

for (const [name, value] of Object.entries(games.spinoffs)) {
    await gamesManager.addGame(name, value, gamesGridSpinoffs);
}

var wineModal = modalManager.createNewModal({
    footer: true,
    stickyFooter: false,
    closeMethods: [], 
    beforeClose: function() {
        return true;
    }
});
wineModal.setContent(`
<h2 class="modal-title">Warning! No Wine builds installed! Open wine manager?</h2>
<div class="progress-bar" id="progress-bar">
    <div id="progress-bar-progress"><p id="progress-bar-text">0%</p></div>
</div>`);
wineModal.addFooterBtn('Download', 'tingle-btn tingle-btn--primary', function() {
    openWineManager()
    modalManager.closeModal(wineModal)
});
wineModal.addFooterBtn(`Don't Download (Games won't launch!)`, 'tingle-btn tingle-btn--danger', function() {
    modalManager.closeModal(wineModal)
});

function wineOpenModal() {
    modalManager.openModal(wineModal);
}

var dosboxModal = modalManager.createNewModal({
    footer: true,
    stickyFooter: false,
    closeMethods: [],
    beforeClose: function() {
        return true;
    }
});
dosboxModal.setContent(`
<h2 class="modal-title">Download PC-98 Emulator now?</h2>
<div class="progress-bar" id="dosbox-progress-bar">
    <div id="dosbox-progress-bar-progress"><p id="dosbox-progress-bar-text">0%</p></div>
</div>`);
dosboxModal.addFooterBtn('Download', 'tingle-btn tingle-btn--primary', function() {
    pc98manager.default.downloadDosbox();
})
dosboxModal.addFooterBtn(`Don't Download (PC-98 games won't work!)`, 'tingle-btn tingle-btn--danger', function() {
    modalManager.closeModal(dosboxModal)
})

function dosboxOpenModal() {
    modalManager.openModal(dosboxModal);
}

const dosboxProgressBarProgress = document.getElementById("dosbox-progress-bar-progress") as HTMLDivElement;
const dosboxProgressBarText = document.getElementById("dosbox-progress-bar-text") as HTMLDivElement;

function dosboxUpdateProgressBar(totalDownloaded: number, total: number) {
    const percentage = Math.round((totalDownloaded / total) * 100);
    dosboxProgressBarProgress.style.width = percentage + "%";
    dosboxProgressBarText.textContent = percentage + "%";
}

function dosboxFinalizeProgressBar() {
    dosboxProgressBarProgress.style.width = "100%"
    setTimeout(() => {
        dosboxModal.close();
        dosboxResetProgressBar();
    }, 500);
}

function dosboxResetProgressBar() {
    dosboxProgressBarProgress.style.width = "0%"
}


const progressBarProgress = document.getElementById("progress-bar-progress") as HTMLDivElement;
const progressBarText = document.getElementById("progress-bar-text") as HTMLDivElement;

function wineUpdateProgressBar(totalDownloaded: number, total: number) {
        const percentage = Math.round((totalDownloaded / total) * 100);
        progressBarProgress.style.width = percentage + "%";
        progressBarText.textContent = percentage + "%";
    
}

function wineFinalizeProgressBar() {
    progressBarProgress.style.width = "100%"
    setTimeout(() => {
        wineModal.close();
    }, 500);
}

function wineUnzipBegin() {
    progressBarProgress.textContent = "Unzipping..."
}

function wineResetProgressBar() {
    progressBarProgress.style.width = "0%"
}

function openWineManager() {
    new WebviewWindow('wine-manager', {
        url: 'wine-manager/',
        title: 'Wine Manager',
        width: 500,
        height: 400,
        resizable: false,
    })
}

const funcs = {
    wineUpdateProgressBar,
    wineFinalizeProgressBar,
    wineResetProgressBar,
    wineOpenModal,
    wineUnzipBegin,
    openWineManager,
    dosboxOpenModal,
    dosboxUpdateProgressBar,
    dosboxFinalizeProgressBar,
    dosboxResetProgressBar,
}

export default funcs;