import QtQuick
import QtQuick.Controls.Material
import QtCore
import QtQuick.Layouts
import MMaterial
import Downloader 1.0

import "BinaryManager.js" as BinaryManager

Window {
    color: "#2f2f2f"
    width:  500
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    onClosing: {
        downloader.CancelDownloads()
    }

    Downloader {
        id: downloader

        Component.onCompleted: {
            console.log("here!");
        }

        onDownloadFinished: {
            console.log("Download finished!")
        }
        
        onDownloadProgress: function (bytesReceived, bytesTotal) {
            var progress = Math.round((bytesReceived / bytesTotal) * 100);
            progressBar.value = progress;
        }

        onDownloadFailed: function (errorString) {
            console.log("Download error! " + errorString)
            progressBar.value = 0;
            // TODO: Show error message
        }
    }

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
        anchors.topMargin: 180

        H5 {
            text: ""
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignRight
        }

        ProgressBar {
            id: progressBar
            from: 0
            to: 100
            height: 15

            background: Rectangle {
                color: "transparent"
                border.color: Material.color(Material.Grey, Material.Shade800)
                border.width: 1
                radius: 8
            }

            contentItem: Rectangle {
                anchors.left: progressBar.left
                anchors.bottom: progressBar.bottom
                height: progressBar.height
                width: progressBar.width * progressBar.value / progressBar.to
                opacity: progressBar.value > 0 ? 1 : 0
                color: Material.color(Material.LightBlue)
                radius: 8
            }

            Layout.preferredWidth: 250
            Layout.alignment: Qt.AlignVCenter
            visible: true

            Behavior on value {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }
        }
        
        H5 {
            text: parseInt(progressBar.value) + "%"
            Layout.topMargin: 7
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignRight
        }
    }



    NumberAnimation {
        id: progressAnimation
        target: progressBar
        property: "value"
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 225

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
                BinaryManager.downloadProton("9-21", StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/proton/9-21.tar.gz", downloader)
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
