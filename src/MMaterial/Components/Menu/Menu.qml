import QtQuick
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T

import MMaterial as MMaterial

T.Menu {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    overlap: 1

    delegate: MenuItem { height: MMaterial.Size.pixel36 }

    enter: Transition {
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    contentItem: Item {
        id: contentItemRoot

        implicitHeight: listView.implicitHeight + MMaterial.Size.pixel16

        ListView {
            id: listView
            anchors.centerIn: contentItemRoot
            implicitHeight: contentHeight
            width: contentItemRoot.width
            model: control.contentModel
            spacing: 0
            interactive: Window.window
                         ? contentHeight + control.topPadding + control.bottomPadding > control.height
                         : false
            clip: true
            currentIndex: control.currentIndex
        }
    }

    background: Rectangle {
        radius: MMaterial.Size.pixel6
        implicitWidth:  MMaterial.Size.scale * 420
        implicitHeight: MMaterial.Size.pixel36
        color: MMaterial.Theme.background.paper

        border {
            color:  MMaterial.Theme.other.divider
            width: 1
        }
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.12)
    }
}
