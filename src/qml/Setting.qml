import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial

Item {
    id: setting
    property string text: ""
    property string update: ""
    property alias switchComponent: settingsSwitch
    property alias switchValue: settingsSwitch.checked

    Layout.fillWidth: true
    Layout.fillHeight: true

    width: parent.width
    height: parent.height

    RowLayout {
        width: parent.width
        height: 32
        spacing: 10
        H5 {
            Layout.preferredHeight: 24
            text: setting.text
            color: "#fff"
            font.bold: true
        }

        Item {
            Layout.fillWidth: true
        }

        MSwitch {
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignHCenter
            id: settingsSwitch
            accent: Theme.primary;
            checked: AppSettings.value(setting.update, false)

            function saveSetting(key, value) {
                AppSettings.setValue(key, value);

                if (key == "rpc") {
                    if (value) {
                        RPC.initDiscord();
                    } else {
                        RPC.stopRPC();
                    }
                }
            }

            onCheckedChanged: {
                saveSetting(setting.update, settingsSwitch.checked);
            }
        }
    }


}
