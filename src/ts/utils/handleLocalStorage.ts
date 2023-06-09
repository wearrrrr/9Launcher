import { logger } from "../lib/logging";

function parseLSObject(item: string) {
    if (!item) return null;
    try {
        return JSON.parse(item);
    } catch {
        logger.error("Failed to parse local storage object!");
        return null;
    }
}

function getLocalStorageObject(name: string) {
    let retrieve = parseLSObject((localStorage.getItem(name) as string));
    if (retrieve === null) {
        return null;
    }
    return name;
}

function createLocalStorageObject(key: string) {
    if (!localStorage.getItem(key) === null) {
        logger.error("Failed to create local storage object! It already exists!");
        return null;
    }
    return key;
}

const funcs = {
    parseLSObject,
    getLocalStorageObject,
    createLocalStorageObject,

}

export default funcs;