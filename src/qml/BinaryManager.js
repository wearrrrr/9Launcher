.pragma library

function downloadProton(version, appData, path, downloader, fileIO) {
    if (fileIO.exists(appData + `/proton/GE-Proton${version}`)) {
        return false;
    } 
    const url = `https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${version}/GE-Proton${version}.tar.gz`;
    downloader.download(url, appData + path, true);
    return true;
}
