pragma ComponentBehavior: Bound

import QtQuick
import QtCore
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import QtQuick.Dialogs
import FileIO 1.0


Button {
    property var item: ({})
    property bool isPC98: false
    property bool isInstalled: false
    id: button

    onClicked: isInstalled ? console.log("already installed!") : gameDialog.open()

    FileIO {
        id: fileIO
    }

    Image {
        id: gameImage
        width: parent.width
        height: parent.height
        source: "game-images/" + parent.item.img_unset
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: button
        }

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

        HoverHandler {
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

            currentInstalled.installed.push(targetItem);

            gameImage.source = "game-images/" + button.item.img
            button.isInstalled = true

            fileIO.write(path, JSON.stringify(currentInstalled));
        }
    }

}
