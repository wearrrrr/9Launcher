import games from '../assets/games.json';
import { returnCode } from './lib/types/types';

export const allGames: { [key: string]: any } = {...games["pc-98"], ...games.modern, ...games.spinoffs};

export const gameIDs = games.validIDs;

export function getGame(id: string) {
    return allGames[id];
}

export function isGameIDValid(gameID: string) {
    if (!gameID || games.validIDs.includes(gameID) === false) {
        return returnCode.FALSE
    }
    return returnCode.TRUE
}