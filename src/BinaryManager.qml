import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import MMaterial

Window {
    color: "#2f2f2f"
    width:  400
    height: 600

    H3 {
        text: qsTr("Binary Manager")
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50

        MButton {
            text: qsTr("Test")
            Layout.preferredWidth: 100
            onClicked: {
                console.log("Install")
            }
        }
        MButton {
            text: qsTr("Test 2")
            Layout.preferredWidth: 100
            onClicked: {
                console.log("Install 2")
            }
        }

        MButton {
            text: qsTr("Test 3")
            Layout.preferredWidth: 100
            onClicked: {
                console.log("Install 3")
            }
        }
    }
}
