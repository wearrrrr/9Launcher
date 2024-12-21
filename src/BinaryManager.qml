import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import MMaterial

Window {
    color: "#2f2f2f"
    width:  500
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    H3 {
        text: qsTr("Binary Manager")
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    H3 {
        text: qsTr("Dosbox-x")
        Layout.preferredWidth: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100

        MButton {
            text: qsTr("Use Sytem Dosbox-x")
            Layout.preferredWidth: 175
            onClicked: {
                console.log("Install")
            }
        }

        MButton {
            text: qsTr("Download Dosbox-x")
            Layout.preferredWidth: 175
            onClicked: {
                console.log("Install")
            }
        }
    }

    H3 {
        text: qsTr("Wine")
        Layout.preferredWidth: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 200

        MButton {
            text: qsTr("Use System Wine")
            Layout.preferredWidth: 150
            onClicked: {
                console.log("Install")
            }
        }
        MButton {
            text: qsTr("Proton GE 9.21")
            Layout.preferredWidth: 150
            onClicked: {
                console.log("Install")
            }
        }
        MButton {
            text: qsTr("Proton GE 8.32")
            Layout.preferredWidth: 150
            onClicked: {
                console.log("Install")
            }
        }
    }
}
