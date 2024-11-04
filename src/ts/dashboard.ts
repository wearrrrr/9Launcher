import gamesManager from "./lib/games";
import games from "../assets/games.json";
import { WebviewWindow } from "@tauri-apps/api/webviewWindow";
import { TauriEvent } from "@tauri-apps/api/event";
import modalManager from "./lib/modalManager";
import * as pc98manager from "./lib/pc98manager";
import { logger, attachOnError } from "./lib/logging";
import {} from "@tauri-apps/api";
import moment from "moment";
import { gameObject } from "./lib/types/types";
import { Storage } from "./utils/storage";
import * as fs from "@tauri-apps/plugin-fs";

await attachOnError();

const gameGrid = document.getElementById("games") as HTMLDivElement;
const gamesGridSpinoffs = document.getElementById("games-spinoffs") as HTMLDivElement;

async function loadList(iterator: Record<string, gameObject>, grid: HTMLDivElement) {
    for (const [name, value] of Object.entries(iterator)) {
        await gamesManager.addGame(name, value, grid);
    }
}

export async function loadGamesList() {
    await loadList(games["pc-98"], gameGrid);
    await loadList(games.modern, gameGrid);
    await loadList(games.spinoffs, gamesGridSpinoffs);
}

export async function openWineManager() {
    console.log("Creating webview...")
    // await logger.info("Opening Wine Manager...");
    const ww = new WebviewWindow("wine-manager", {
        url: "wine-manager/",
        title: "Wine Manager",
        width: 500,
        height: 400,
        resizable: false,
    })

    console.log(ww);
}

loadGamesList();

var wineModal = modalManager.createNewModal({
    footer: true,
    stickyFooter: false,
    closeMethods: [],
    beforeClose: function () {
        return true;
    },
});
wineModal.setContent(`
<h2 class="modal-title">Warning! No Wine builds installed! Open wine manager?</h2>
<div class="progress-bar" id="progress-bar">
    <div id="progress-bar-progress"><p id="progress-bar-text">0%</p></div>
</div>
`);
wineModal.addFooterBtn("Download", "tingle-btn tingle-btn--primary", () => {
    console.log("Attempting to open Wine Manager...");
    openWineManager();
    modalManager.closeModal(wineModal);
});
wineModal.addFooterBtn(`Don't Download (Modern Games won't launch!)`, "tingle-btn tingle-btn--danger", () => {
    Storage.set("9L_beenWarned", "true");
    modalManager.closeModal(wineModal);
});

function wineOpenModal() {
    modalManager.openModal(wineModal);
}

var dosboxModal = modalManager.createNewModal({
    footer: true,
    stickyFooter: false,
    closeMethods: [],
    beforeClose: function () {
        return true;
    },
});
dosboxModal.setContent(`
<h2 class="modal-title">Download PC-98 Emulator now?</h2>
<div class="progress-bar" id="dosbox-progress-bar">
    <div id="dosbox-progress-bar-progress"><p id="dosbox-progress-bar-text">0%</p></div>
</div>`);
dosboxModal.addFooterBtn("Download", "tingle-btn tingle-btn--primary", () => {
    pc98manager.default.downloadDosbox();
});
dosboxModal.addFooterBtn(`Don't Download (PC-98 games won't work!)`, "tingle-btn tingle-btn--danger", () => {
    modalManager.closeModal(dosboxModal);
});

function dosboxOpenModal() {
    modalManager.openModal(dosboxModal);
}

const dosboxProgressBarProgress = document.getElementById("dosbox-progress-bar-progress") as HTMLDivElement;
const dosboxProgressBarText = document.getElementById("dosbox-progress-bar-text") as HTMLDivElement;

function dosboxUpdateProgressBar(totalDownloaded: number, total: number) {
    const percentage = Math.round((totalDownloaded / total) * 100);
    dosboxProgressBarProgress.style.width = `${percentage}%`;
    dosboxProgressBarText.textContent = `${percentage}%`;
}

function dosboxUnzipBegin() {
    dosboxProgressBarText.textContent = "Unzipping...";
}

function dosboxFinalizeProgressBar() {
    dosboxProgressBarProgress.style.width = "100%";
    setTimeout(() => {
        dosboxModal.close();
        dosboxResetProgressBar();
    }, 500);
}

function dosboxResetProgressBar() {
    dosboxProgressBarProgress.style.width = "0%";
}

const progressBarProgress = document.getElementById("progress-bar-progress") as HTMLDivElement;
const progressBarText = document.getElementById("progress-bar-text") as HTMLDivElement;

function wineUpdateProgressBar(totalDownloaded: number, total: number) {
    const percentage = Math.round((totalDownloaded / total) * 100);
    progressBarProgress.style.width = percentage + "%";
    progressBarText.textContent = percentage + "%";
}

function wineFinalizeProgressBar() {
    progressBarProgress.style.width = "100%";
    setTimeout(() => {
        wineModal.close();
    }, 500);
}

function wineUnzipBegin() {
    progressBarProgress.textContent = "Unzipping...";
}

function wineResetProgressBar() {
    progressBarProgress.style.width = "0%";
}

const window = WebviewWindow.getCurrent();

window.listen(TauriEvent.WINDOW_CLOSE_REQUESTED, async () => {
    await logger.info("Closing 9Launcher...");
    try {
        await fs.rename("9Launcher.log", "9Launcher-" + `${moment().format("MM-DD-mm_ss-YYYY")}` + ".log", {
            oldPathBaseDir: fs.BaseDirectory.AppData,
            newPathBaseDir: fs.BaseDirectory.AppData,
        });
    } catch {
        console.error("Couldn't rename log file!");
    }
    window.destroy();
});

if (Storage.get("console-logging") !== "enabled") document.getElementById("console")?.remove();

document.getElementById("clear-console")?.addEventListener("click", logger.clearConsole);

const funcs = {
    wineUpdateProgressBar,
    wineFinalizeProgressBar,
    wineResetProgressBar,
    wineOpenModal,
    wineUnzipBegin,
    dosboxOpenModal,
    dosboxUpdateProgressBar,
    dosboxUnzipBegin,
    dosboxFinalizeProgressBar,
    dosboxResetProgressBar,
    openWineManager,
};

export default funcs;
