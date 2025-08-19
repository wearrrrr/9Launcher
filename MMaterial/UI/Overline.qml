import QtQuick

import MMaterial.UI as UI

UI.BaseText {
	lineHeight: 1
	wrapMode: Text.WordWrap

	font {
        variableAxes: { "wght": 700 }
		pixelSize: UI.Size.pixel12
		capitalization: Font.AllUppercase
    }
}
