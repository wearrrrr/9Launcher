import gamesManager from './lib/games';
import games from '../assets/games.json';
import { WebviewWindow } from "@tauri-apps/api/window"
import { window } from "@tauri-apps/api";
import { TauriEvent } from "@tauri-apps/api/event";
import modalManager from './lib/modalManager';
import * as pc98manager from './lib/pc98manager';
import { logger } from './lib/logging';
import { fs } from '@tauri-apps/api';
import infoManager from './lib/infoManager';
import moment from 'moment';

const gameGrid = document.getElementById("games") as HTMLDivElement;
const gamesGridSpinoffs = document.getElementById("games-spinoffs") as HTMLDivElement;

const info = await infoManager.gatherInformation();

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
    localStorage.setItem("9L_beenWarned", "true");
    modalManager.closeModal(wineModal)
});
wineModal.addFooterBtn(`Don't Download (Games won't launch!)`, 'tingle-btn tingle-btn--danger', function() {
    localStorage.setItem("9L_beenWarned", "true");
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

function dosboxUnzipBegin() {
    dosboxProgressBarText.textContent = "Unzipping..."
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

window.appWindow.listen("createLog", async () => {
    if (!await fs.exists("9Launcher.log", { dir: fs.BaseDirectory.AppData })) {
        await fs.writeFile({ path: "9Launcher.log", contents: "" }, { dir: fs.BaseDirectory.AppData })
    }
    await logger.info("9Launcher started!")
    await logger.info("9Launcher version: " + info.version)
    await logger.info("9Launcher OS: " + info.OS)
    await logger.info("9Launcher Kernel Version: " + info.kernelVersion)
    await logger.info("9Launcher Architecture: " + info.architecture)
})

window.getCurrent().listen(TauriEvent.WINDOW_CLOSE_REQUESTED, async () => {
    await logger.info("Closing 9Launcher...")
    // This should never overwrite logs unless they manage to somehow create a race condition where they save two logs at the exact same time
    try {
        await fs.renameFile("9Launcher.log", "9Launcher-" + `${moment().format("MM-DD-mm_ss-YYYY")}` + ".log", { dir: fs.BaseDirectory.AppData })
        window.getCurrent().close();
    } catch {
        await logger.error("Couldn't save log file")
        window.getCurrent().close();
    }

});

if (localStorage.getItem("console-logging") !== "enabled") {
    document.getElementById("console")?.remove();
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
    dosboxUnzipBegin,
    dosboxFinalizeProgressBar,
    dosboxResetProgressBar,
}

export default funcs;