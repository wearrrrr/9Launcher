.pragma library

function openFile(path) {
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
        console.error("Error loading file: ", request.status, request.statusText);
        return null;
    }
}

function saveFile(path, data) {
    var request = new XMLHttpRequest();
    request.open("PUT", path, false);
    request.send(data);
    return request.status;
}
