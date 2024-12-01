.import "fs.js" as File

function populateGamesList() {
    const games = loadGamesJSON("json/games.json");
    if (games == null) {
        throw new Error("games.json failed to load!");
    }
    loadGameList(games["pc-98"], "main");
    loadGameList(games.modern, "main");
    loadGameList(games.spinoffs, "spinoff");
}

function loadGameList(iter, type) {
    let layout = mainLayout;
    if (type == "spinoff") {
        layout = spinoffLayout;
    }
    for (const [name, value] of Object.entries(iter)) {
        createGameItem(name, value, layout);
    }
}

function createGameItem(name, value, layout) {
    const isGamePC98 = value.isPC98 ? true : false
    var rectangle = Qt.createComponent("GameItem.qml").createObject(layout, {
        width: 150,
        height: 55,
        item: value,
        isPC98: isGamePC98
    });

    if (rectangle === null) {
        console.error("Failed to create Rectangle component");
    }
}

function loadGamesJSON(path) {
    let response = File.openFile(path);
    if (response && response.status === 200) {
        let games = JSON.parse(response.content);
        return games;
    } else {
        return null;
    }
}

function handleGameLaunch(item, installedJSON) {
    const gameItem = installedJSON.installed.filter(game => game.game_id === item.game_id)[0];

    if (item == null) {
        console.log("Game is not installed: " + item.game_id + "!");
        return;
    }

    const path = gameItem.path;

    const cwd = path.substring(0, path.lastIndexOf("/"));

    if (item.isPC98) {
        console.log("Launching PC-98 game: " + item.game_id);
        gameLauncher.launchGame(path, cwd);
        return;
    }
    console.log("Launching modern game: " + item.game_id);
    gameLauncher.launchGame(path, cwd);
}
