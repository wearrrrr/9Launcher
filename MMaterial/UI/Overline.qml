import QtQuick

import MMaterial.UI as UI

UI.BaseText {
    lineHeight: 1.5
    wrapMode: Text.WordWrap

    font {
		// family: UI.PublicSans.bold
        pixelSize: UI.Size.pixel12
        capitalization: Font.AllUppercase
        bold: true
    }
}
