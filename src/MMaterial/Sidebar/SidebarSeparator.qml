import QtQuick

import MMaterial

Item {
    id: _root

    anchors.horizontalCenter: parent ? parent.horizontalCenter : null

    width: Size.pixel24
    height: Size.pixel10

    Rectangle {
        anchors.centerIn: _root

        width: _root.width
        height: Size.pixel1

        color: Theme.other.divider
    }
}
