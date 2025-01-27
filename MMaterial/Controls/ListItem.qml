import QtQuick 
import QtQuick.Layouts

import MMaterial.Media as Media
import MMaterial.UI as UI

AbstractListItem{
    id: _root

    default property alias container: _mainLayout.data

    property alias text: _title.text
    property alias icon: _icon
    property alias layout: _mainLayout

	height: UI.Size.pixel46

    RowLayout {
        id: _mainLayout

        anchors{
            fill: _root
			leftMargin: UI.Size.pixel16; rightMargin: UI.Size.pixel12
        }

		Media.Icon {
            id: _icon

			Layout.rightMargin: UI.Size.pixel16
            Layout.alignment: Qt.AlignVCenter

			iconData: Media.IconData{}
			color: _title.color.toString()
			visible: iconData.path != "" }

		UI.B2 {
            id: _title

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            verticalAlignment: Qt.AlignVCenter
			font.family: _root.selected ? UI.PublicSans.semiBold : UI.PublicSans.regular
			color: _root.selected ? UI.Theme.text.primary : UI.Theme.text.secondary
        }
    }
}
