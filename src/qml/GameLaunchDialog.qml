import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import FileIO 1.0
import GameLauncher 1.0
import "main.js" as Core

import MMaterial as MMaterial
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media
import MMaterial.Controls.Dialogs

Dialog {
    id: control

    signal gameRemoved()

    property var gameItem: ({})
    property bool isPC98: false

    title: qsTr("Launch ") + gameItem.en_title
    width: 650
    anchors.centerIn: parent
    modal: true
    showXButton: true

    function launchGame() {
        const installedJSON = JSON.parse(fileIO.read(StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/installed.json"));
        const gameItemData = installedJSON.installed.filter(game => game.game_id === gameItem.game_id)[0];

        if (gameItemData == null) {
            console.log(gameItem.game_id + " is not installed but launchGame was called! This is a bug.");
            return;
        }

        const path = gameItemData.path;
        const cwd = path.substring(0, path.lastIndexOf("/"));

        gameLauncher.launchGame(path, cwd, gameItem.en_title, gameItem.game_id, isPC98);
        control.close();
    }

    function launchWithThcrap() {
        const appDataPath = StandardPaths.writableLocation(StandardPaths.AppDataLocation)
        const installedJSON = JSON.parse(fileIO.read(appDataPath + "/installed.json"));
        const gameItemData = installedJSON.installed.filter(game => game.game_id === gameItem.game_id)[0];

        if (gameItemData == null) {
            console.log(gameItem.game_id + " is not installed but launchWithThcrap was called! This is a bug.");
            return;
        }

        const path = gameItemData.path;
        const cwd = path.substring(0, path.lastIndexOf("/"));
        const configPath = appDataPath + "/thcrap/config/" + gameItem.game_id + ".js"

        if (!fileIO.exists(configPath)) {
            console.log("No thcrap config found for " + gameItem.game_id);
            return;
        }

        gameLauncher.launchWithThcrap(configPath, path, cwd, gameItem.en_title + " (thcrap)", gameItem.game_id);
        control.close();
    }

    function removeGame() {
        const appDataPath = StandardPaths.writableLocation(StandardPaths.AppDataLocation);
        const installedJSON = JSON.parse(fileIO.read(appDataPath + "/installed.json"));
        const updatedInstalled = installedJSON.installed.filter(game => game.game_id !== gameItem.game_id);
        installedJSON.installed = updatedInstalled;
        fileIO.write(appDataPath + "/installed.json", JSON.stringify(installedJSON));
        control.gameRemoved();
        removeDialog.close();
        control.close();
    }

    FileIO {
        id: fileIO
    }

    GameLauncher {
        id: gameLauncher
    }

    ThcrapConfigDialog {
        id: thcrapConfigDialog
        gameItem: control.gameItem
        parent: control.parent
    }

    Dialog {

        background: Rectangle {
            border.width: 1
            border.color: "white"
            color: UI.Theme.background.paper
        }

        id: removeDialog
        modal: true
        title: qsTr("Remove Game")
        width: 400
        parent: control.parent
        anchors.centerIn: parent

        contentItem: Label {
            text: qsTr("Are you sure you want to remove this game?")
            color: "white"
        }

        Dialog.DialogCloseButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Cancel")
            onClicked: removeDialog.close()
        }

        Dialog.DialogButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Remove")
            onClicked: control.removeGame()
        }
    }

    contentItem: ColumnLayout {
        spacing: UI.Size.pixel16

        Image {
            id: gameImage
            source: gameItem.game_id ? "/nineLauncher/game-images/" + gameItem.game_id + ".png" : ""
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 150
            Layout.preferredHeight: 150
            fillMode: Image.PreserveAspectFit
        }
    }

    Dialog.DialogButton {
        text: qsTr("Launch Game")
        onClicked: control.launchGame()
    }

    Dialog.DialogButton {
        text: qsTr("Launch with thcrap")
        fontCapitalization: Font.MixedCase
        onClicked: control.launchWithThcrap()
    }

    Dialog.DialogButton {
        text: qsTr("Configure thcrap")
        fontCapitalization: Font.MixedCase
        onClicked: {
            thcrapConfigDialog.open()
        }
    }

    // Dialog.DialogButton {
    //     text: qsTr("Change Icon")
    //     onClicked: {
    //         // dummy
    //         console.log("Change icon clicked for " + gameItem.en_title);
    //     }
    // }

    Dialog.DialogButton {
        text: qsTr("Remove Game")
        accent: MMaterial.Theme.error
        onClicked: removeDialog.open()
    }
}
