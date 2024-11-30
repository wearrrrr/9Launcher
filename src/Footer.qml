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
                text: "\ue804" // icon-cog
                font.family: "fontello"
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "#fff"
                leftPadding: 8
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item { Layout.fillWidth: true }

        Item {
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            Text {
                text: "\ue801" // icon-help
                font.family: "fontello"
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "#fff"
                rightPadding: 8
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
