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
