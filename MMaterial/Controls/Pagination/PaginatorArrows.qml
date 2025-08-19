import QtQuick
import QtQuick.Controls.Material

import MMaterial.UI as UI
import MMaterial.Media as Media

Item {
    id: _root

    required property SwipeView indexView

    anchors {
        left: _root.indexView.left
        right: _root.indexView.right
        verticalCenter: _root.indexView.verticalCenter
        margins: UI.Size.pixel16
    }

    height: UI.Size.pixel36

    Rectangle {
        id: _leftArrow

        anchors.left: _root.left

        height: _root.height
        width: height

        enabled: _root.indexView.currentIndex > 0
		color: _leftMouseArea.pressed ? UI.Theme.main.p700 : UI.Theme.main.p800
        radius: 10
        opacity: enabled ? 1 : 0.48

		Media.Icon {
            id: _leftIcon

            anchors {
                centerIn: _leftArrow
                horizontalCenterOffset: -1
            }

            iconData: Media.Icons.light.chevronLeft
			color: UI.Theme.common.white.toString()
            size: _leftArrow.height * 0.5
        }

        MouseArea {
            id: _leftMouseArea

            anchors.fill: _leftArrow

            hoverEnabled: _leftArrow.enabled
            cursorShape: Qt.PointingHandCursor

            onClicked: _root.indexView.decrementCurrentIndex();
        }
    }

    Rectangle {
        id: _rightArrow

        anchors.right: _root.right

        height: _root.height
        width: height

		color: _rightMouseArea.pressed ? UI.Theme.main.p700 : UI.Theme.main.p800
        radius: 10

        enabled: _root.indexView.currentIndex < _root.indexView.count - 1
        opacity: enabled ? 1 : 0.48

		Media.Icon {
            anchors {
                centerIn: _rightArrow
                horizontalCenterOffset: 1
            }
            iconData: Media.Icons.light.chevronRight
			color: UI.Theme.common.white.toString()
            size: _rightArrow.height * 0.5
        }

        MouseArea {
            id: _rightMouseArea

            anchors.fill: _rightArrow

            hoverEnabled: _rightArrow.enabled
            cursorShape: Qt.PointingHandCursor

            onClicked: _root.indexView.incrementCurrentIndex();
        }
    }
}
