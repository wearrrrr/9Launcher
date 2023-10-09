import { app } from "@tauri-apps/api";
import { arch, platform, type, version } from "@tauri-apps/api/os";

type osInformation = {
    version: string,
    architecture: string,
    platform: string,
    kernelVersion: string,
    OS: string
}

async function getVersion() {
    return await app.getVersion().then((version) => {
        return version
    })
}

async function getArch() {
    return await arch().then((arch) => {
        return arch
    })
}

async function getPlatform() {
    return await platform().then((platform) => {
        return platform
    })
}

async function getKernelVersion() {
    return await version().then((version) => {
        return version
    })
}

async function getOSType() {
    return await type().then((type) => {
        return type
    })
}

export async function gatherInformation() {
    let info: osInformation = {
        version: "Unknown",
        architecture: "Unknown",
        platform: "Unknown",
        kernelVersion: "Unknown",
        OS: "Unknown",
    };

    info.version = await getVersion()
    info.architecture = await getArch()
    info.platform = await getPlatform()
    info.kernelVersion = await getKernelVersion()
    info.OS = await getOSType()
    
    return info;
}

export default { gatherInformation }