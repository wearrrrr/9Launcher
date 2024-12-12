import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import MMaterial as MMaterial

T.Dialog {
    id: control

    default property alias buttons: buttonBox.data

    property string text: ""
    property MMaterial.IconData iconData: null
    property real iconSize: MMaterial.Size.pixel24
    property color textColor: MMaterial.Theme.text.secondary
    property bool showXButton: false

    component DialogButton: MMaterial.MButton {
        Layout.alignment: Qt.AlignRight
        size: MMaterial.Size.Grade.M
    }

    component DialogAlertButton: MMaterial.MButton {
        Layout.alignment: Qt.AlignRight
        accent: MMaterial.Theme.error
        size: MMaterial.Size.Grade.M
    }

    component DialogCloseButton: MMaterial.MButton {
        Layout.alignment: Qt.AlignRight
        accent: MMaterial.Theme.passive
        size: MMaterial.Size.Grade.M
        type: MMaterial.MButton.Type.Outlined
    }

    implicitWidth: Math.min(480 * MMaterial.Size.scale, Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                                  contentWidth + leftPadding + rightPadding,
                                                                  implicitHeaderWidth + leftPadding + rightPadding,
                                                                  implicitFooterWidth + leftPadding + rightPadding))

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: MMaterial.Size.pixel24
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

        radius: MMaterial.Size.pixel16
        color: MMaterial.Theme.background.paper

        MMaterial.Icon {
            id: closeIcon

            visible: control.showXButton
            iconData: MMaterial.Icons.light.close
            size: MMaterial.Size.pixel12
            color: MMaterial.Theme.text.primary
            interactive: true

            anchors {
                right: bgRoot.right;
                top: bgRoot.top;
                margins: MMaterial.Size.pixel6
            }

            onClicked: control.reject()
        }
    }

    font {
        family: MMaterial.PublicSans.regular
        pixelSize: MMaterial.Size.pixel16
    }

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding
        visible: control.iconData || titleText.text !== ""

        RowLayout {
            id: headerLayout

            spacing: MMaterial.Size.pixel16

            anchors {
                left: headerRoot.left; leftMargin: control.leftPadding
                right: headerRoot.right; rightMargin: control.rightPadding
                bottom: headerRoot.bottom
            }

            MMaterial.Icon {
                id: icon
                Layout.alignment: Qt.AlignVCenter
                size: control.iconSize
                iconData: control.iconData
                color: titleText.color
                visible: control.iconData
            }

            MMaterial.H6 {
                id: titleText

                Layout.rightMargin: control.rightPadding + headerLayout.x
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Qt.AlignVCenter
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: MMaterial.Theme.text.primary
            }
        }
    }

    contentItem: MMaterial.B1 {
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

            spacing: MMaterial.Size.pixel12

            anchors {
                left: footerRoot.left; leftMargin: control.leftPadding
                right: footerRoot.right; rightMargin: control.rightPadding
                top: footerRoot.top
            }
        }
    }

    T.Overlay.modal: Rectangle {
        color: Qt.alpha(MMaterial.Theme.background.paper, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.alpha(MMaterial.Theme.background.paper, 0.12)
    }
}
