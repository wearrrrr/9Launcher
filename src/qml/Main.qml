import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import FileIO 1.0
import "main.js" as Core

import MMaterial as MMaterial
import MMaterial.Controls.Dialogs

Window {
    id: window
    Material.theme: Material.Dark
    width: 950
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    visible: true
    title: qsTr("9Launcher")
    color: "#2f2f2f"

    property var mainModel: []
    property var spinoffModel: []

    function populateGamesList() {
        mainModel = [];
        spinoffModel = [];
        Core.populateGamesList();
    }

    ColumnLayout {
        id: appLayout
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

            Component.onCompleted: populateGamesList()
            Repeater {
                model: window.mainModel
                delegate: GameItem {
                    width: 150
                    height: 55
                    item: modelData
                    isPC98: modelData.isPC98 ? true : false
                }
            }
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

            Repeater {
                model: window.spinoffModel
                delegate: GameItem {
                    width: 150
                    height: 55
                    item: modelData
                    isPC98: false
                }
            }
        }
    }

    Dialog {
        id: dialog
        modal: true
        title: qsTr("Reset Settings")
        width: parent.width / 2
        anchors.centerIn: parent

        closePolicy: Dialog.NoAutoClose
        iconData: MMaterial.Icons.light.warning

        contentItem: ColumnLayout {
            Label {
                text: qsTr("Are you sure you want to reset all settings?")
                color: "white"
            }
        }

        Dialog.DialogCloseButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Close")
            onClicked: dialog.close()
        }

        Dialog.DialogButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Reset")
            onClicked: {
                dialog.close();
                footer.resetSettings();
            }
        }
    }

    Dialog {
        id: pc98Dialog
        modal: true
        title: qsTr("PC-98 Emulator Not Found!")
        width: parent.width - 100
        anchors.centerIn: parent

        closePolicy: Dialog.NoAutoClose
        iconData: MMaterial.Icons.light.warning

        contentItem: ColumnLayout {
            Label {
                text: qsTr("No valid PC-98 emulator was not found!\nPlease make sure it is installed and the path is set in the binary manager.")
                color: "white"
            }
        }

        Dialog.DialogCloseButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Close")
            accent: MMaterial.Theme.error
            onClicked: {
                pc98Dialog.close();
            }
        }

        Dialog.DialogButton {
            Layout.preferredWidth: parent.width / 2 - 10
            text: qsTr("Open Binary Manager")
            onClicked: {
                pc98Dialog.close();
            }
        }
    }

    MouseArea {
        hoverEnabled: true
        propagateComposedEvents: true
        anchors.fill: parent
        enabled: footer.settingsMenu.enabled || footer.infoMenu.enabled
        visible: footer.settingsMenu.enabled || footer.infoMenu.enabled
        onClicked: footer.hideMenus()
    }

    Footer {
        id: footer
    }
}
