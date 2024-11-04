import { MessageDialogOptions, message } from "@tauri-apps/plugin-dialog";
import {} from "@tauri-apps/api";
import infoManager from "./infoManager";
import dashboard from "../dashboard";
import { invoke } from "@tauri-apps/api/core";
import games from "./games";
import { Storage } from "../utils/storage";
import * as dialog from "@tauri-apps/plugin-dialog";

const settingsDiv = document.getElementById("settings-icn")!;
const infoPageIcon = document.getElementById("info-page")!;
const appInfo = document.getElementById("app-info")!;
const quickSettings = document.getElementById("quick-settings")!;
const notificationSlider = document.getElementById("notifications-slider") as HTMLInputElement;
const rpcSlider = document.getElementById("discord-rpc-slider") as HTMLInputElement;
const rpcSliderRound = document.getElementById("rpc-slider-round")!;
const fileLoggingSlider = document.getElementById("file-logging-slider") as HTMLInputElement;
const consoleInfoSlider = document.getElementById("console-slider") as HTMLInputElement;
const clearGames = document.getElementById("clear-games-btn") as HTMLButtonElement;
const wineManager = document.getElementById("wine-manager-btn") as HTMLButtonElement;
const dosboxManager = document.getElementById("dosbox-manager-btn") as HTMLButtonElement;

const osInfo = document.getElementById("os-info")!;
const kernelInfo = document.getElementById("kernel-info")!;
const archInfo = document.getElementById("arch-info")!;
const versionInfo = document.getElementById("version-info")!;

const copyInfoBtn = document.getElementById("copy-info") as HTMLButtonElement;

let info = await infoManager.gatherInformation();
let quickSettingsToggle = 0;
let infoPageToggle = 0;

if (info.platform == "windows") {
    document.getElementById("wine-manager")?.remove();
}

function setSliderState(element: HTMLInputElement, state: boolean) {
    if (state) element.checked = state;
}
setSliderState(notificationSlider, Storage.get("libraryUpdateAlerts") === "enabled" ? true : false);
setSliderState(rpcSlider, Storage.get("discordRPC") === "enabled" ? true : false);
setSliderState(fileLoggingSlider, Storage.get("file-logging") === "enabled" ? true : false);
setSliderState(consoleInfoSlider, Storage.get("console-logging") === "enabled" ? true : false);

if (Storage.get("discordRPC") === null) {
    Storage.set("discordRPC", "enabled");
    games.setGameRichPresence();
    window.location.reload();
}
if (Storage.get("file-logging") === null) Storage.set("file-logging", "enabled");
if (Storage.get("libraryUpdateAlerts") === null) Storage.set("libraryUpdateAlerts", "enabled");
if (Storage.get("console-logging") === null) Storage.set("console-logging", "enabled");

interface ChangeEvent extends Event {
    target: HTMLInputElement;
}

if (settingsDiv !== null) {
    settingsDiv.addEventListener("click", () => {
        if (quickSettingsToggle == 0) {
            quickSettings.classList.add("modal-active");
            quickSettingsToggle = 1;
            quickSettings.style.pointerEvents = "auto";
        } else {
            quickSettings.classList.remove("modal-active");
            quickSettingsToggle = 0;
            quickSettings.style.pointerEvents = "none";
        }
    });
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && quickSettingsToggle == 1) {
            quickSettings.style.opacity = "0";
            quickSettingsToggle = 0;
        }
    });
    notificationSlider.addEventListener("change", (event) => {
        // Why the fuck do I need to do this..
        const changeEvent = event as ChangeEvent;
        if (changeEvent.target.checked) {
            Storage.set("libraryUpdateAlerts", "enabled");
        } else {
            Storage.set("libraryUpdateAlerts", "disabled");
        }
    });
    rpcSlider.addEventListener("change", (event) => {
        const changeEvent = event as ChangeEvent;
        if (rpcSliderRound == null) return;
        rpcSliderRound.dataset.tempDisabled = "enabled";
        rpcSlider.disabled = true;
        setTimeout(() => {
            delete rpcSliderRound.dataset.tempDisabled;
            rpcSlider.disabled = false;
        }, 1500);
        if (changeEvent.target.checked) {
            Storage.set("discordRPC", "enabled");
            games.setGameRichPresence();
        } else {
            Storage.set("discordRPC", "disabled");
            invoke("clear_activity");
        }
    });
    fileLoggingSlider.addEventListener("change", (event: Event) => {
        const changeEvent = event as ChangeEvent;
        if (changeEvent.target.checked) {
            Storage.set("file-logging", "enabled");
        } else {
            Storage.set("file-logging", "disabled");
        }
    });
    consoleInfoSlider.addEventListener("change", (event) => {
        const changeEvent = event as ChangeEvent;
        if (changeEvent.target.checked) {
            Storage.set("console-logging", "enabled");
        } else {
            Storage.set("console-logging", "disabled");
        }
    });
    clearGames.addEventListener("click", async () => {
        const confirm = await dialog.confirm(
            "Are you sure you want to clear your library? This will remove all games from your library, and you will have to re-add them.",
            {
                title: "9Launcher",
            },
        );
        if (confirm) {
            let libalertskey = Storage.get("libraryUpdateAlerts");
            Storage.clear();
            Storage.set("libraryUpdateAlerts", libalertskey);
            await messageBox("Library cleared!", { kind: "info", title: "Success!" });
            window.location.reload();
        }
    });
    dosboxManager.addEventListener("click", () => {
        dashboard.dosboxOpenModal();
    });
    wineManager.addEventListener("click", () => {
        dashboard.openWineManager();
    });
}

function addInfoPageEvents() {
    if (infoPageIcon == null || infoPageIcon == undefined) return;
    infoPageIcon.addEventListener("click", () => {
        if (infoPageToggle == 0) {
            appInfo.classList.add("modal-active");
            infoPageToggle = 1;
            appInfo.style.pointerEvents = "auto";
        } else {
            appInfo.classList.remove("modal-active");
            infoPageToggle = 0;
            appInfo.style.pointerEvents = "none";
        }
    });
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && infoPageToggle == 1) {
            appInfo.style.opacity = "0";
            infoPageToggle = 0;
        }
    });
}
addInfoPageEvents();

let os = info.OS;
let kernelVersion = info.kernelVersion;
let arch = info.architecture;
let appVersion = info.version;
versionInfo.textContent = "Version: " + appVersion;
osInfo.textContent = "OS: " + os;
kernelInfo.textContent = "Kernel Version: " + kernelVersion;
archInfo.textContent = "Architecture: " + arch;
copyInfoBtn.addEventListener("click", () => {
    navigator.clipboard.writeText(`
        OS: ${os}\n
        Kernel Version: ${kernelVersion}\n
        Architecture: ${arch}\n
        Version: ${appVersion}
    `);
    messageBox("Copied device info to clipboard!", { kind: "info", title: "Success!" });
});

async function messageBox(str: string, type: MessageDialogOptions) {
    if (Storage.get("libraryUpdateAlerts") === "disabled") return;
    await message(str, type);
}

export default messageBox;
