import QtQuick
import QtQuick.Controls.Material

import MMaterial

Item {
    id: _root

    required property SwipeView indexView

    anchors {
        left: indexView.left
        right: indexView.right
        verticalCenter: indexView.verticalCenter
        margins: Size.pixel16
    }

    height: Size.pixel36

    Rectangle {
        id: _leftArrow

        anchors.left: _root.left

        height: _root.height
        width: height

        enabled: _root.indexView.currentIndex > 0
        color: _leftMouseArea.pressed ? Theme.main.p700 : Theme.main.p800
        radius: 10
        opacity: enabled ? 1 : 0.48

        Icon {
            id: _leftIcon

            anchors {
                centerIn: _leftArrow
                horizontalCenterOffset: -1
            }

            iconData: Icons.light.chevronLeft
            color: Theme.common.white
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

        color: _rightMouseArea.pressed ? Theme.main.p700 : Theme.main.p800
        radius: 10

        enabled: _root.indexView.currentIndex < _root.indexView.count - 1
        opacity: enabled ? 1 : 0.48

        Icon {
            anchors {
                centerIn: _rightArrow
                horizontalCenterOffset: 1
            }
            iconData: Icons.light.chevronRight
            color: Theme.common.white
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
