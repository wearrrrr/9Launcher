import QtQuick 

import MMaterial

Rectangle {
    property var accent: Theme.error //Needs to be PaletteBasic type
    property int pixelSize: Size.pixel24

    radius: 100
    height: pixelSize
    width: pixelSize
    color: accent.main
}
