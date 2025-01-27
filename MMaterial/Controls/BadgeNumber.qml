import QtQuick 

import MMaterial.UI as UI

Rectangle {
    id: _root

    property real verticalPadding: pixelSize/2
    property real horizontalPadding: pixelSize
	property UI.PaletteBasic accent: UI.Theme.error
    property int quantity: 1
    property int maxQuantity: 999
    property int pixelSize: UI.Size.pixel24

    height: number.implicitHeight + verticalPadding
    width: Math.max(number.implicitWidth + horizontalPadding, height)

    radius: 100
    color: _root.accent.main

	UI.H4 {
        id: number

        anchors.centerIn: _root

        text: _root.quantity > _root.maxQuantity ? _root.maxQuantity + "+" : _root.quantity
        color: _root.accent.contrastText
        font.pixelSize: _root.pixelSize
        verticalAlignment: Qt.AlignVCenter
        font.bold: true
        lineHeight: 1
    }
}
