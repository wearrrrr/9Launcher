import QtQuick

import MMaterial as MMaterial

Item {
    id: root

    required property color parentBackgroundColor
    required property MMaterial.ColorPickerController colorHandler

    property real radius: height / 2

    Rectangle {
        id: outerCircle

        anchors.fill: root

        radius: root.radius
        color: "transparent"

        border {
            width: 1
            color: MMaterial.Theme.text.primary
        }

        Rectangle {
            anchors {
                fill: outerCircle
                margins: 4
            }

            color: root.colorHandler.color
            radius: root.radius

            border {
                width: utils.isSimilar(root.parentBackgroundColor, colorHandler.color) ? 1 : 0
                color: MMaterial.Theme.other.divider
            }
        }
    }

    MMaterial.ColorUtils { id: utils }
}
