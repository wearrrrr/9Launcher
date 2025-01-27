import QtQuick
import QtQuick.Templates as T

import MMaterial.UI as UI

T.ScrollBar {
    id: control

	property real radius: UI.Size.pixel8

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    contentItem: Rectangle {
		implicitWidth: UI.Size.pixel6
		implicitHeight: UI.Size.pixel6

        radius: control.radius

		color: UI.Theme.action.active

        opacity: 0.0
    }

    background: Rectangle {
		implicitWidth: UI.Size.pixel6
		implicitHeight: UI.Size.pixel6
        color: "#0e000000"
        opacity: 0.0
        visible: control.interactive
        radius: control.radius
    }

    states: State {
        name: "active"
        when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
    }

    transitions: [
        Transition {
            to: "active"
            NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 1.0 }
        },
        Transition {
            from: "active"
            SequentialAnimation {
                PropertyAction{ targets: [control.contentItem, control.background]; property: "opacity"; value: 1.0 }
                PauseAnimation { duration: 2450 }
                NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 0.0 }
            }
        }
    ]
}
