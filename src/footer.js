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
    fileLoggingSetting.switchValue = false;
    launchInfoSetting.switchValue = false;
}

function copyInfo(itemsToCopy, copyBtn) {
    let clipboard = Clipboard;
    let text = "";
    for (let i = 0; i < itemsToCopy.length; i++) {
        text += itemsToCopy[i].text + "\n";
    }
    clipboard.set(text);
    
    copyBtn.text = qsTr("Copied!");

    Util.Sleep(500);
    copyBtn.text = qsTr("Copy Info");
}

function openBinaryManager() {
    const binaryManager = Qt.createComponent("BinaryManager.qml").createObject(window);
    binaryManager.show();
}