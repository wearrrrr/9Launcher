import * as path from '@tauri-apps/api/path';
import * as fs from '@tauri-apps/api/fs';
import { download } from 'tauri-plugin-upload-api';
import { logger } from './logging';
import { Command } from '@tauri-apps/api/shell';
import wineDownloadsFrontend from '../wineDownloadsManager';


type wineObject = {
    "prefix": string,
    "description": string,
    "downloadURL": string,
    "path": string
}

async function unzip(wineArchive: string, wineDir: string) {
    console.log(wineDir)
    let unzip = new Command('tar', ['xvf', wineArchive, '-C', wineDir], { cwd: wineDir });
    unzip.stderr.on('data', data => console.error(`command stderr: "${data}"`));
    unzip.on('close', data => {
        console.log(`command finished with code ${data.code} and signal ${data.signal}`)
    });
    unzip.on('error', error => console.error(`command error: "${error}"`));
    await unzip.execute().then(() => {
        logger("Wine unzipped!", "success");
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
    })
    return "Wine downloaded!";
}

async function checkIfVersionExists(wineVersion: string) {
    const wineDir = await path.appDataDir() + "/wine/";
    const wineFolder = await path.appDataDir() + "wine/" + wineVersion + "/";
    const wineDirExists = await fs.exists(wineDir);
    const wineFolderExists = await fs.exists(wineFolder);
    if (!wineDirExists) await fs.createDir(wineDir);
    if (wineFolderExists) {
        return true;
    } else {
        return false;
        // return downloadWine(url, wineVersion)
    }
}

async function setPrimaryWine(name: string, value: wineObject) {
    let appData = await path.appDataDir();
    let linkPath = await path.join(appData, "wine/wine")
    fs.removeFile(appData + "wine/wine")
    let winePath = appData + value.path;
    console.log(winePath)
    console.log(linkPath)
    let createLink = new Command('ln', ['-sf', winePath, linkPath]);
    await createLink.execute();
    logger(`Set ${name} as primary wine!`, "success");
    window.location.reload();
}

const funcs = {
    downloadWine,
    unzip,
    checkIfVersionExists,
    setPrimaryWine
}
export default funcs;