import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial

Item {
    id: setting
    property string text: ""
    property alias switchComponent: settingsSwitch
    property alias switchValue: settingsSwitch.checked

    Connections {
        target: setting
        function onSwitchValueChanged() {
            setting.switchValue = settingsSwitch.checked
        }
    }

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

        MSwitch {
            id: settingsSwitch
            accent: Theme.primary; checked: false;
        }
    }


}
