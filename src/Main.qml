import QtQuick
import QtQuick.Layouts
import QtQuick.LocalStorage
import FileIO 1.0
import "main.js" as Core


Window {
    width: 950
    height: 600
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    visible: true
    title: qsTr("9Launcher")
    color: "#2f2f2f"

    FileIO {
        id: fileIO
    }

    ColumnLayout {
        width: parent.width
        spacing: 0

        Item {
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignLeft
            Text {
                text: "Mainline Games"
                color: "white"
                font.bold: true
                font.pixelSize: 24
                padding: 5
            }
        }

        Flow {
            id: mainLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 5
            padding: 10

            Component.onCompleted: Core.populateGamesList()
        }

        Item {
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignLeft
            Text {
                text: "Spinoffs"
                color: "white"
                font.bold: true
                font.pixelSize: 24
                padding: 5
            }
        }

        Flow {
            id: spinoffLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 5
            padding: 10
        }
    }

    Footer { id: footer }

}
