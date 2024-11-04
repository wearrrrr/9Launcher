import { app } from "@tauri-apps/api";
import { arch, platform, type, version } from "@tauri-apps/plugin-os";
import type { Platform, OsType, Arch } from "@tauri-apps/plugin-os";

type osInformation = {
    version: string;
    architecture: Arch;
    platform: Platform;
    kernelVersion: string;
    OS: OsType;
};

export async function gatherInformation() {
    let info: osInformation = {
        version: await app.getVersion(),
        architecture: arch(),
        platform: platform(),
        kernelVersion: version(),
        OS: type(),
    };

    return info;
}

const info = await gatherInformation();

export default { gatherInformation };
export { info };
