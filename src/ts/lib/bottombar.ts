import games from '../../assets/games.json';
import { message } from '@tauri-apps/api/dialog';
import { dialog } from '@tauri-apps/api';

const settingsDiv = document.getElementById('settings-icn') as HTMLDivElement;
const settingsGear = document.getElementById('settings-gear') as HTMLDivElement;
const settingsClip = document.getElementById('settings-gear-clip') as HTMLDivElement;
const quickSettings = document.getElementById('quick-settings') as HTMLDivElement;
const notificationSlider = document.getElementById('notifications-slider') as HTMLInputElement;
const clearGames = document.getElementById('clear-games-btn') as HTMLButtonElement;


let quickSettingsToggle = 0;

if (settingsGear !== null) {
    settingsDiv.addEventListener('mouseover', () => {
        settingsClip.style.opacity = '1';
    })
    settingsDiv.addEventListener('mouseout', () => {
        settingsClip.style.opacity = '0';
    })
    settingsDiv.addEventListener('click', () => {
        if (quickSettingsToggle == 0) {
            quickSettings.style.opacity = "1";
            quickSettingsToggle = 1;
            quickSettings.focus();
        } else {
            quickSettings.style.opacity = "0";
            quickSettingsToggle = 0
        }
    })
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
                for (const [name] of Object.entries(games.modern)) {
                    if (name == "libraryUpdateAlerts") continue;
                    localStorage.removeItem(name);
                }
                await messageBox("Library cleared!", "Success");
                window.location.reload();
            }
        });
    });
}

async function messageBox(messageStr: string, type: string) {
    if (localStorage.getItem("libraryUpdateAlerts") === "disabled") return;
    await message(messageStr, type)
}

export default messageBox;