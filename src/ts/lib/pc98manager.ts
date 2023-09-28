import { download } from "tauri-plugin-upload-api"
import dashboard from "../dashboard";
import infoManager from './infoManager';
import * as path from "@tauri-apps/api/path";
import { logger } from "./logging";
import { Command } from "@tauri-apps/api/shell";
import { fs } from "@tauri-apps/api";

let info = await infoManager.gatherInformation();

async function downloadDosbox() {
    const platform = info.platform;
    const dosboxURLWindows = 'https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v2023.05.01/dosbox-x-vsbuild-win64-20230501103911.zip';
    const dosboxURLUnix = "https://wearr.dev/files/dosbox-x"
    const appData = await path.appDataDir();
    let dosboxPath = appData + 'dosbox-x-vsbuild-win64-20230501103911.zip';
    // Default to windows, but we will set the variable later if they are using linux or OSX.
    let determinedURL = dosboxURLWindows; 

    if (platform === 'linux' || platform === 'darwin') {
        determinedURL = dosboxURLUnix;
        dosboxPath = appData + 'dosbox-x';
    }
    let totalBytesDownloaded = 0;
    await download(determinedURL, dosboxPath, (progress, total) => {
        totalBytesDownloaded += progress;
        total = total;
        dashboard.dosboxUpdateProgressBar(totalBytesDownloaded, total);
    }).then(async () => {
        console.log('Downloaded dosbox!');
        if (platform === 'win32') {
            // This is the only reason I have to have powershell made invokable. this better not trip up windows defender or something
            unzipWindows(dosboxPath, appData); 
        }
        if (platform === 'linux') {
            if (!await fs.exists(appData + 'dosbox')) {
                fs.createDir(appData + 'dosbox');
            }
            fs.copyFile(appData + 'dosbox-x', appData + 'dosbox/dosbox-x');
            fs.removeFile(appData + 'dosbox-x');
            dashboard.dosboxFinalizeProgressBar();
            setTimeout(() => {
                new Command("chmod", ["+x", appData + 'dosbox/dosbox-x']).execute().then(() => {
                    logger.success("Dosbox chmodded successfully, should work now!")
                });
                window.location.reload();
            }, 1000);

        }
        if (platform === 'darwin') {
            console.error("MacOS is not supported yet! Please use Windows or Linux.")
        }
    })
}

function unzipWindows(archive: string, unzipDir: string) {
    console.log(archive)
    console.log(unzipDir)
    let unzip = new Command('powershell', ['Expand-Archive', "-Force", archive, unzipDir], { cwd: unzipDir });
    unzip.execute().then(() => {
        logger.success("Dosbox unzipped!");
        dashboard.dosboxFinalizeProgressBar();
    })
}
// function unzipUnix(archive: string, unzipDir: string, outputDir: string) {
//     console.log(archive)
//     console.log(unzipDir)
//     let unzip = new Command('unzip', [archive, '-d', unzipDir + outputDir], { cwd: unzipDir });
//     unzip.on('close', (code) => {
//         console.log(code)
//     })
//     unzip.stderr.on('data', (data) => {
//         console.log(data)
//     })
//     unzip.execute().then(() => {
//         logger("Wine unzipped!", "success");
//     })
// }

const funcs = {
    downloadDosbox
}

export default funcs;