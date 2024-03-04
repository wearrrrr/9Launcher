import { app } from "@tauri-apps/api";
import { arch, platform, type, version } from "@tauri-apps/api/os";

type osInformation = {
    version: string,
    architecture: string,
    platform: string,
    kernelVersion: string,
    OS: string
}

export async function gatherInformation() {
    let info: osInformation = {
        version: "Unknown",
        architecture: "Unknown",
        platform: "Unknown",
        kernelVersion: "Unknown",
        OS: "Unknown",
    };

    info.version = await app.getVersion();
    info.architecture = await arch();
    info.platform = await platform();
    info.kernelVersion = await version();
    info.OS = await type();
    
    return info;
}

export default { gatherInformation }