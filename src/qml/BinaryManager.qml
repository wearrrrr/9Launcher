import QtQuick
import QtQuick.Controls.Material
import QtCore
import QtQuick.Layouts

import MMaterial
import Downloader
import FileIO
import "BinaryManager.js" as BinaryManager

Window {
    id: root
    color: "#2f2f2f"
    width: 500
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    property string appData: StandardPaths.writableLocation(StandardPaths.AppDataLocation)
    property string wineVerToSave: ""

    onClosing: {
        downloader.CancelDownloads()
    }

    FileIO {
        id: fileIO;
    }

    Downloader {
        id: downloader
        onDownloadFinished: {
            console.log("Download finished!")
            statusOutput.color = "#70fa6b"
            statusOutput.text = "Download finished!"
            AppSettings.setValue("wine", root.wineVerToSave)
        }
        onDownloadProgress: function (bytesReceived, bytesTotal) {
            var progress = Math.round((bytesReceived / bytesTotal) * 100);
            progressBar.value = progress;
        }
        onDownloadFailed: function (errorString) {
            console.log("Download error! " + errorString)
            progressBar.value = 0;
            statusOutput.color = "#ff4040"
            statusOutput.text = errorString
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
                AppSettings.setValue("wine", "system")
            }
        }

        MButton {
            text: qsTr("Proton GE 7.55")
            Layout.preferredWidth: 150
            onClicked: {
                wineVerToSave = "7-55"
                const dl = BinaryManager.downloadProton("7-55", appData, "/proton/7-55.tar.gz", downloader, fileIO)
                if (!dl) {
                    statusOutput.color = "#e3e3e3"
                    statusOutput.text = "Proton version already downloaded! Setting to default game launcher.."
                    AppSettings.setValue("wine", wineVerToSave)
                }
            }
        }
        // MButton {
        //     text: qsTr("Proton GE 8.32")
        //     Layout.preferredWidth: 150
        //     onClicked: {
        //         wineVerToSave = "8-32"
        //         const dl = BinaryManager.downloadProton("8-32", appData, "/proton/8-32.tar.gz", downloader, fileIO)
        //         if (!dl) {
        //             statusOutput.color = "#e3e3e3"
        //             statusOutput.text = "Proton version already downloaded! Setting to default game launcher.."
        //             AppSettings.setValue("wine", wineVerToSave)
        //         }
        //     }
        // }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 275

        width: parent.width - 50

        Text {
            id: statusOutput
            text: ""
            color: "#ff4040"
            font.pixelSize: 16
            width: parent.width

            wrapMode: Text.WordWrap
        }
    }


}
