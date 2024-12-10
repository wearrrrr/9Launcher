import QtQuick 

import MMaterial

Rectangle {
    id: _root

    property real verticalPadding: pixelSize/2
    property real horizontalPadding: pixelSize
    property var accent: Theme.error //Needs to be PaletteBasic type
    property int quantity: 1
    property int maxQuantity: 999
    property int pixelSize: Size.pixel24

    height: number.implicitHeight + verticalPadding
    width: Math.max(number.implicitWidth + horizontalPadding, height)

    radius: 100
    color: _root.accent.main

    H4 {
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
