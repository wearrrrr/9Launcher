.import "fs.js" as File

function populateGamesList(jsonFile) {
    const games = File.loadJSON("../json/" + jsonFile);
    if (games == null) {
        throw new Error(jsonFile + " failed to load!");
    }

    window.mainModel = [].concat(
        Object.values(games.games),
    );

  if (jsonFile == "games.json") {
    window.spinoffModel = Object.values(games.spinoffs);
  }
}
