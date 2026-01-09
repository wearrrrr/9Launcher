.pragma library

function downloadProton(version, appData, path, downloader, fileIO) {
    if (fileIO.exists(appData + `/proton/GE-Proton${version}`)) {
        return false;
    }
    const url = `https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${version}/GE-Proton${version}.tar.gz`;
    downloader.download(url, appData + path, true, false);
    return true;
}

function downloadDosbox(appData, path, downloader, fileIO) {
    if (fileIO.exists(appData + `/dosbox-x/mingw-build/`)) {
        return false;
    }
    console.log(appData);
    const url = `https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v2026.01.02/dosbox-x-mingw-win64-20260102233440.zip`;
    downloader.download(url, appData + path, false, true);
    return true;
}
