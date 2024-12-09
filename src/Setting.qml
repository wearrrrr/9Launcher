import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: setting
    property string text: ""
    property alias switchComponent: settingsSwitch

    Layout.fillWidth: true
    Layout.fillHeight: true

    width: parent.width
    height: parent.height

    RowLayout {
        width: parent.width
        height: parent.height
        spacing: 10
        Text {
            Layout.preferredHeight: 18

            text: setting.text
            color: "#fff"
            font.pixelSize: 18
            font.bold: true
        }

        Item {
            Layout.fillWidth: true
        }

        Switch {
            id: settingsSwitch
            Layout.preferredHeight: 18
            checked: false
            onCheckedChanged: {
                console.log("Settings switch toggled to " + checked)
            }
        }
    }


}
