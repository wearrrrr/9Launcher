import { Command } from "@tauri-apps/plugin-shell";
import { logger } from "./logging";
import { info } from "./infoManager";
import { returnCode } from "../globals";

export async function unzip(wineArchive: string, wineDir: string) {
    if (info.platform == "windows") return returnCode.ERROR;
    let unzip = Command.create("tar", ["xvf", wineArchive, "-C", wineDir], {
        cwd: wineDir,
    });
    unzip.stderr.on("data", (data) => console.error(`command stderr: "${data}"`));
    unzip.on("error", (error) => console.error(`command error: "${error}"`));
    const exec = await unzip.execute()
    if (exec.code == 0) {
        logger.info("Unzipped Wine successfully!");
        return returnCode.SUCCESS;
    } else {
        logger.error("Failed to unzip Wine!");
        return returnCode.ERROR;
    }
}
