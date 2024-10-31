import { APPDATA_PATH } from "../globals";
import { join } from "@tauri-apps/api/path";
import * as fs from "@tauri-apps/plugin-fs";
import { download } from "@tauri-apps/plugin-upload";
import { logger } from "./logging";
import { Command } from "@tauri-apps/plugin-shell";
import wineDownloadsFrontend from "../wineDownloadsManager";
import winelist from "../../assets/winelist.json";
import { unzip } from "./unzip";
import { Storage } from "../utils/storage";

type wineObject = {
    prefix: string;
    description: string;
    downloadURL: string;
    path: string;
};

async function wineIterator() {
    let installedWineVers = [];
    for (const [name] of Object.entries(winelist["linux-wine"])) {
        if (await checkIfVersionExists(name)) {
            installedWineVers.push(name);
        }
    }
    return installedWineVers;
}

async function downloadWine(url: string, archiveName: string) {
    const wineDir = APPDATA_PATH + "/wine/";
    archiveName = archiveName.replace(".", "-");
    archiveName = archiveName + ".tar.gz";
    const wineArchive = APPDATA_PATH + "/wine/" + archiveName;
    const wineFolder = APPDATA_PATH + "/wine/" + archiveName + "/";
    const wineDirExists = await fs.exists(wineDir);
    const wineArchiveExists = await fs.exists(wineArchive);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.mkdir(wineDir);
    if (wineArchiveExists) {
        if (wineFolderExists) return logger.info("Wine already unzipped... nothing to do!");
        else return unzip(wineArchive, wineDir);
    }
    let totalBytesDownloaded = 0;
    await download(url, APPDATA_PATH + `/wine/${archiveName}`, (payload) => {
        totalBytesDownloaded += payload.progress;
        // total = total;
        wineDownloadsFrontend.updateWineProgressBar(totalBytesDownloaded, payload.total);
    }).then(async () => {
        logger.info("Download complete... Unzipping wine!");
        wineDownloadsFrontend.finalizeWineProgressBar();
        await unzip(wineArchive, wineDir);
        wineDownloadsFrontend.wineDownloadComplete();
        wineDownloadsFrontend.resetWineProgressbar();
        fs.remove(wineArchive);
        let installedWineList = await wineIterator();
        if (installedWineList.includes(archiveName.replace(".tar.gz", ""))) {
            setPrimaryWine(
                archiveName.replace(".tar.gz", ""),
                winelist["linux-wine"][archiveName.replace(".tar.gz", "") as keyof (typeof winelist)["linux-wine"]],
            );
        }
    });
    return "Wine downloaded!";
}

async function checkIfVersionExists(wineVersion: string) {
    if (wineVersion == "System Wine") {
        // Check if /usr/bin/wine exists
        const wineExists = await fs.exists("/usr/bin/wine");
        if (wineExists) {
            return true;
        } else {
            return false;
        }
    }
    const wineDir = APPDATA_PATH + "/wine/";
    const wineFolder = `${wineDir}${wineVersion}/`;
    const wineDirExists = await fs.exists(wineDir);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.mkdir(wineDir);
    if (wineFolderExists) {
        return true;
    } else {
        return false;
    }
}

async function setPrimaryWine(name: string, value: wineObject, relativePath: boolean = true) {
    let appData = APPDATA_PATH;
    let linkPath = await join(appData, "wine/wine");
    fs.remove(appData + "wine/wine");
    let winePath;
    if (relativePath == false) {
        winePath = value.path;
    } else {
        winePath = appData + "/" + value.path;
    }
    let createLink = Command.create("ln", ["-sf", winePath, linkPath]);
    await createLink.execute();
    logger.success(`Primary wine set to ${name}!`);
    window.location.reload();
    Storage.set("primary-wine", name);
}

const funcs = {
    downloadWine,
    checkIfVersionExists,
    setPrimaryWine,
};
export default funcs;
