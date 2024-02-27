import * as path from '@tauri-apps/api/path';
import * as fs from '@tauri-apps/api/fs';
import { download } from "tauri-plugin-upload-api"
import { logger } from './logging';
import { Command } from '@tauri-apps/api/shell';
import wineDownloadsFrontend from '../wineDownloadsManager';
import winelist from "../../assets/winelist.json"


type wineObject = {
    "prefix": string,
    "description": string,
    "downloadURL": string,
    "path": string
}

async function wineIterator() {
    let installedWineVers = []
    for (const [name] of Object.entries(winelist["linux-wine"])) {
        if (await checkIfVersionExists(name)) {
            installedWineVers.push(name)
        }
    }
    return installedWineVers
}

async function unzip(wineArchive: string, wineDir: string) {
    console.log(wineDir)
    let unzip = new Command('tar', ['xvf', wineArchive, '-C', wineDir], { cwd: wineDir });
    unzip.stderr.on('data', data => console.error(`command stderr: "${data}"`));
    unzip.on('error', error => console.error(`command error: "${error}"`));
    await unzip.execute().then(() => {
        logger.success("Wine unzipped!")
    })
}

async function downloadWine(url: string, archiveName: string) {
    const wineDir = await path.appDataDir() + "wine/";
    archiveName = archiveName.replace(".", "-")
    archiveName = archiveName + ".tar.gz"
    const wineArchive = await path.appDataDir() + "wine/" + archiveName;
    const wineFolder = await path.appDataDir() + "wine/" + archiveName + "/"
    const wineDirExists = await fs.exists(wineDir);
    const wineArchiveExists = await fs.exists(wineArchive);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.createDir(wineDir);
    if (wineArchiveExists) {
        if (wineFolderExists) return console.log("Wine already unzipped... nothing to do!")
        else return unzip(wineArchive, wineDir);
    };
    let totalBytesDownloaded = 0;
    await download(
        url,
        await path.appDataDir() + `/wine/${archiveName}`,
        (progress, total) => {
            totalBytesDownloaded += progress;
            total = total;
            wineDownloadsFrontend.updateWineProgressBar(totalBytesDownloaded, total);
        }
    ).then(async () => {
        console.log("Download complete... Unzipping wine!")
        wineDownloadsFrontend.finalizeWineProgressBar();
        unzip(wineArchive, wineDir);
        setTimeout(() => {
            wineDownloadsFrontend.wineDownloadComplete();
            wineDownloadsFrontend.resetWineProgressbar();
        }, 500)
        let installedWineList = await wineIterator();
        if (installedWineList.includes(archiveName.replace(".tar.gz", ""))) {
            setPrimaryWine(archiveName.replace(".tar.gz", ""), winelist["linux-wine"][archiveName.replace(".tar.gz", "") as keyof typeof winelist["linux-wine"]])
        }
    })
    return "Wine downloaded!";
}

async function checkIfVersionExists(wineVersion: string) {
    console.log(wineVersion)
    if (wineVersion == "System Wine") {
        // Check if /usr/bin/wine exists
        const wineExists = await fs.exists("/usr/bin/wine");
        console.log(wineExists)
        if (wineExists) {
            return true;
        } else {
            return false;
        }
    }
    const wineDir = await path.appDataDir() + "/wine/";
    const wineFolder = await path.appDataDir() + "wine/" + wineVersion + "/";
    const wineDirExists = await fs.exists(wineDir);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.createDir(wineDir);
    if (wineFolderExists) {
        return true;
    } else {
        return false;
    }
}

async function setPrimaryWine(name: string, value: wineObject, relativePath: boolean = true) {
    let appData = await path.appDataDir();
    let linkPath = await path.join(appData, "wine/wine")
    fs.removeFile(appData + "wine/wine")
    let winePath
    if (relativePath == false) {
        winePath = value.path;
    } else {
        winePath = appData + value.path;
    }
    let createLink = new Command('ln', ['-sf', winePath, linkPath]);
    console.log(createLink)
    await createLink.execute();
    logger.success(`Primary wine set to ${name}!`)
    window.location.reload();
    localStorage.setItem('primary-wine', name);
}

const funcs = {
    downloadWine,
    unzip,
    checkIfVersionExists,
    setPrimaryWine
}
export default funcs;