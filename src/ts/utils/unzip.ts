import { Command } from "@tauri-apps/plugin-shell";
import { info } from "../lib/infoManager";

export function unzip(archivePath: string, unzipDir: string) {
    if (info.platform == "windows") {
        return unzipWindows(archivePath, unzipDir);
    } else {
        return unzipUnix(archivePath, unzipDir);
    }
}

async function unzipUnix(archivePath: string, unzipDir: string) {
    const unzip = Command.create("unzip", ["-o", archivePath, "-d", unzipDir]);
    await unzip.execute();
}

async function unzipWindows(archive: string, unzipDir: string) {
    let unzip = Command.create("powershell", ["Expand-Archive", "-Force", archive, unzipDir], { cwd: unzipDir });
    await unzip.execute()
}