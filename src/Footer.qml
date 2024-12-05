import QtQuick
import QtQuick.Layouts

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
        Item {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
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

            HoverHandler {
                id: settingsItem
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item { Layout.fillWidth: true }

        Item {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            Text {
                id: helpIcon
                text: "\ue801" // icon-help
                font.family: "fontello"
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "#fff"
                rightPadding: 8
                states: [
                    State {
                        name: "hovered"
                        when: helpItem.hovered
                        PropertyChanges {
                            target: helpIcon
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
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
                id: helpItem
            }
        }
    }
}
