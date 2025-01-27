import QtQuick

import MMaterial.UI as UI
import MMaterial.Media as Media

Media.IconBase {
    id: _root

    Text {
        anchors {
            centerIn: _root
        }

        text: _root.iconData.path
		color: _root.color == "" ? UI.Theme.text.primary : _root.color

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        font {
            pixelSize: _root.size
			family: Media.IconFont.name
        }
    }
}


