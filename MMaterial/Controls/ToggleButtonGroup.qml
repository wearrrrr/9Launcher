import QtQuick

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Item {
	id: root

	property alias model: listView.model
	property alias background: background
	property alias delegate: listView.delegate
	property alias currentIndex: listView.currentIndex
	property alias currentItem: listView.currentItem

	property alias orientation: listView.orientation

	component GroupButton: Controls.MToggleButton {
		border.width: 0
		icon.iconData: Media.Icons.light.check
		customCheckImplementation: true
		size: UI.Size.Grade.S
	}

	implicitHeight: d.prefHeight
	implicitWidth: d.prefWidth

	QtObject {
		id: d

		property real baseSize: root.size == UI.Size.Grade.L ? 56 * UI.Size.scale : root.size == UI.Size.Grade.M ? 48 * UI.Size.scale : 36 * UI.Size.scale
		property real baseMargins: root.size == UI.Size.Grade.L ? 16 * UI.Size.scale : root.size == UI.Size.Grade.M ? 12 * UI.Size.scale : 8 * UI.Size.scale

		property real prefHeight: (orientation == Qt.Horizontal ? d.baseSize + d.baseMargins : listView.contentHeight + (listView.contentHeight > 0 ? + d.baseMargins : 0))
		property real prefWidth: (orientation == Qt.Vertical ? d.baseSize + d.baseMargins : listView.contentWidth + (listView.contentWidth > 0 ? + d.baseMargins : 0))
	}

	Rectangle {
		id: background

		height: !visible && root.orientation == Qt.Vertical ? 0 : d.prefHeight
		width: !visible && root.orientation == Qt.Horizontal ? 0 : d.prefWidth
		radius: UI.Size.pixel8
		color: UI.Theme.background.paper

		border {
			width: 1
			color: UI.Theme.main.transparent.p24
		}

		Behavior on width {
			NumberAnimation {
				duration: 170
				easing.type: Easing.InOutQuad
			}
		}

		Behavior on height {
			NumberAnimation {
				duration: 170
				easing.type: Easing.InOutQuad
			}
		}
	}

	ListView {
		id: listView

		orientation: Qt.Horizontal

		spacing: d.baseMargins / 2
		interactive: false

		height: root.height - d.baseMargins
		width: root.width - d.baseMargins

		anchors {
			centerIn: root
		}

		populate: Transition {
			ParallelAnimation {
				NumberAnimation {
					property: "scale"
					from: 0
					to: 1.0
					duration: 400
					easing.type: Easing.OutBack
				}

				NumberAnimation {
					property: "opacity"
					from: 0
					to: 1.0
					duration: 400
				}
			}
		}

		displaced: Transition {
			NumberAnimation {
				properties: "scale, opacity"
				duration: 400
				easing.type: Easing.InBack
			}
		}
	}
}
