type Patch = {
    id: string;
    min_build?: string;
    title: string;
    dependencies: string[];
    update?: boolean;
    servers?: string[];
    fonts?: {
        [key: string]: boolean;
    };
};

type ThcrapFileList = {
    [key: string]: number;
};


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

    async getPatchInfo(id: string): Promise<Patch> {
        const url = `${this.srv}/${id}/patch.js`;
        const dl = await fetch(url);
        const json = await dl.json();

        return json;
    }

    // This function will crawl the entire network of repos, which contain patches, based off the neighbors list of thpatch.
    async crawlNeighbors(neighborList: string[]): Promise<thcrapRepoPatch[]> {
        let patches = [];
        for (const neighbor of neighborList) {
            console.log(`Crawling ${neighbor}`);
            const repo = await this.downloadRepo(neighbor);
            patches.push({
                id: repo.id,
                patches: repo.patches,
                server: repo.servers[0]
            });
        }
        return patches.sort((a, b) => a.id.localeCompare(b.id));
    }

    async downloadRepo(repoURL: string) {
        const dl = await fetch(`${repoURL}/repo.js`);
        const json = await dl.json();

        return json;
    }

    async downloadFilesList(id: string): Promise<ThcrapFileList> {
        if (!id) throw new Error("No patchID provided!");
        const url = this.getURLForPatch(id);
        const dl = await fetch(`${url}/${id}/files.js`);
        const json = await dl.json();

        return json;
    }

    /* ugh. The entire reason this function needs to exist is because there is a difference between srv.thpatch.net and mirror.thpatch.net qwq. */
    getURLForPatch(id: string) {
        if (id.includes("/")) {
            return this.mirror
        }
        return this.srv;
    }
}