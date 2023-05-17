import { arch, platform, type, version } from "@tauri-apps/api/os";
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

export default { getArch, getPlatform, getOSType, getKernelVersion }