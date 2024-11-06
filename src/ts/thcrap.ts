type Patch = {
    id: string;
    min_build: string;
    servers: string[];
    dependencies: string[];
    title: string;
    fonts?: {
        [key: string]: boolean;
    }
}


export class thcrapDownloader {
    // Actually JSON, but thcrap ends with .js, instead of .json
    url = "https://thcrap.thpatch.net";
    srv = "https://srv.thpatch.net";
    mirror = "https://mirrors.thpatch.net";
    constructor(url?: string) {
        if (url) {
            this.url = url;
        }
    }

    async getBranchInfo() {
        const dl = await fetch(this.url + "/thcrap_update.js");
        const json = await dl.json();

        return json;
    }

    async getPatchInfo(patchID: string) {
        if (!patchID) throw new Error("No patchID provided!");
        const dl = await fetch(`${this.srv}/${patchID}/patch.js`);
        const json = await dl.json();

        return json;
    }

    async fetchDependency(dependency: string): Promise<Patch> {
        if (!dependency) throw new Error("No dependency provided!");
        const dl = await fetch(`${this.mirror}/${dependency}/patch.js`);
        const json = await dl.json();

        return json;
    }
}