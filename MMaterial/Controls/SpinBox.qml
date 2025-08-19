import QtQuick
import MMaterial.UI as UI

import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.SpinBox {
	id: control

	implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
							contentItem.implicitWidth + leftPadding + rightPadding)
	implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
							 implicitContentHeight + topPadding + bottomPadding,
							 up.implicitIndicatorHeight, down.implicitIndicatorHeight)

	spacing: UI.Size.pixel6
	topPadding: UI.Size.pixel4
	bottomPadding: UI.Size.pixel4
	leftPadding: control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0)
	rightPadding: control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0)

	font {
		family: UI.Font.normalFamilyFamily
		variableAxes: { "wght": 600 }
		bold: true
		pixelSize: UI.Size.pixel14
	}

	validator: IntValidator {
		locale: control.locale.name
		bottom: Math.min(control.from, control.to)
		top: Math.max(control.from, control.to)
	}

	contentItem: TextInput {
		id: textInput

		text: control.displayText

		font: control.font
		color: enabled ? UI.Theme.text.primary : UI.Theme.action.disabled
		selectionColor: UI.Theme.primary.main
		selectedTextColor: UI.Theme.text.primary
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter

		cursorDelegate: CursorDelegate { }

		readOnly: !control.editable
		validator: control.validator
		inputMethodHints: control.inputMethodHints
		clip: width < implicitWidth

		Behavior on text {
			SequentialAnimation {
				NumberAnimation { target: textInput; property: "scale"; to: 0.8; duration: 70 }
				NumberAnimation { target: textInput; property: "scale"; to: 1; duration: 120; easing.type: Easing.OutQuad }
			}
		}
	}

	up.indicator: Item {
		x: control.mirrored ? 0 : control.width - width
		implicitWidth: UI.Size.pixel26
		implicitHeight: UI.Size.pixel26
		height: control.height
		width: height

		Rectangle {
			x: (parent.width - width) / 2
			y: (parent.height - height) / 2
			width: Math.min(parent.width / 2.5, parent.height / 2.5)
			height: 2
			radius: UI.Size.pixel8
			color: enabled ? UI.Theme.action.active : UI.Theme.action.disabledBackground
		}
		Rectangle {
			x: (parent.width - width) / 2
			y: (parent.height - height) / 2
			width: 2
			radius: UI.Size.pixel8
			height: Math.min(parent.width / 2.5, parent.height / 2.5)
			color: enabled ? UI.Theme.action.active : UI.Theme.action.disabledBackground
		}
	}

	down.indicator: Item {
		x: control.mirrored ? control.width - width : 0
		implicitWidth: UI.Size.pixel26
		implicitHeight: UI.Size.pixel26
		height: control.height
		width: height

		Rectangle {
			x: (parent.width - width) / 2
			y: (parent.height - height) / 2
			width: parent.width / 3
			height: 2
			radius: UI.Size.pixel8
			color: enabled ? UI.Theme.action.active : UI.Theme.action.disabledBackground
		}
	}

	background: Rectangle {
		implicitWidth: 88 * UI.Size.scale
		implicitHeight: UI.Size.pixel34
		color: UI.Theme.background.paper
		radius: UI.Size.pixel8

		border {
			width: 1
			color: control.focus ? UI.Theme.action.focus : UI.Theme.action.selected
		}
	}
}
