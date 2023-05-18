import { message } from '@tauri-apps/api/dialog';
import { dialog } from '@tauri-apps/api';
import infoManager from './infoManager';
import dashboard from '../dashboard';

const settingsDiv = document.getElementById('settings-icn') as HTMLDivElement;
const infoPageIcon = document.getElementById('info-page') as HTMLDivElement;
const appInfo = document.getElementById('app-info') as HTMLDivElement;
const quickSettings = document.getElementById('quick-settings') as HTMLDivElement;
const notificationSlider = document.getElementById('notifications-slider') as HTMLInputElement;
const clearGames = document.getElementById('clear-games-btn') as HTMLButtonElement;
const wineManager = document.getElementById('wine-manager-btn') as HTMLButtonElement;

const osInfo = document.getElementById('os-info') as HTMLParagraphElement;
const kernelInfo = document.getElementById('kernel-info') as HTMLParagraphElement;
const archInfo = document.getElementById('arch-info') as HTMLParagraphElement;

const copyInfoBtn = document.getElementById('copy-info') as HTMLButtonElement;


let quickSettingsToggle = 0;
let infoPageToggle = 0;

function setSliderState(element: HTMLInputElement, state: boolean) {
    if (state == true) {
        element.checked = true;
    } else {
        element.checked = false;
    }
}
setSliderState(notificationSlider, localStorage.getItem("libraryUpdateAlerts") === "enabled" ? true : false)

if (settingsDiv !== null) {
    settingsDiv.addEventListener('click', () => {
        if (quickSettingsToggle == 0) {
            quickSettings.style.opacity = "1";
            quickSettingsToggle = 1;
            quickSettings.focus();
        } else {
            quickSettings.style.opacity = "0";
            quickSettingsToggle = 0
        }
    });
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && quickSettingsToggle == 1) {
            quickSettings.style.opacity = "0";
            quickSettingsToggle = 0
        }
    })
    notificationSlider.addEventListener("change", (event) => {
        if ((<HTMLInputElement>event.currentTarget).checked == true) {
            localStorage.setItem("libraryUpdateAlerts", "enabled")
        } else {
            localStorage.setItem("libraryUpdateAlerts", "disabled")
        }
    });
    clearGames.addEventListener('click', async () => {
        return await dialog.confirm(
            "Are you sure you want to clear your library? This will remove all games from your library, and you will have to re-add them.", 
            {
                title: "Touhou Launcher Reborn",
            }
            ).then(async (response) => {
            if (response == true) {
                let libalertskey = localStorage.getItem("libraryUpdateAlerts");
                localStorage.clear();
                localStorage.setItem("libraryUpdateAlerts", libalertskey as string);
                await messageBox("Library cleared!", "Success");
                window.location.reload();
            }
        });
    });
    wineManager.addEventListener('click', () => {
        dashboard.openWineManager();
    })
}

function addInfoPageEvents() {
    if (infoPageIcon == null || infoPageIcon == undefined) return;
    infoPageIcon.addEventListener('click', () => {
        if (infoPageToggle == 0) {
            appInfo.style.opacity = "1";
            infoPageToggle = 1;
            appInfo.focus();
        } else {
            appInfo.style.opacity = "0";
            infoPageToggle = 0
        }
    })
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && infoPageToggle == 1) {
            appInfo.style.opacity = "0";
            infoPageToggle = 0
        }
    });
}
addInfoPageEvents();

async function addInfoPageDetails() {
    let os = await infoManager.getOSType();
    let version = await infoManager.getKernelVersion();
    let arch = await infoManager.getArch();
    osInfo.textContent = "OS: " + os;
    kernelInfo.textContent = "Kernel Version: " + version;
    archInfo.textContent = "Architecture: " + arch;
    copyInfoBtn.addEventListener('click', () => {
        navigator.clipboard.writeText(`OS: ${os}\nKernel Version: ${version}\nArchitecture: ${arch}`);
        messageBox("Copied device info to clipboard!", "Success!");
    })
}
addInfoPageDetails()

async function messageBox(messageStr: string, type: string) {
    if (localStorage.getItem("libraryUpdateAlerts") === "disabled") return;
    await message(messageStr, type)
}

let waruicount = 0; 
let iswaruiplaying = false;

function inconspicuous() {
    if (document.getElementById('inconspicuous') == null || document.getElementById('inconspicuous') == undefined) return;
    let inconspicuous = document.getElementById('inconspicuous') as HTMLDivElement;
    inconspicuous.addEventListener('click', () => {
        if (waruicount < 2 && iswaruiplaying == false) {
            waruicount++;
            console.log(waruicount)
            const warui = new Audio("/src/assets/warui.mp3")
            warui.addEventListener('ended', () => {
                iswaruiplaying = false;
            })
            warui.volume = 0.5;
            warui.play();
            iswaruiplaying = true;
        }
        if (waruicount == 2) {
            return waruicount++
        }
        if (waruicount == 3) {
            localStorage.setItem("achievements", JSON.stringify({"warui": true}));
            let waruielem = document.getElementById('inconspicous-character') 
            if (waruielem == null) return
            waruielem.style.opacity = "0";  
            setTimeout(() => {
                waruielem?.remove();
            }, 260);
        }
        return false;
    });
}
inconspicuous();

export default messageBox;