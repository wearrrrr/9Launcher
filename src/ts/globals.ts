import { appDataDir } from "@tauri-apps/api/path";

export const returnCode = {
    SUCCESS: 0,
    ERROR: 1,
    WARNING: 2,
    INFO: 3,
    DEBUG: 4,
    FATAL: 5,
    TRUE: 6,
    FALSE: 7,
};

export const APPDATA_PATH = await appDataDir();
