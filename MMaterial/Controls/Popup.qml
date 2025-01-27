pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T

import MMaterial.UI as UI

T.Popup {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    background: Rectangle {
		radius: UI.Size.pixel6
		implicitWidth:  UI.Size.scale * 420
		implicitHeight: UI.Size.pixel36
		color: UI.Theme.background.paper
		border.color:  UI.Theme.background.neutral
    }

    T.Overlay.modal: Rectangle {
        color: Qt.alpha(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.alpha(control.palette.shadow, 0.12)
    }

    enter: Transition {
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }
}
