function downloadProton(version, path) {
    const url = `https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${version}/GE-Proton${version}.tar.gz`;

    downloader.download(url, path);
}