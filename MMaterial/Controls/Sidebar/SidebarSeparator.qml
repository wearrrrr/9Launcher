import QtQuick

import MMaterial.UI as UI

Item {
    id: _root

    anchors.horizontalCenter: parent ? parent.horizontalCenter : null

    width: UI.Size.pixel24
    height: UI.Size.pixel10

    Rectangle {
        anchors.centerIn: _root

        width: _root.width
        height: UI.Size.pixel1

        color: UI.Theme.other.divider
    }
}
