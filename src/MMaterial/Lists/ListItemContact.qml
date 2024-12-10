import QtQuick 
import QtQuick.Layouts

import MMaterial

AbstractListItem{
    id: _root

    default property alias container: _mainLayout.data

    property alias title: _title.text
    property alias subtitle: _subtitle.text
    property alias icon: _icon
    property alias avatar: _avatar
    property alias layout: _mainLayout

    height: 68 * Size.scale

    containsMouse: mouseArea.containsMouse || _icon.containsMouse

    RowLayout {
        id: _mainLayout

        anchors{
            fill: _root
            margins: Size.pixel12
            leftMargin: Size.pixel16; rightMargin: Size.pixel16
        }

        Avatar{
            id: _avatar

            Layout.rightMargin: Size.pixel16
            Layout.fillHeight: true
            Layout.preferredWidth: height

            title: _title.text
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Subtitle2 {
                id: _title

                Layout.fillWidth: true
                Layout.fillHeight: true

                verticalAlignment: Qt.AlignTop
                color: Theme.text.primary
                text: "John Doe"
            }
            B2 {
                id: _subtitle

                Layout.fillWidth: true
                Layout.fillHeight: true

                verticalAlignment: Qt.AlignBottom
                color: Theme.text.secondary
                text: "johhny_doe@gmail.com"
            }
        }

        Icon {
            id: _icon

            Layout.alignment: Qt.AlignVCenter
            color: Theme.action.active
            visible: iconData.path != ""
            iconData: Icons.light.call
            interactive: true
        }
    }
}
