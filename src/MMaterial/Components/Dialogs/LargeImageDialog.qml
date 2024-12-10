import QtQuick
import QtQuick.Layouts

import MMaterial as MMaterial

MMaterial.Dialog {
    id: control

    property real imageHeight: MMaterial.Size.scale * 400
    property url imageSource: MMaterial.Images.realisticShape1.path

    closePolicy: MMaterial.Dialog.NoAutoClose

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding + (image.visible ? control.imageHeight : 0)
        visible: control.iconData || titleText.text !== ""

        MMaterial.MaskedImage {
            id: image
            width: headerRoot.width
            height: control.imageHeight

            topRightRadius: MMaterial.Size.pixel16
            topLeftRadius: MMaterial.Size.pixel16
            bottomLeftRadius: 0
            bottomRightRadius: 0

            source: control.imageSource
            visible: control.imageSource.toString() !== ""
        }

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
}
