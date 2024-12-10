pragma ComponentBehavior: Bound

import QtQuick
import QtCore
import QtQuick.Controls.Material
import QtQuick.Dialogs
import FileIO 1.0
import GameLauncher 1.0
import "main.js" as Core


Button {
    property var item: {}
    property bool isPC98: false
    property bool isInstalled: false
    id: button

    onClicked: isInstalled ? (function () {
        const installedJSON = JSON.parse(fileIO.read(StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/installed.json"));
        Core.handleGameLaunch(item, installedJSON);
    }()) : gameDialog.open();

    FileIO {
        id: fileIO
    }

    GameLauncher {
        id: gameLauncher
    }

    Image {
        id: gameImage
        width: parent.width
        height: parent.height
        source: "game-images/" + parent.item.img_unset

        Component.onCompleted: {
            const path = StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/installed.json";

            if (!fileIO.exists(path)) {
                fileIO.write(path, '{ "installed": [] }');
            }

            const items = JSON.parse(fileIO.read(path));

            items.installed.forEach((item) => {
                if (item.game_id == button.item.game_id) {
                    gameImage.source = "game-images/" + item.img;
                    button.isInstalled = true;
                }
            })
        }
    }

    Rectangle {
        id: rect
        width: parent.width
        height: parent.height
        border.color: "white"
        border.width: 1
        radius: 4
        color: "#60000000"

        anchors.centerIn: parent
        Text {
            anchors.fill: parent
            anchors.margins: 5
            text: button.item.en_title
            color: "white"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
            font.bold: true
        }

        states: [
            State {
                name: "hovered"
                when: mouse.hovered
                PropertyChanges {
                    target: rect
                    color: "#80000000"
                }
            }
        ]

        transitions: Transition {
            reversible: true
            ColorAnimation {
                property: "color"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }

        HoverHandler {
            id: mouse
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
            cursorShape: Qt.PointingHandCursor
        }
    }

    FileDialog {
        id: gameDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        nameFilters: button.isPC98 ? ["PC-98 Disk Image (*.hdi)"] : ["Executable (*.exe)"]
        onAccepted: {
            const file = gameDialog.currentFile;
            const targetItem = button.item;
            const path = StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/installed.json";

            if (!fileIO.exists(path)) {
                fileIO.write(path, '{ "installed": [] }');
            }

            const currentInstalled = JSON.parse(fileIO.read(path));

            targetItem.path = file;

            currentInstalled.installed.push(targetItem);

            gameImage.source = "game-images/" + button.item.img
            button.isInstalled = true

            fileIO.write(path, JSON.stringify(currentInstalled));
        }
    }

}
