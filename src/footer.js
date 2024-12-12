function toggleVisibility(element, animation) {
    if (element.opacity === 0) {
        element.visible = true;
        element.opacity = 1;
    } else {
        element.opacity = 0;
        if (animation) {
            animation.running = true;
        }
    }
}

function resetSettings() {
    // This will trigger onCheckedChanged for each setting, which will save the new value :D
    warningsSetting.switchValue = false;
    rpcSetting.switchValue = false;
    fileLoggingSetting.switchValue = false;
    launchInfoSetting.switchValue = false;
}