export class thcrapDownloader {
    // Actually JSON, but thcrap ends with .js, instead of .json
    url = "https://thcrap.thpatch.net/thcrap_update.js";
    constructor(url?: string) {
        if (url) {
            this.url = url;
        }
    }

    getPath() {
        // Replace anything after the last slash with a slash, in this case it will pop thcrap_update.js from the URL.
        return this.url.replace(/\/[^/]+$/, "/");
    }

    async getBranchInfo() {
        const dl = await fetch(this.url);
        const json = await dl.json();

        return json;
    }
}