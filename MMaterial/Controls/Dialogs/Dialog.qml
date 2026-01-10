import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts

import MMaterial.Media as Media
import MMaterial.Controls as Controls
import MMaterial.UI as UI

T.Dialog {
    id: control

    default property alias buttons: buttonBox.data

    property string text: ""
    property Media.IconData iconData: null
	property real iconSize: UI.Size.pixel24
    property color textColor: UI.Theme.text.secondary
    property bool showXButton: false
	property real maxWidth: 480 * UI.Size.scale

	component DialogButton: Controls.MButton {
        Layout.alignment: Qt.AlignRight
        size: UI.Size.Grade.M
    }

	component DialogAlertButton: Controls.MButton {
        Layout.alignment: Qt.AlignRight
        accent: UI.Theme.error
        size: UI.Size.Grade.M
    }

	component DialogCloseButton: Controls.MButton {
        Layout.alignment: Qt.AlignRight
		accent: UI.Theme.passive
        size: UI.Size.Grade.M
		type: Controls.MButton.Type.Outlined
    }

	implicitWidth: Math.min(control.maxWidth, Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                                  contentWidth + leftPadding + rightPadding,
                                                                  implicitHeaderWidth + leftPadding + rightPadding,
                                                                  implicitFooterWidth + leftPadding + rightPadding))

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: UI.Size.pixel24
    spacing: 0

    enter: Transition {
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    background: Rectangle {
        id: bgRoot

        radius: UI.Size.pixel16
        color: UI.Theme.background.paper

		border {
			width: control.dim ? 0 : 1
			color: UI.Theme.other.outline
		}

        Media.Icon {
            id: closeIcon

            visible: control.showXButton
            iconData: Media.Icons.light.close
            size: UI.Size.pixel24
			color: UI.Theme.text.primary.toString()
            interactive: true

            anchors {
                right: bgRoot.right;
                top: bgRoot.top;
                margins: UI.Size.pixel12
            }

            onClicked: control.reject()
        }
    }

    font {
        family: UI.Font.normal
        pixelSize: UI.Size.pixel16
    }

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding
        visible: control.iconData || titleText.text !== ""

        RowLayout {
            id: headerLayout

			spacing: UI.Size.pixel10

            anchors {
                left: headerRoot.left; leftMargin: control.leftPadding
                right: headerRoot.right; rightMargin: control.rightPadding
                bottom: headerRoot.bottom
            }

            Media.Icon {
                id: icon
                Layout.alignment: Qt.AlignVCenter
                size: control.iconSize
                iconData: control.iconData
				color: titleText.color.toString()
                visible: control.iconData
            }

            UI.H6 {
                id: titleText

                Layout.rightMargin: control.rightPadding + headerLayout.x
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Qt.AlignVCenter
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: UI.Theme.text.primary
            }
        }
    }

    contentItem: UI.B1 {
        id: contentItem

        verticalAlignment: Qt.AlignVCenter
        text: control.text
        font: control.font
        color: control.textColor
    }

    footer: Item {
        id: footerRoot

        implicitHeight: buttonBox.implicitHeight + control.bottomPadding

        RowLayout {
            id: buttonBox

            spacing: UI.Size.pixel12

            anchors {
                left: footerRoot.left; leftMargin: control.leftPadding
                right: footerRoot.right; rightMargin: control.rightPadding
                top: footerRoot.top
            }
        }
    }

    T.Overlay.modal: Rectangle {
        color: Qt.alpha(UI.Theme.background.paper, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.alpha(UI.Theme.background.paper, 0.12)
    }
}
