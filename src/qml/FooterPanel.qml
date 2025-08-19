import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial.UI as UI

import "footer.js" as Footer

Rectangle {
    id: panel

    property string alignTo: "left"
    property int anchorMargin: 8

    color: UI.Theme.background.paper
    opacity: 0
    visible: false
    radius: 8

    anchors.bottom: parent.top
    anchors.bottomMargin: 10

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "left"
            AnchorChanges {
                target: panel
                anchors.left: parent.left
                anchors.right: undefined
            }
            PropertyChanges {
                panel.anchors.leftMargin: settingsMenu.anchorMargin
                panel.anchors.rightMargin: 0
            }
        },
        State {
            name: "right"
            AnchorChanges {
                target: panel
                anchors.right: parent.right
                anchors.left: undefined
            }
            PropertyChanges {
                panel.anchors.rightMargin: panel.anchorMargin
                panel.anchors.leftMargin: 0
            }
        }
    ]

    state: alignTo

    Behavior on opacity {
        PropertyAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
            onStopped: if (opacity === 0)
                enabled = false
        }
    }

    SequentialAnimation {
        running: false
        loops: 1

        ScriptAction {
            script: if (panel.opacity === 0)
                panel.visible = false
        }
    }
}
