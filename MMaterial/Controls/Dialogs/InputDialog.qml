import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Controls.Inputs as Inputs

T.Dialog {
    id: control

    property alias button: button

    property string text: ""
    property color textColor: UI.Theme.text.secondary
    property url imageSource
    property string placeholder: ""

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

    implicitWidth: Math.max(614 * UI.Size.scale, Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                                  contentWidth + leftPadding + rightPadding,
                                                                  implicitHeaderWidth + leftPadding + rightPadding,
                                                                  implicitFooterWidth + leftPadding + rightPadding))

    implicitHeight: Math.max(240 * UI.Size.scale, implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: 0
    spacing: 0
    closePolicy: Dialog.NoAutoClose

    background: Rectangle {
        radius: UI.Size.pixel16
        color: UI.Theme.background.paper
    }

    font {
        family: UI.Font.normal
        pixelSize: UI.Size.pixel16
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

        Controls.MaskedImage {
            id: image

            visible: control.imageSource.toString() !== ""
            width: visible ? control.width * 0.3 : 0
            source: control.imageSource
            bottomLeftRadius: UI.Size.pixel16
            topLeftRadius: UI.Size.pixel16
            topRightRadius: 0
            bottomRightRadius: 0

            anchors {
                left: contentItemRoot.left
                top: contentItemRoot.top
                bottom: contentItemRoot.bottom
            }
        }

        ColumnLayout {
            spacing: UI.Size.pixel16

            anchors {
                left: image.right
                right: contentItemRoot.right
                top: contentItemRoot.top
                bottom: contentItemRoot.bottom
                margins: UI.Size.pixel24
            }

            UI.H4 {
                id: titleText

                Layout.fillWidth: true
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: UI.Theme.text.primary
                font.bold: true
            }

            UI.B1 {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: control.text
                font: control.font
                color: control.textColor
            }

			Inputs.TextField {
                id: textField

                Layout.fillWidth: true
				type: Inputs.TextField.Type.Outlined
                accent: UI.Theme.primary
				placeholderText: control.placeholder
				anchors.rightMargin: button.visible ? button.width + button.anchors.margins : UI.Size.pixel14

                Controls.MButton {
                    id: button
                    text: qsTr("Send")

                    anchors {
                        top: textField.top
                        bottom: textField.bottom
                        right: textField.right
                        margins: UI.Size.pixel4
                    }
                }
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
