import { logger } from "../lib/logging";

function deserializeLSObject(item: string) {
    if (!item) return null;
    try {
        return JSON.parse(item);
    } catch {
        logger("error", "Failed to deserialize local storage object! Is it valid JSON?");
        return null;
    }
}

const funcs = {
    deserializeLSObject,

}

export default funcs;