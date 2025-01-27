import QtQuick
import QtQuick.Controls.Material

import MMaterial.UI as UI
import MMaterial.Media as Media

Rectangle {
    id: _root

    required property SwipeView indexView

    property int numberOfPages: indexView.count

    implicitWidth: height * 3 - UI.Size.pixel4
    implicitHeight: UI.Size.pixel32

    anchors.bottom: parent.bottom

    radius: 8
	color: UI.Theme.main.p800

    Item {
        id: _leftArrow

        anchors.left: _root.left

        height: _root.height
        width: height

		Media.Icon {
            anchors {
                centerIn: _leftArrow
                horizontalCenterOffset: -1
            }

            iconData: Media.Icons.light.chevronLeft
			color: UI.Theme.common.white.toString()
            size: _leftArrow.height * 0.5
            interactive: true
            enabled: _root.indexView.currentIndex > 0
            opacity: enabled ? 1 : 0.48

            onClicked: _root.indexView.decrementCurrentIndex();
        }
    }

	UI.Subtitle2 {
        anchors{
            left: _leftArrow.right
            right: _rightArrow.left
        }

        height: _root.height

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        text: _root.indexView.currentIndex + 1 + "/" + _root.numberOfPages
		color: UI.Theme.common.white

        font {
            bold: true
            pixelSize: _root.height * 0.45
        }
    }

    Item {
        id: _rightArrow

        anchors.right: _root.right

        height: _root.height
        width: height

		Media.Icon {
            anchors {
                centerIn: _rightArrow
                horizontalCenterOffset: 1
            }

            iconData: Media.Icons.light.chevronRight
			color: UI.Theme.common.white.toString()
            size: _rightArrow.height * 0.5
            interactive: true
            enabled: _root.indexView.currentIndex < _root.indexView.count - 1
            opacity: enabled ? 1 : 0.48

            onClicked: _root.indexView.incrementCurrentIndex();
        }
    }
}
