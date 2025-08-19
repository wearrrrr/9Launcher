import QtQuick
import QtQuick.Shapes

import MMaterial.UI

Shape {
	id: root

	property int size: 144
	property real peakWidth: -0.58       // 0 = narrow hill, 1 = wide hill
	property real subPeakWidth: -0.27    // 0 = sharp control points, 1 = wide pull
	property color color: Theme.background.paper

	width: root.size
	height: root.size * 62 / 144

	QtObject {
		id: d

		readonly property real controlSpread: 50

		readonly property real leftControl1X: 140
		readonly property real leftControl2X: 130
		readonly property real rightControl1X: 382
		readonly property real rightControl2X: 372

		function ny(y) {
			return root.height * ((y - 192) / 192);
		}

		function computeX(xBase, direction) {
			return root.width * (
				(xBase + direction * controlSpread * root.peakWidth * root.subPeakWidth) / 512
			);
		}
	}

	ShapePath {
		strokeWidth: 0
		strokeColor: root.color
		fillColor: root.color

		startX: 0
		startY: d.ny(320)

		// First half of hill
		PathCubic {
			x: root.width * 0.5
			y: d.ny(192)

			control1X: d.computeX(d.leftControl1X, -1)
			control1Y: d.ny(300)

			control2X: d.computeX(d.leftControl2X, +1)
			control2Y: d.ny(192)
		}

		// Second half of hill
		PathCubic {
			x: root.width
			y: d.ny(320)

			control1X: d.computeX(d.rightControl1X, -1)
			control1Y: d.ny(192)

			control2X: d.computeX(d.rightControl2X, +1)
			control2Y: d.ny(300)
		}

		// Closing the shape
		PathLine { x: root.width; y: d.ny(384) }
		PathLine { x: 0; y: d.ny(384) }
		PathLine { x: 0; y: d.ny(320) }
	}
}

