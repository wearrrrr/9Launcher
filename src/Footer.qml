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

    Rectangle {
        id: settingsMenu
        width: 300
        height: 250
        color: "#212121"
        opacity: 0
        visible: false
        radius: 8

        anchors.bottom: parent.top
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 8

        Behavior on opacity {
            PropertyAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }

        SequentialAnimation on visible {
            running: false
            loops: 1

            ScriptAction {
                script: if (settingsMenu.opacity === 0) settingsMenu.visible = false;
            }
        }

        Item {
            width: parent.width
            height: parent.height


            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 5
            anchors.bottomMargin: 5

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 10

                Setting {
                    text: "Warnings"
                    id: warningsSetting
                    update: "warnings"
                }

                Setting {
                    text: "Discord RPC"
                    id: rpcSetting
                    update: "rpc"
                }

                Setting {
                    text: "File Logging"
                    id: fileLoggingSetting
                    update: "fileLogging"
                }

                Setting {
                    text: "Launch Info"
                    id: launchInfoSetting
                    update: "launchInfo"
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
                    console.log("Info clicked")
                }
                HoverHandler {
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                    id: infoItem
                }
        }
    }
}
