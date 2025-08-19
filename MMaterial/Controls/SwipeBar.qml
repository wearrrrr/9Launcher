import QtQuick
import QtQuick.Controls

import MMaterial.UI

Rectangle {
	id: root

	property int swipeThreshold: width / 4
	property bool swiping: false
	property real startX: 0

	signal swipedLeft()
	signal swipedRight()

	implicitWidth: parent.width
	implicitHeight: Size.pixel8

	color: Theme.background.paper

	MouseArea {
		id: swipeArea
		anchors.fill: parent

		onPressed: {
			root.startX = mouseX
			root.swiping = true
		}

		onReleased: {
			if (root.swiping) {
				var distance = mouseX - root.startX

				if (Math.abs(distance) > root.swipeThreshold) {
					if (distance > 0) {
						root.swipedRight()
					} else {
						root.swipedLeft()
					}
				}

				root.swiping = false
			}
		}

		onPositionChanged: {
			if (root.swiping) {
				var distance = mouseX - root.startX
			}
		}
	}
}
