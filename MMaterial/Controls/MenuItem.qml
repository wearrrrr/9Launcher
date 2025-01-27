import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T

import MMaterial.UI as UI
import MMaterial.Media as Media

T.MenuItem {
    id: control

    property color color: control.highlighted ? UI.Theme.text.primary : UI.Theme.text.secondary
	property Media.IconData iconData: null

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: UI.Size.pixel6
    spacing: UI.Size.pixel16

    icon {
        height: UI.Size.pixel22
        width: UI.Size.pixel22
        color: control.color
    }

    font {
		family: UI.PublicSans.regular
        pixelSize: UI.Size.pixel14
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
                rightMargin: control.indicator.visible || control.arrow.visible ? control.icon.width + control.padding * 2 : 0
            }
            spacing: control.spacing

            anchors {
                fill: contentItemRoot
                leftMargin: control.padding
                rightMargin: control.padding
            }

			Media.Icon {
                size: control.icon.height
                iconData: control.iconData

				color: Qt.color(control.color)
            }

			UI.B2 {
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

	indicator: Media.Icon {
        x: control.mirrored ? control.leftPadding : control.width - width - control.padding * 2
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.checked
		iconData: control.checkable ? Media.Icons.light.check : null
		color: Qt.color(control.color)
        size: control.icon.height + UI.Size.pixel4
    }

	arrow: Media.Icon {
        x: control.mirrored ? control.leftPadding : control.width - width - control.padding * 2
        y: control.topPadding + (control.availableHeight - height) / 2

        size: control.icon.height - UI.Size.pixel4
        visible: control.subMenu
		iconData: control.subMenu ? Media.Icons.light.chevronRight : null
		color: Qt.color(control.color)
    }

    background: Rectangle {
        implicitWidth: 420 * UI.Size.scale
        implicitHeight: UI.Size.pixel36
        x: UI.Size.pixel8
        width: control.width - UI.Size.pixel16
        height: control.height - 2
        radius: UI.Size.pixel6
        color: control.down ? UI.Theme.action.selected : control.highlighted ? UI.Theme.action.hover : "transparent"
    }
}
