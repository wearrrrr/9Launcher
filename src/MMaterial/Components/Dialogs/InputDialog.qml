import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import MMaterial as MMaterial

T.Dialog {
    id: control

    property alias button: button

    property string text: ""
    property color textColor: MMaterial.Theme.text.secondary
    property url imageSource
    property string placeholder: ""

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

    implicitWidth: Math.max(614 * MMaterial.Size.scale, Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                                  contentWidth + leftPadding + rightPadding,
                                                                  implicitHeaderWidth + leftPadding + rightPadding,
                                                                  implicitFooterWidth + leftPadding + rightPadding))

    implicitHeight: Math.max(240 * MMaterial.Size.scale, implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: 0
    spacing: 0
    closePolicy: MMaterial.Dialog.NoAutoClose

    background: Rectangle {
        radius: MMaterial.Size.pixel16
        color: MMaterial.Theme.background.paper
    }

    font {
        family: MMaterial.PublicSans.regular
        pixelSize: MMaterial.Size.pixel16
    }

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

        MMaterial.MaskedImage {
            id: image

            visible: control.imageSource.toString() !== ""
            width: visible ? control.width * 0.3 : 0
            source: control.imageSource
            bottomLeftRadius: MMaterial.Size.pixel16
            topLeftRadius: MMaterial.Size.pixel16
            topRightRadius: 0
            bottomRightRadius: 0

            anchors {
                left: contentItemRoot.left
                top: contentItemRoot.top
                bottom: contentItemRoot.bottom
            }
        }

        ColumnLayout {
            spacing: MMaterial.Size.pixel16

            anchors {
                left: image.right
                right: contentItemRoot.right
                top: contentItemRoot.top
                bottom: contentItemRoot.bottom
                margins: MMaterial.Size.pixel24
            }

            MMaterial.H4 {
                id: titleText

                Layout.fillWidth: true
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: MMaterial.Theme.text.primary
                font.bold: true
            }

            MMaterial.B1 {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: control.text
                font: control.font
                color: control.textColor
            }

            MMaterial.MTextField {
                id: textField

                Layout.fillWidth: true
                type: MMaterial.MTextField.Type.Outlined
                accent: MMaterial.Theme.primary
                placeholder: control.placeholder
                input.anchors.rightMargin: button.visible ? button.width + button.anchors.margins : MMaterial.Size.pixel14

                MMaterial.MButton {
                    id: button
                    text: qsTr("Send")

                    anchors {
                        top: textField.top
                        bottom: textField.bottom
                        right: textField.right
                        margins: MMaterial.Size.pixel4
                    }
                }
            }
        }
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(MMaterial.Theme.background.paper, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Color.transparent(MMaterial.Theme.background.paper, 0.12)
    }
}
