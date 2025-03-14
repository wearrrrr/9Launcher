import QtQuick

import MMaterial.UI as UI
import MMaterial.Controls.Inputs as Inputs

Item {
    id: root

    required property color parentBackgroundColor
	required property Inputs.ColorPickerController colorHandler

    property real radius: height / 2

    Rectangle {
        id: outerCircle

        anchors.fill: root

        radius: root.radius
        color: "transparent"

        border {
            width: 1
            color: UI.Theme.text.primary
        }

        Rectangle {
            anchors {
                fill: outerCircle
                margins: 4
            }

            color: root.colorHandler.color
            radius: root.radius

            border {
                width: utils.isSimilar(root.parentBackgroundColor, root.colorHandler.color) ? 1 : 0
                color: UI.Theme.other.divider
            }
        }
    }

	Inputs.ColorUtils { id: utils }
}
