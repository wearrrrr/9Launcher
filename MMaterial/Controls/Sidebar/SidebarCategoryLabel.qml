import QtQuick

import MMaterial.UI as UI

Item {
    id: _root

    property alias text: _label.text

    height: UI.Size.scale * 50

    UI.Overline {
        id: _label

        anchors{
            fill: _root
            bottomMargin: UI.Size.pixel8
            leftMargin: UI.Size.pixel16
        }

        verticalAlignment: Qt.AlignBottom
		color: UI.Theme.text.secondary
        font.pixelSize: UI.Size.pixel11
    }
}
