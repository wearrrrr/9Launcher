import { logger } from "../lib/logging";

function parseLSObject(item: string) {
    if (!item) return null;
    try {
        return JSON.parse(item);
    } catch {
        logger("error", "Failed to deserialize local storage object! Is it valid JSON?");
        return null;
    }
}

function getLocalStorageObject(name: string) {
    let retrieve = parseLSObject((localStorage.getItem(name) as string));
    if (retrieve === null) {
        return null;
    }
}

function createLocalStorageObject(key: string) {
    if (!localStorage.getItem(key) === null) {
        logger("localStorage object already exists!", "error");
        return null;
    }
}

const funcs = {
    parseLSObject,
    getLocalStorageObject,
    createLocalStorageObject
}

export default funcs;