import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
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

        function toggleVisibility() {
            if (settingsMenu.opacity === 0) {
                settingsMenu.visible = true;
                settingsMenu.opacity = 1;
            } else {
                settingsMenu.opacity = 0;
                SequentialAnimation.running = true;
            }
        }

        // Container for the actual setting and it's associated toggle switch
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
                }

                Setting {
                    text: "Discord RPC"
                    id: rpcSetting
                }

                Setting {
                    text: "File Logging"
                    id: fpsSetting
                }

                Setting {
                    text: "Launch Info"
                    id: launchInfoSetting
                }
            }
        }
    }
    
    RowLayout {
        width: parent.width
        height: parent.height
        Layout.alignment: Qt.AlignHCenter
        spacing: 10

        Button {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            background: Rectangle {
                color: "transparent"
            }
            Text {
                id: settingsIcon
                text: "\ue804" // icon-cog
                font.family: "fontello"
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "#fff"
                leftPadding: 8
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

            onClicked: settingsMenu.toggleVisibility()

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
            Text {
                id: infoIcon
                text: "\ue801" // icon-help
                font.family: "fontello"
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "#fff"
                rightPadding: 8
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
