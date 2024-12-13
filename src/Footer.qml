import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial
import "footer.js" as Footer

Rectangle {
    width: parent.width
    height: 40
    anchors.bottom: parent.bottom
    color: "#212121"

    property alias settingsMenu: settingsMenu
    property alias infoMenu: infoMenu

    function resetSettings() {
        Footer.resetSettings();
    }

    function hideMenus(menu) {
        if (settingsMenu.enabled) {
            Footer.toggleVisibility(settingsMenu, SequentialAnimation);
        }
        if (infoMenu.enabled) {
            Footer.toggleVisibility(infoMenu, SequentialAnimation);
        }
    }

    FooterPanel {
        id: settingsMenu
        width: 300
        height: 250
        alignTo: "left"
        enabled: false

        Item {
            width: parent.width - 20
            height: parent.height - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            ColumnLayout {
                width: parent.width
                height: parent.height

                Setting {
                    text: qsTr("Warnings")
                    id: warningsSetting
                    update: "warnings"
                }

                Setting {
                    text: qsTr("Discord RPC")
                    id: rpcSetting
                    update: "rpc"
                }

                Setting {
                    text: qsTr("File Logging")
                    id: fileLoggingSetting
                    update: "fileLogging"
                }

                Setting {
                    text: qsTr("Launch Info")
                    id: launchInfoSetting
                    update: "launchInfo"
                }

                MButton {
                    text: qsTr("Reset Settings")
                    width: 50
                    accent: Theme.error
                    type: MButton.Type.Outlined
                    onClicked: {
                        if (AppSettings.value("warnings")) {
                            // Prompt the user to confirm the reset
                            dialog.open();
                        } else {
                            Footer.resetSettings();
                        }
                    }
                }
            }
        }
    }


    FooterPanel {
        id: infoMenu
        width: 350
        height: 275
        alignTo: "right"

        Item {
            width: parent.width - 20
            height: parent.height - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 10

                H4 {
                    text: qsTr("Information")
                    Layout.fillWidth: true
                }

                H5 {
                    text: qsTr("Version: ") + Qt.application.version
                    Layout.fillWidth: true
                }

                H5 {
                    text: qsTr("OS: ") + SystemInformation.kernelType.charAt(0).toUpperCase() + SystemInformation.kernelType.slice(1) + " " + SystemInformation.kernelVersion
                    Layout.fillWidth: true
                }

                H5 {
                    text: qsTr("Qt: ") + QtVersion
                    Layout.fillWidth: true
                }

                H5 {
                    text: qsTr("Arch: ") + SystemInformation.currentCpuArchitecture
                    Layout.fillWidth: true
                }

                MButton {
                    text: qsTr("Copy Info")
                    width: 50
                    accent: Theme.info
                }
            }
        }
    }
    
    RowLayout {
        width: parent.width
        height: parent.height
        Layout.alignment: Qt.AlignHCenter
        spacing: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Button {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            background: Rectangle {
                color: "transparent"
            }
            Icon {
                id: settingsIcon
                color: Theme.text.primary
                iconData: Icons.light["settings"]
                states: [
                    State {
                            name: "hovered"
                            when: settingsItem.hovered
                            PropertyChanges {
                                target: settingsIcon
                                color: "#bfbfbf"
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
                }

                onClicked: Footer.toggleVisibility(settingsMenu, SequentialAnimation)

                HoverHandler {
                    id: settingsItem
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }
        }

        Item { Layout.fillWidth: true }

        Button {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            background: Rectangle {
                color: "transparent"
            }
            Icon {
                id: infoIcon
                color: Theme.text.primary
                iconData: Icons.light["info"]
                states: [
                    State {
                            name: "hovered"
                            when: infoItem.hovered
                            PropertyChanges {
                                target: infoIcon
                                color: "#bfbfbf"
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
                }
                onClicked: {
                    Footer.toggleVisibility(infoMenu, SequentialAnimation)
                }
                HoverHandler {
                    id: infoItem
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }
        }
    }
}
