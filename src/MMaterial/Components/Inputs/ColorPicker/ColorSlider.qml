import QtQuick
import QtQuick.Controls.Material

import MMaterial as MMaterial

Slider {
    id: root

    signal editFinished

    implicitWidth: Math.max(root.implicitBackgroundWidth + root.leftInset + root.rightInset, root.rightPadding)
    implicitHeight: Math.max(root.implicitBackgroundHeight + root.topInset + root.bottomInset, root.topPadding + root.bottomPadding)

    wheelEnabled: true
    value: internal.value
    focus: false

    onValueChanged: internal.value = value
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
                color: "red"
            }
            GradientStop {
                position: (60.0 / 360)
                color: "yellow"
            }
            GradientStop {
                position: (120.0 / 360)
                color: "green"
            }
            GradientStop {
                position: (180.0 / 360)
                color: "cyan"
            }
            GradientStop {
                position: (240.0 / 360)
                color: "blue"
            }
            GradientStop {
                position: (300.0 / 360)
                color: "magenta"
            }
            GradientStop {
                position: 1.0
                color: "red"
            }
        }
    }

    MMaterial.ColorSliderController {
        id: internal
    }
}
