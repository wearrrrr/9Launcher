import QtQuick
import QtQuick.Layouts

import MMaterial as MMaterial
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.Controls as Controls
import MMaterial.Media as Media
import MMaterial.UI as UI

Dialogs.Dialog {
    id: control

    property real imageHeight: UI.Size.scale * 200
    property url imageSource: MMaterial.Images.realisticShape1.path

    closePolicy: Dialogs.Dialog.NoAutoClose
    textColor: UI.Theme.text.primary

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding + (image.visible ? control.imageHeight + control.topPadding : 0)
        visible: control.iconData || titleText.text !== ""

        Controls.MaskedImage {
            id: image

            height: control.imageHeight
            width: height
            radius: height / 2
            source: control.imageSource

            anchors {
                horizontalCenter: headerRoot.horizontalCenter
                top: headerRoot.top; topMargin: control.topPadding
            }
        }

        RowLayout {
            id: headerLayout

            spacing: UI.Size.pixel16

            anchors {
                left: headerRoot.left; leftMargin: control.leftPadding
                right: headerRoot.right; rightMargin: control.rightPadding
                bottom: headerRoot.bottom
            }

            Item { Layout.fillWidth: true }

            Media.Icon {
                id: icon
                Layout.alignment: Qt.AlignVCenter
                size: control.iconSize
                iconData: control.iconData
				color: titleText.color.toString()
                visible: control.iconData
            }

            UI.H4 {
                id: titleText

                Layout.alignment: Qt.AlignVCenter
                Layout.maximumWidth: control.width - control.leftPadding - control.rightPadding - (icon.visible ? icon.width : 0)
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: UI.Theme.text.primary
                font.bold: true
            }

            Item { Layout.fillWidth: true }
        }
    }
}
