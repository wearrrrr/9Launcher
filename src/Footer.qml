import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    width: parent.width
    height: 40
    anchors.bottom: parent.bottom
    color: "#212121"

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

            onClicked: {
                console.log("Settings clicked")
            }

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
