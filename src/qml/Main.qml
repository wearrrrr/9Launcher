import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import FileIO 1.0
import "main.js" as Core

import MMaterial as MMaterial
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media
import MMaterial.Controls.Inputs as Inputs
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
    color: UI.Theme.background.main

    Component.onCompleted: () => {
        UI.Theme.primary = UI.BasicBlue;
        UI.Theme.background.main = "#263238";
        UI.Theme.background.paper = "#182024";
    }

    property var mainModel: []
    property var spinoffModel: []

    function populateGamesList(jsonFile) {
        mainModel = [];
        spinoffModel = [];
        Core.populateGamesList(jsonFile);
    }

    ColumnLayout {
        id: appLayout
        width: parent.width
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: UI.Size.pixel48

            Controls.MTabs {
                id: tabs
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height

                width: contentWidth

                model: ObjectModel {
                    Controls.MTabButton {
                        property string json: "games.json"
                        text: "Official Games"
                    }
                    Controls.MTabButton {
                        property string json: "fan_games.json"
                        text: "Fan Games"
                    }
                    Controls.MTabButton {
                        property string json: "seihou.json"
                        text: "Seihou"
                    }
                }

                onCurrentIndexChanged: {
                    populateGamesList(tabs.currentItem.json);
                }
            }
        }

        Item {
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignLeft
            UI.H4 {
                text: "Main Games"
                font.bold: true
                padding: 5
            }
        }

        Flow {
            id: mainLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 5
            padding: 10

            Component.onCompleted: populateGamesList(tabs.currentItem.json);
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
            UI.H4 {
                text: "Spinoffs"
                font.bold: true
                padding: 5
            }

            visible: window.spinoffModel.length > 0
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
            visible: window.spinoffModel.length > 0
        }
    }

    Controls.AlertGenerator {
        id: alerts

        objectName: "AlertGenerator"
        width: parent.width > 400 ? 400 * UI.Size.scale : parent.width * 0.9
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
        visible: enabled
        onClicked: footer.hideMenus()
    }

    Footer {
        id: footer
    }
}
