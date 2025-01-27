import QtQuick
import QtQuick.Layouts

import MMaterial as MMaterial
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Dialogs.Dialog {
    id: control

    property real imageHeight: UI.Size.scale * 400
    property url imageSource: MMaterial.Images.realisticShape1.path

    closePolicy: Dialogs.Dialog.NoAutoClose

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding + (image.visible ? control.imageHeight : 0)
        visible: control.iconData || titleText.text !== ""

        Controls.MaskedImage {
            id: image
            width: headerRoot.width
            height: control.imageHeight

            topRightRadius: UI.Size.pixel16
            topLeftRadius: UI.Size.pixel16
            bottomLeftRadius: 0
            bottomRightRadius: 0

            source: control.imageSource
            visible: control.imageSource.toString() !== ""
        }

        RowLayout {
            id: headerLayout

            spacing: UI.Size.pixel16

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
}
