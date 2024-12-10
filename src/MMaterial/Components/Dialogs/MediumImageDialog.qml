import QtQuick
import QtQuick.Layouts

import MMaterial as MMaterial

MMaterial.Dialog {
    id: control

    property real imageHeight: MMaterial.Size.scale * 200
    property url imageSource: MMaterial.Images.realisticShape1.path

    closePolicy: MMaterial.Dialog.NoAutoClose
    textColor: MMaterial.Theme.text.primary

    header: Item {
        id: headerRoot

        implicitHeight: headerLayout.implicitHeight + control.topPadding + (image.visible ? control.imageHeight + control.topPadding : 0)
        visible: control.iconData || titleText.text !== ""

        MMaterial.MaskedImage {
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

            spacing: MMaterial.Size.pixel16

            anchors {
                left: headerRoot.left; leftMargin: control.leftPadding
                right: headerRoot.right; rightMargin: control.rightPadding
                bottom: headerRoot.bottom
            }

            Item { Layout.fillWidth: true }

            MMaterial.Icon {
                id: icon
                Layout.alignment: Qt.AlignVCenter
                size: control.iconSize
                iconData: control.iconData
                color: titleText.color
                visible: control.iconData
            }

            MMaterial.H4 {
                id: titleText

                Layout.alignment: Qt.AlignVCenter
                Layout.maximumWidth: control.width - control.leftPadding - control.rightPadding - (icon.visible ? icon.width : 0)
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: control.title
                visible: text !== ""
                elide: Text.ElideRight
                wrapMode: Text.NoWrap
                color: MMaterial.Theme.text.primary
                font.bold: true
            }

            Item { Layout.fillWidth: true }
        }
    }
}
