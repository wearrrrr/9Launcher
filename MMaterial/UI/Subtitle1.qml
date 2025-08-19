import QtQuick

import MMaterial.UI as UI

UI.BaseText {
	wrapMode: Text.WordWrap
	lineHeight: 1

	font {
        variableAxes: { "wght": 600 }
		pixelSize: UI.Size.pixel16
	}
}
