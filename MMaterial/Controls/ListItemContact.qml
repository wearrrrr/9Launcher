import QtQuick 
import QtQuick.Layouts

import MMaterial.Media as Media
import MMaterial.UI as UI

AbstractListItem{
    id: _root

    default property alias container: _mainLayout.data

    property alias title: _title.text
    property alias subtitle: _subtitle.text
    property alias icon: _icon
    property alias avatar: _avatar
    property alias layout: _mainLayout

	height: 68 * UI.Size.scale

    containsMouse: mouseArea.containsMouse || _icon.containsMouse

    RowLayout {
        id: _mainLayout

        anchors{
            fill: _root
			margins: UI.Size.pixel12
			leftMargin: UI.Size.pixel16; rightMargin: UI.Size.pixel16
        }

        Avatar{
            id: _avatar

			Layout.rightMargin: UI.Size.pixel16
            Layout.fillHeight: true
            Layout.preferredWidth: height

            title: _title.text
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

			UI.Subtitle2 {
                id: _title

                Layout.fillWidth: true
                Layout.fillHeight: true

                verticalAlignment: Qt.AlignTop
				color: UI.Theme.text.primary
                text: "John Doe"
            }
			UI.B2 {
                id: _subtitle

                Layout.fillWidth: true
                Layout.fillHeight: true

                verticalAlignment: Qt.AlignBottom
				color: UI.Theme.text.secondary
                text: "johhny_doe@gmail.com"
            }
        }

		Media.Icon {
            id: _icon

            Layout.alignment: Qt.AlignVCenter
			color: UI.Theme.action.active.toString()
            visible: iconData.path != ""
			iconData: Media.Icons.light.call
            interactive: true
        }
    }
}
