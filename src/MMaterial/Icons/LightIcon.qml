import QtQuick

IconBase {
    id: _root

    Text {
        anchors {
            centerIn: _root
        }

        text: _root.iconData.path
        color: _root.color

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        font {
            pixelSize: _root.size
            family: IconFont.name
        }
    }
}


