import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import FileIO 1.0
import "main.js" as Core

import MMaterial as MMaterial
import "footer.js" as Footer


Window {
    Material.theme: Material.Dark
    Material.accent: Material.Blue

    id: window
    width: 950
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    visible: true
    title: qsTr("9Launcher")
    // Set color to the palette background
    color: "#2f2f2f"

    FileIO {
        id: fileIO
    }

    ColumnLayout {
        width: parent.width
        spacing: 0

        Item {
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignLeft
            Text {
                text: "Mainline Games"
                color: "white"
                font.bold: true
                font.pixelSize: 24
                padding: 5
            }
        }

        Flow {
            id: mainLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 5
            padding: 10

            Component.onCompleted: Core.populateGamesList()
        }

        Item {
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignLeft
            Text {
                text: "Spinoffs"
                color: "white"
                font.bold: true
                font.pixelSize: 24
                padding: 5
            }
        }

        Flow {
            id: spinoffLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 5
            padding: 10
        }
    }

    MMaterial.AlertController {
        id: alertController
        edgeOf: Item.TopRight
    }

    MMaterial.Dialog {
        id: dialog
        modal: true
        title: qsTr("Reset Settings")
        width: parent.width / 2
        anchors.centerIn: parent

        closePolicy: MMaterial.Dialog.NoAutoClose
        iconData: MMaterial.Icons.light.warning

        contentItem: ColumnLayout {
            Label {
                text: qsTr("Are you sure you want to reset all settings?")
                color: "white"
            }
        }

        MMaterial.Dialog.DialogCloseButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Close")
            onClicked: dialog.close()

        }

        MMaterial.Dialog.DialogButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Reset")
            onClicked: {
                dialog.close()
                footer.resetSettings()
            }
        }
    }

    MMaterial.Dialog {
        id: pc98Dialog
        modal: true
        title: qsTr("PC-98 Emulator Not Found!")
        width: parent.width - 100
        anchors.centerIn: parent

        closePolicy: MMaterial.Dialog.NoAutoClose
        iconData: MMaterial.Icons.light.warning

        contentItem: ColumnLayout {
            Label {
                text: qsTr("The PC-98 emulator was not found.\nPlease make sure it is installed and the path is set in the binary manager.")
                color: "white"
            }
        }

        MMaterial.Dialog.DialogCloseButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Close")
            accent: MMaterial.Theme.error
            onClicked: {
                pc98Dialog.close()
            }

        }

        MMaterial.Dialog.DialogButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Open Binary Manager")
            onClicked: {
                pc98Dialog.close()
            }
        }
    }

    MouseArea {
        hoverEnabled: true
        propagateComposedEvents: true
        preventStealing: false
        anchors.fill: parent
        enabled: footer.settingsMenu.enabled || footer.infoMenu.enabled
        visible: footer.settingsMenu.enabled || footer.infoMenu.enabled
        onClicked: {
            footer.hideMenus()
        }
    }

    Footer { id: footer }
}
