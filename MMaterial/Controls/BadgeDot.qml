import QtQuick 

import MMaterial.UI as UI

Rectangle {
	property UI.PaletteBasic accent: UI.Theme.error
    property int pixelSize: UI.Size.pixel24

	radius: height / 2
    height: pixelSize
    width: pixelSize
    color: accent.main
}
