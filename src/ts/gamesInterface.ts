import games from "../assets/games.json";
import { returnCode } from "./globals";

export const allGames: { [key: string]: any } = {
    ...games["pc-98"],
    ...games.modern,
    ...games.spinoffs,
};
export const validGames = [...games.validIDs["pc-98"], ...games.validIDs.windows];

export const gameIDs = games.validIDs;

export function getGame(id: string) {
    return allGames[id];
}

export function isGameIDValid(gameID: string) {
    if (!gameID || validGames.includes(gameID) === false) {
        return returnCode.FALSE;
    }
    return returnCode.TRUE;
}
