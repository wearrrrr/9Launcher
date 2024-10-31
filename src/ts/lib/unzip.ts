import { Command } from "@tauri-apps/plugin-shell";
import { logger } from "./logging";

export async function unzip(wineArchive: string, wineDir: string) {
    let unzip = Command.create("tar", ["xvf", wineArchive, "-C", wineDir], {
        cwd: wineDir,
    });
    unzip.stderr.on("data", (data) => console.error(`command stderr: "${data}"`));
    unzip.on("error", (error) => console.error(`command error: "${error}"`));
    await unzip.execute().then(() => {
        logger.success("Wine unzipped!");
    });
}
