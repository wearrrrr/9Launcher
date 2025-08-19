import QtQuick
import MMaterial.Media as Media
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import QtQuick.Controls

Controls.MToggleButton {
	id: mainButton

	property alias model: numberRepeater.model
	property alias popup: buttonPopup
	property real startDegree: 0
	property real endDegree: 270
	property real spacing: 1

	property bool mobileMode: Qt.platform.os === "android" || Qt.platform.os === "ios"

	component CustomButton: Rectangle {
		id: delRoot

		// property alias size: button.size
		required property Media.IconData iconData
		required property string text

		property alias checked: button.checked
		property alias label: label
		property alias button: button

		property bool alwaysOpen: false

		readonly property bool hovered: hoverHandler.hovered || button.mouseArea.containsMouse
		readonly property bool pressed: delRootMA.pressed || button.mouseArea.pressed
		property real extendedWidth: button.width + label.implicitWidth + label.padding * 2

		signal activated

		color: UI.Theme.background.main
		radius: button.radius
		opacity: delRoot.pressed ? 0.8 : 1

		implicitHeight: button.height
		implicitWidth: button.width + label.width

		border {
			width: 1
			color: Qt.rgba(button.border.color.r, button.border.color.g, button.border.color.b, 0.25)
		}

		states: [
			State {
				name: "opened"
				when: delRoot.alwaysOpen || delRoot.hovered || delRoot.pressed

				PropertyChanges {
					target: delRoot
					implicitWidth: delRoot.extendedWidth
				}

				PropertyChanges {
					target: label
					opacity: 1
				}
			},
			State {
				name: "closed"
				when: true

				PropertyChanges {
					target: delRoot
					implicitWidth: delRoot.height
				}

				PropertyChanges {
					target: label
					opacity: 0
				}
			}
		]

		transitions: [
			Transition {
				from: "closed"
				to: "opened"
				reversible: true

				ParallelAnimation {
					SequentialAnimation {
						PauseAnimation {
							duration: 100
						}
						NumberAnimation {
							properties: "opacity"
							duration: 200
							easing.type: Easing.InOutQuad
						}
					}

					NumberAnimation {
						properties: "implicitWidth"
						duration: 200
						easing.type: Easing.InOutQuad
					}
				}
			}
		]

		Controls.MToggleButton {
			id: button

			customCheckImplementation: true
			checked: delRoot.hovered

			radius: height / 2
			color: UI.Theme.primary.main.toString()
			icon.iconData: delRoot.iconData

			anchors {
				left: delRoot.left
			}

			icon {
				iconData: Media.Icons.light.contentCopy
			}

			onClicked: delRoot.activated()
		}

		MouseArea {
			id: delRootMA

			anchors.fill: delRoot
			cursorShape: Qt.PointingHandCursor
			onClicked: delRoot.activated()
		}

		HoverHandler {
			id: hoverHandler
		}

		UI.H6 {
			id: label

			height: delRoot.height
			width: implicitWidth + padding * 2
			text: delRoot.text
			padding: delRoot.height / 6
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignVCenter
			color: button.icon.color
			visible: opacity > 0

			font.pixelSize: mainButton.size == UI.Size.Grade.L ? UI.Size.pixel18 : (mainButton.size == UI.Size.Grade.M ? UI.Size.pixel16 : UI.Size.pixel14)

			anchors {
				right: delRoot.right
				rightMargin: delRoot.radius / 4
			}
		}
	}

	customCheckImplementation: true
	checked: mainButton.mobileMode ? mainButton.mouseArea.pressed : false

	radius: height / 2

	icon {
		iconData: Media.Icons.light.shoppingCart
	}

	mouseArea {
		onPositionChanged: if (mainButton.mobileMode) d.refreshHoverState(mainButton.mouseArea.mouseX + (buttonPopup.width / 2) - mainButton.height / 2, mainButton.mouseArea.mouseY + (buttonPopup.height / 2) - mainButton.height / 2)
		onClicked: if (!mainButton.mobileMode) mainButton.checked = true
	}

	onStartDegreeChanged: d.distributeDelegates()
	onEndDegreeChanged: d.distributeDelegates()
	onSpacingChanged: d.distributeDelegates()
	Component.onCompleted: d.distributeDelegates()

	QtObject {
		id: d

		function distributeDelegates() {
			const centerX = buttonPopup.width / 2;
			const centerY = buttonPopup.height / 2;
			let radiusX = buttonPopup.width / 2 - numberRepeater.maxDelWidth / 2;
			let radiusY = buttonPopup.height / 2 - mainButton.height / 2;

			if (numberRepeater.count === 0) {
				return;
			}

			const startAngle = (mainButton.startDegree * Math.PI) / 180; // Convert degrees to radians
			const endAngle = (mainButton.endDegree * Math.PI) / 180; // Convert degrees to radians
			const angleStep = (endAngle - startAngle) / (numberRepeater.count - 1);

			for (let i = 0; i < numberRepeater.count; i++) {
				let angle = startAngle + i * angleStep;
				let x = centerX + radiusX * Math.cos(angle) - numberRepeater.maxDelWidth / 2;
				let y = centerY + radiusY * Math.sin(angle) - mainButton.height / 2;

				let item = numberRepeater.itemAt(i);
				if (item) {
					item.x = x
					item.y = y
				}
			}
		}

		function resetElements() {
			for (let i = 0; i < numberRepeater.count; i++) {
				let item = numberRepeater.itemAt(i);
				if (item) {
					if (item instanceof CustomButton) {
						item.checked = false
					}
				}
			}
		}

		function activateElement() {
			for (let i = 0; i < numberRepeater.count; i++) {
				let item = numberRepeater.itemAt(i);
				if (item) {
					if (item instanceof CustomButton && item.checked) {
						item.activated();
					}
				}
			}
		}

		function refreshHoverState(mouseX, mouseY) {
			if (!buttonPopup.opened)
				return;
			for (let i = 0; i < numberRepeater.count; i++) {
				let item = numberRepeater.itemAt(i);
				if (item) {
					let xMin = item.x;
					let xMax = item.x + item.width;
					let yMin = item.y;
					let yMax = item.y + item.height;

					if (item instanceof CustomButton) {
						if (mouseX >= xMin && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax)
							item.checked = true
						else
							item.checked = false
					}
				}
			}
		}
	}

	Controls.Popup {
		id: buttonPopup

		property real horizontalOffset: 0
		property real verticalOffset: 0

		x: -width / 2 + mainButton.height / 2 + horizontalOffset
		y: -height / 2 + mainButton.height / 2 + verticalOffset
		implicitWidth: ((mainButton.width + numberRepeater.maxDelWidth ) * 2) * mainButton.spacing
		implicitHeight: (implicitWidth * 0.66) * mainButton.spacing
		visible: mainButton.mobileMode ? mainButton.mouseArea.pressed : mainButton.checked

		background: Item {}

		enter: Transition {}

		exit: Transition {
			NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 210 }
		}

		onAboutToShow: d.resetElements()
		onAboutToHide: {
			if (mainButton.mobileMode)
				d.activateElement();
			else
				mainButton.checked = false;
		}

		contentItem: Item {
			MouseArea {
				anchors.fill: parent
				onClicked: if (buttonPopup.closePolicy != Popup.NoAutoClose) buttonPopup.close()
			}

			Repeater {
				id: numberRepeater

				property var positions: []
				property real maxDelWidth: 0

				onMaxDelWidthChanged: positionsTimer.restart()
				onCountChanged: d.distributeDelegates()

				delegate: CustomButton {
					id: customButtonRoot

					required property int index
					required property var modelData
					property real naturalExtendedWidth: button.width + label.implicitWidth + label.padding * 2

					height: mainButton.height

					x: numberRepeater.positions[index] ? numberRepeater.positions[index].x : 0
					y: numberRepeater.positions[index] ? numberRepeater.positions[index].y : 0

					button.size: mainButton.size
					alwaysOpen: buttonPopup.visible
					iconData: modelData.icon
					text: modelData.name
					checked: mainButton.mobileMode ? false : pressed
					label.width: numberRepeater.maxDelWidth - height
					extendedWidth: naturalExtendedWidth > numberRepeater.maxDelWidth ? naturalExtendedWidth : numberRepeater.maxDelWidth

					Component.onCompleted: {
						if (naturalExtendedWidth > numberRepeater.maxDelWidth) {
							numberRepeater.maxDelWidth = naturalExtendedWidth
						}
					}
					onActivated: {
						modelData.onClicked()
						if (!mainButton.mobileMode)
							buttonPopup.close()
					}
				}
			}

			Timer {
				id: positionsTimer

				interval: 50
				onTriggered: d.distributeDelegates()
			}
		}
	}
}
