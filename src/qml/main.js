.import "fs.js" as File

function populateGamesList() {
    const games = File.loadJSON("../json/games.json");
    if (games == null) {
        throw new Error("games.json failed to load!");
    }

    window.mainModel = [].concat(
        Object.values(games["pc-98"]),
        Object.values(games.modern)
    );

    window.spinoffModel = Object.values(games.spinoffs);
}

function handleGameLaunch(item, installedJSON) {
    const gameItem = installedJSON.installed.filter(game => game.game_id === item.game_id)[0];

    if (gameItem == null) {
        console.log("Game is not installed: " + item.game_id + "!");
        return;
    }

    const path = gameItem.path;
    const cwd = path.substring(0, path.lastIndexOf("/"));

    gameLauncher.launchGame(path, cwd, item.en_title, item.game_id, item.isPC98 ? true : false);

    return true;
}
