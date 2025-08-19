import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import MMaterial.UI as UI
import MMaterial.Controls.Inputs as Inputs

T.TextArea {
	id: control

	property int type: Inputs.TextField.Outlined

	implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
							implicitBackgroundWidth + leftInset + rightInset,
							leftPadding + rightPadding)
	implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
							 implicitBackgroundHeight + topInset + bottomInset,
							 topPadding + bottomPadding)

	topPadding: type == Inputs.TextField.Standard || type == Inputs.TextField.Filled ? font.pixelSize + UI.Size.pixel12 : UI.Size.pixel12
	leftPadding: type == Inputs.TextField.Standard ? 0 : UI.Size.pixel12
	rightPadding: leftPadding
	bottomPadding: UI.Size.pixel4

	color: UI.Theme.text.primary
	placeholderTextColor: UI.Theme.text.secondary
	selectionColor: UI.Theme.primary.main
	selectedTextColor: UI.Theme.primary.contrastText

	font {
		family: UI.Font.normal
		pixelSize: UI.Size.pixel14
	}

	background: InputsBackground {
		rootItem: control
		showPlaceholder: !control.text.length && !control.activeFocus
		iconContainer: control
	}
}
