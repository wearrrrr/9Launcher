import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import "footer.js" as Footer

Rectangle {
    // "left" or "right"
    property var alignTo: null

    color: "#212121"
    opacity: 0
    visible: false
    radius: 8

    MouseArea {
        anchors.fill: parent
    }

    anchors.bottom: parent.top
    anchors.bottomMargin: 10

    anchors.left: alignTo === "left" ? parent.left : undefined
    anchors.right: alignTo === "right" ? parent.right : undefined
    
    anchors.leftMargin: alignTo === "left" ? 8 : undefined
    anchors.rightMargin: alignTo === "right" ? 8 : undefined

    Behavior on opacity {
        PropertyAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
            // Set self to disabled when opacity is 0
            onStopped: if (opacity === 0) enabled = false;
        }
    }

    SequentialAnimation on visible {
        running: false
        loops: 1

        ScriptAction {
            script: if (settingsMenu.opacity === 0) settingsMenu.visible = false;
        }
    }
}