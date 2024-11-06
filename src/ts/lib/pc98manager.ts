import { download } from "@tauri-apps/plugin-upload";
import dashboard from "../dashboard";
import infoManager from "./infoManager";
import { APPDATA_PATH } from "../globals";
import { logger } from "./logging";
import { Command } from "@tauri-apps/plugin-shell";
import {} from "@tauri-apps/api";
import * as fs from "@tauri-apps/plugin-fs";
import { unzip } from "../utils/unzip";

let info = await infoManager.gatherInformation();

async function downloadDosbox() {
    const platform = info.platform;
    const dosboxURLWindows =
        "https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v2023.05.01/dosbox-x-vsbuild-win64-20230501103911.zip";
    const dosboxURLUnix = "https://files.wearr.dev/dosbox-x";
    const appData = APPDATA_PATH;
    let dosboxPath = appData + "dosbox-x-vsbuild-win64-20230501103911.zip";

    let determinedURL: string;
    switch (platform) {
        case "windows":
            determinedURL = dosboxURLWindows;
            dosboxPath = appData + "/dosbox-x-vsbuild-win64-20230501103911.zip";
            break;
        case "linux":
            determinedURL = dosboxURLUnix;
            dosboxPath = appData + "/dosbox-x";
            break;
        case "macos":
            // TODO: Add macOS support
            determinedURL = dosboxURLUnix;
            dosboxPath = appData + "/dosbox-x";
            break;
        default:
            determinedURL = dosboxURLWindows;
            dosboxPath = appData + "/dosbox-x-vsbuild-win64-20230501103911.zip";
            break;
    }
    let totalBytesDownloaded = 0;
    logger.info("Downloading dosbox...");
    await download(determinedURL, dosboxPath, (payload) => {
        totalBytesDownloaded += payload.progress;
        dashboard.dosboxUpdateProgressBar(totalBytesDownloaded, payload.total);
    });
    logger.info("Downloaded dosbox!");
    if (platform === "windows") {
        logger.info("Unzipping dosbox...");
        dashboard.dosboxUnzipBegin();
        await unzip(dosboxPath, appData);
        logger.success("Dosbox unzipped!");
        dashboard.dosboxFinalizeProgressBar();
        logger.info("Removing archive...");
        fs.remove(dosboxPath);
    }
    if (platform === "linux") {
        if (!(await fs.exists(appData + "/dosbox"))) {
            fs.mkdir(appData + "/dosbox");
        }
        await fs.copyFile(appData + "/dosbox-x", appData + "/dosbox/dosbox-x");
        await fs.remove(appData + "/dosbox-x");
        dashboard.dosboxFinalizeProgressBar();
        setTimeout(async () => {
            await Command.create("chmod", ["+x", appData + "/dosbox/dosbox-x"]).execute()
            logger.success("Dosbox chmodded successfully, should work now!");
        }, 1000);
    }
    if (platform === "macos") {
        console.error("MacOS is not supported yet! Please use Windows or Linux.");
    }
}

const funcs = {
    downloadDosbox,
};

export default funcs;
