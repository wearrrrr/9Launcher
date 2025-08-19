pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Templates as T

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Controls.Inputs as Inputs
import MMaterial.Media as Media

T.ComboBox {
	id: root

	property int delegateCount: 5
	property int type: Inputs.TextField.Type.Outlined
	property UI.PaletteBasic accent: UI.Theme.primary
	property Media.IconData iconData: null
	property string placeholderText: qsTr("Placeholder")
	property color placeholderTextColor: UI.Theme.text.primary
	property alias color: _textField.color

	implicitHeight: 48 * UI.Size.scale
	implicitWidth: (UI.Size.format == UI.Size.Format.Extended ? 319 : 200) * UI.Size.scale
	down: _contextMenu.opened
	selectTextByMouse: true

	model: ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5"]

	leftPadding: (root.type === Inputs.TextField.Type.Standard ? 0 : d.horizontalPadding) + (_leftIcon.visible ? _leftIcon.width + UI.Size.pixel8 : 0) + (!root.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
	rightPadding: d.horizontalPadding + (root.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

	font {
		family: UI.Font.normal
		pixelSize: UI.Size.pixel14
	}

	QtObject{
		id: d

		readonly property real horizontalPadding: root.height / 4
	}

	Item {
		id: _mainContainer

		anchors {
			fill: root
			topMargin: root.type === Inputs.TextField.Type.Outlined ? 0 : (root.activeFocus ? UI.Size.pixel16 : 0)
		}

		Media.Icon {
			id: _leftIcon

			anchors {
				left: _mainContainer.left; leftMargin: root.type === Inputs.TextField.Type.Standard ? 0 : d.horizontalPadding;
				verticalCenter: _mainContainer.verticalCenter
			}

			iconData: root.iconData
			color: UI.Theme.text.disabled.toString()
			visible: iconData
			size: !visible ? 0 : bg.height * 0.3
		}
	}

	background: Inputs.InputsBackground {
		id: bg

		rootItem: root
		ignoreDisabledColoring: root.enabled
		showPlaceholder: !root.focus && root.displayText === "" && !root.down && root.placeholderText !== ""
		leftIcon: _leftIcon
		iconContainer: _mainContainer
	}

	contentItem: T.TextField {
		id: _textField

		text: root.editable ? root.editText : root.displayText
		placeholderText: ""
		enabled: root.editable
		autoScroll: root.editable
		readOnly: root.down
		inputMethodHints: root.inputMethodHints
		validator: root.validator
		selectByMouse: root.selectTextByMouse
		verticalAlignment: Text.AlignVCenter

		implicitHeight: 52 * UI.Size.scale
		implicitWidth: (UI.Size.format == UI.Size.Format.Extended ? 319 : 200) * UI.Size.scale

		selectedTextColor: acceptableInput ? root.accent.contrastText : UI.Theme.error.contrastText
		selectionColor: acceptableInput ? root.accent.main : UI.Theme.error.main
		placeholderTextColor: UI.Theme.text.primary.toString() 

		topPadding: root.type === Inputs.TextField.Type.Standard || root.type === Inputs.TextField.Type.Filled ? root.height * 0.3 : 0
	}

	indicator: Media.Icon {
		x: root.mirrored ? root.padding : (root.width - width) - UI.Size.pixel8
		y: root.topPadding + (root.availableHeight - height) / 2
		rotation: root.down ? 180 : 0
		iconData: Media.Icons.light.keyboardArrowDown
		size: UI.Size.pixel22
		color: root.enabled ? UI.Theme.action.active.toString() : UI.Theme.action.disabled.toString()

		Behavior on rotation { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
	}

	delegate: Controls.MenuItem {
		required property int index
		required property var model

		implicitHeight: root.delegateHeight
		horizontalPadding: UI.Size.pixel12
		width: ListView.view.width
		useIcons: false
		highlighted: root.highlightedIndex === index
		hoverEnabled: root.hoverEnabled
		color: highlighted || root.currentIndex === index ? UI.Theme.text.primary : UI.Theme.text.secondary

		text: model[root.textRole]
	}

	popup: Controls.Menu {
		id: _contextMenu

		width: root.width
		height: Math.min(contentItem.implicitHeight + verticalPadding * 2, root.Window.height - topMargin - bottomMargin)
		transformOrigin: Item.Top
		verticalPadding: UI.Size.pixel8

		y: root.height + 1
		closePolicy: Controls.Menu.CloseOnEscape | Controls.Menu.CloseOnReleaseOutsideParent

		onAboutToShow: root.down = true
		onAboutToHide: root.down = false

		background: Rectangle {
			implicitWidth: root.width

			radius: UI.Size.pixel12
			color: UI.Theme.background.main
			border.color: UI.Theme.action.disabledBackground
		}

		contentItem: ListView {
			id: _listView

			implicitHeight: count > root.delegateCount ? root.delegateCount * root.delegateHeight : contentHeight

			model: root.delegateModel

			clip: true
			currentIndex: root.highlightedIndex

			ScrollIndicator.vertical: T.ScrollIndicator {}
		}
	}
}
