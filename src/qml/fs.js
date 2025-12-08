.pragma library

function read(path) {
    let request = new XMLHttpRequest();
    request.open("GET", path, false);

    request.send();

    if (request.status === 200) {
        return {
            status: request.status,
            contentType: request.responseType,
            content: request.response
        };
    } else {
        console.error("Error loading file " + path, "Status: " + request.status);
        return null;
    }
}

function loadJSON(path) {
    let response = read(path);
    if (response && response.status === 200) {
        let games = JSON.parse(response.content);
        return games;
    } else {
        return null;
    }
}
