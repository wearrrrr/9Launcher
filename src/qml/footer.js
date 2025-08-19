function toggleVisibility(element, animation) {
    if (element.opacity === 0) {
        element.visible = true;
        element.opacity = 1;
        element.enabled = true;
    } else {
        element.opacity = 0;
        if (animation) {
            animation.running = true;
        }
        element.enabled = false;
    }
}

function resetSettings() {
    // This will trigger onCheckedChanged for each setting, which will save the new value :D
    warningsSetting.switchValue = true;
    rpcSetting.switchValue = false;
    launchInfoSetting.switchValue = false;

    // Clear games
    const path = StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/installed.json";
    fileIO.write(path, '{ "installed": [] }');
    window.populateGamesList();
}

function copyInfo(itemsToCopy, copyBtn) {
    let clipboard = Clipboard;
    let text = "";
    for (let i = 0; i < itemsToCopy.length; i++) {
        text += itemsToCopy[i].text + "\n";
    }
    clipboard.set(text);
}

function openBinaryManager() {
  try {
    const binaryManager = Qt.createComponent("BinaryManager.qml")
    const object = binaryManager.createObject(window);
    if (object) object.show();
  } catch (error) {
    console.error("Error opening BinaryManager:", error);
  }
}
