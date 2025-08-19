pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial.UI as UI
import MMaterial.Media as Media
import MMaterial.Controls as Controls

Item {
    id: _root

	implicitWidth: _decrementButton.width + _incrementButton.width + (Math.min(visiblePageCount, _listView.count) * (UI.Size.pixel40 + _listView.spacing) + _listView.spacing)
    implicitHeight: UI.Size.pixel40

    required property SwipeView indexView

    property int visiblePageCount: 3
    property int numberOfPages: indexView.count

	property int selectedType: Controls.MFabButton.Type.Soft
    property int radius: 10

	Controls.MFabButton {
        id: _decrementButton

        anchors.left: _root.left

        height: _root.height
        width: height

        horizontalPadding: 0
        verticalPadding: 0

        radius: _root.radius
		type: Controls.MFabButton.Type.Text
        enabled: _listView.currentIndex > 0
		accent: UI.Theme.defaultNeutral
        opacity: enabled ? 1 : 0.5

        leftIcon {
            Layout.rightMargin: 2 * scale
            iconData: Media.Icons.light.chevronLeft
            scale: 1.3
        }

        onClicked: _root.indexView.decrementCurrentIndex();
    }

    ListView {
        id: _listView

        anchors{
            left: _decrementButton.right
            right: _incrementButton.left
            margins: _listView.spacing
        }

        height: _root.height

        model: _root.numberOfPages
        currentIndex: _root.indexView.currentIndex
        spacing: UI.Size.pixel6
        orientation: ListView.Horizontal
        clip: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Center);

		delegate: Controls.MFabButton {

            required property var modelData
            required property int index

            height: _root.height
            width: height

            radius: _root.radius
            text: (modelData+1)
			accent: ListView.isCurrentItem ? UI.Theme.primary : UI.Theme.defaultNeutral
			type: ListView.isCurrentItem ? _root.selectedType : Controls.MFabButton.Type.Text

            horizontalPadding: 0
            verticalPadding: 0

            title.font.family: UI.Font.normal
            title.font.variableAxes: { "wght": ListView.isCurrentItem ? 600 : 400 }

            onClicked: _root.indexView.currentIndex = index;
        }
    }

	Controls.MFabButton {
        id: _incrementButton

        anchors.right: _root.right

        height: _root.height
        width: height

        horizontalPadding: 0
        verticalPadding: 0

        radius: _root.radius
		accent: UI.Theme.defaultNeutral
		type: Controls.MFabButton.Type.Text
        enabled: _listView.currentIndex < _listView.count-1
        opacity: enabled ? 1 : 0.5

        leftIcon {
            Layout.leftMargin: 2 * scale
            iconData: Media.Icons.light.chevronRight
            scale: 1.3
        }

        onClicked: _root.indexView.incrementCurrentIndex();
    }
}
