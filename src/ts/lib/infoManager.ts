import { arch, platform, type, version } from "@tauri-apps/api/os";

type osInformation = {
    architecture: string,
    platform: string,
    kernelVersion: string,
    OS: string
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
    let information: osInformation = {
        architecture: "Unknown",
        platform: "Unknown",
        kernelVersion: "Unknown",
        OS: "Unknown",
    };

    information.architecture = await getArch()
    information.platform = await getPlatform()
    information.kernelVersion = await getKernelVersion()
    information.OS = await getOSType()
    
    return information;
}

export default { gatherInformation }