import QtQuick
import QtQuick.Layouts

import MMaterial.UI

ListView {
	id: root

	property bool interactive: false

	signal selected(index : int)

	property Component splitterDelegate: Component {
		Item {
			id: splitter

			Rectangle {
				anchors.centerIn: splitter
				height: Size.pixel4
				width: Size.pixel4
				color: Theme.text.disabled
				radius: height / 2
			}
		}
	}

	model: [qsTr("First level"), qsTr("Second level")]

	implicitHeight: Size.pixel22
	implicitWidth: contentWidth
	orientation: ListView.Horizontal
	spacing: Size.pixel16

	delegate: RowLayout {
		id: breadcrumbsDelegate

		required property int index
		required property string modelData

		height: root.height
		spacing: 0

		Loader {
			id: splitterLoader

			Layout.fillHeight: true
			Layout.rightMargin: root.spacing

			sourceComponent: root.splitterDelegate
			visible: breadcrumbsDelegate.index !== 0
		}

		B2 {
			id: splitterLabel

			Layout.fillHeight: true
			verticalAlignment: Qt.AlignVCenter
			text: breadcrumbsDelegate.modelData

			color: breadcrumbsDelegate.index === root.model.length - 1 ? Theme.text.disabled : Theme.text.primary
			opacity: splitterLabelMA.pressed ? 0.7 : (splitterLabelMA.containsMouse ? 0.8 : 1)

			MouseArea {
				id: splitterLabelMA

				anchors.fill: splitterLabel
				cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
				hoverEnabled: enabled
				enabled: root.interactive

				onClicked: root.selected(breadcrumbsDelegate.index)
			}
		}
	}
}
