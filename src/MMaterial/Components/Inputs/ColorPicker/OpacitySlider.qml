import QtQuick
import QtQuick.Controls.Material

import MMaterial as MMaterial

Slider {
    id: root

    required property MMaterial.ColorPickerController colorPickerController

    signal editFinished

    implicitWidth: Math.max(root.implicitBackgroundWidth + root.leftInset + root.rightInset, root.rightPadding)
    implicitHeight: Math.max(root.implicitBackgroundHeight + root.topInset + root.bottomInset, root.topPadding + root.bottomPadding)

    wheelEnabled: true
    value: root.colorPickerController.color.a * 100
    focus: false
    from: 0
    to: 100

    onValueChanged: if (root.pressed) root.colorPickerController.color.a = value / 100
    onPressedChanged: {
        if (!pressed) {
            root.editFinished()
        }
    }

    handle: Rectangle {
        x: root.visualPosition * (parent.width - width)
        y: (parent.height - height) / 2
        implicitHeight: root.height
        implicitWidth: height
        radius: height / 2
        smooth: true
        color: "transparent"
        scale: root.pressed ? 0.9 : 1

        border {
            width: MMaterial.Size.pixel2
            color: MMaterial.Theme.other.divider
        }

        Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutQuart } }
    }

    background: Rectangle {
        radius: MMaterial.Size.pixel8

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.0
                color: Qt.rgba(root.colorPickerController.color.r, root.colorPickerController.color.g, root.colorPickerController.color.b, 0)
            }
            GradientStop {
                position: 1
                color: Qt.rgba(root.colorPickerController.color.r, root.colorPickerController.color.g, root.colorPickerController.color.b, 1)
            }
        }
    }
}
