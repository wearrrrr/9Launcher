import QtQuick
import QtQuick.Layouts

import MMaterial

Item {
    id: _root

    property alias text: _label.text

    height: Size.scale * 50

    Overline {
        id: _label

        anchors{
            fill: _root
            bottomMargin: Size.pixel8
            leftMargin: Size.pixel16
        }

        verticalAlignment: Qt.AlignBottom
        color: Theme.text.secondary
        font.pixelSize: Size.pixel11
    }
}
