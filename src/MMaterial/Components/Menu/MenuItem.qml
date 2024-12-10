import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T

import MMaterial as MMaterial

T.MenuItem {
    id: control

    property color color: control.highlighted ? MMaterial.Theme.text.primary : MMaterial.Theme.text.secondary
    property MMaterial.IconData iconData: null

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: MMaterial.Size.pixel6
    spacing: MMaterial.Size.pixel16

    icon {
        height: MMaterial.Size.pixel22
        width: MMaterial.Size.pixel22
        color: control.color
    }

    font {
        family: MMaterial.PublicSans.regular
        pixelSize: MMaterial.Size.pixel14
    }

    contentItem: Item {
        id: contentItemRoot

        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0

        readonly property bool mirrored: control.mirrored

        opacity: control.enabled ? 1.0 : 0.48

        RowLayout {
            anchors {
                fill: contentItemRoot
                rightMargin: indicator.visible || arrow.visible ? control.icon.width + control.padding * 2 : 0
            }
            spacing: control.spacing

            anchors {
                fill: contentItemRoot
                leftMargin: control.padding
                rightMargin: control.padding
            }

            MMaterial.Icon {
                size: control.icon.height
                iconData: control.iconData

                color: control.color
            }

            MMaterial.B2 {
                Layout.fillHeight: true
                Layout.fillWidth: true

                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                maximumLineCount: 1
                color: control.color
                text: control.text
                font: control.font
            }
        }
    }

    indicator: MMaterial.Icon {
        x: control.mirrored ? control.leftPadding : control.width - width - control.padding * 2
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.checked
        iconData: control.checkable ? MMaterial.Icons.light.check : null
        color: control.color
        size: control.icon.height + MMaterial.Size.pixel4
    }

    arrow: MMaterial.Icon {
        x: control.mirrored ? control.leftPadding : control.width - width - control.padding * 2
        y: control.topPadding + (control.availableHeight - height) / 2

        size: control.icon.height - MMaterial.Size.pixel4
        visible: control.subMenu
        iconData: control.subMenu ? MMaterial.Icons.light.chevronRight : null
        color: control.color
    }

    background: Rectangle {
        implicitWidth: 420 * MMaterial.Size.scale
        implicitHeight: MMaterial.Size.pixel36
        x: MMaterial.Size.pixel8
        width: control.width - MMaterial.Size.pixel16
        height: control.height - 2
        radius: MMaterial.Size.pixel6
        color: control.down ? MMaterial.Theme.action.selected : control.highlighted ? MMaterial.Theme.action.hover : "transparent"
    }
}
