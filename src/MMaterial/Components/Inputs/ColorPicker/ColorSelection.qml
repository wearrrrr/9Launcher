import QtQuick

import MMaterial as MMaterial

GridView {
    id: root

    required property color parentBackgroundColor

    signal clicked(color color, int index, var mouseEvent)
    signal doubleClicked(color color)

    implicitHeight: root.count > 8 ? cellHeight * 2 : cellHeight
    interactive: false

    cellWidth: root.width / 8
    cellHeight: cellWidth

    add: Transition {
        NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 250; easing.type: Easing.OutQuart }
        NumberAnimation { properties: "scale"; from: 0; to: 1; duration: 250; easing.type: Easing.OutQuart }
    }
    remove: Transition {
        NumberAnimation { properties: "opacity"; from: 1; to: 0; duration: 250; easing.type: Easing.OutQuart }
        NumberAnimation { properties: "scale"; from: 1; to: 0; duration: 250; easing.type: Easing.OutQuart }
    }
    displaced: Transition {
        NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutQuart }
    }

    delegate: Item {
        id: delegateRoot

        height: root.cellHeight
        width: root.cellWidth

        Rectangle {
            id: circle

            anchors.centerIn: delegateRoot

            height: root.cellHeight - MMaterial.Size.pixel4
            width: root.cellWidth - MMaterial.Size.pixel4
            radius: height / 2
            color: model.selectionColor
            scale: mouseArea.containsMouse ? 1.1 : 1
            opacity: mouseArea.pressed ? 0.6 : 1

            border {
                color: MMaterial.Theme.text.primary
                width: utils.isSimilar(circle.color, root.parentBackgroundColor) || circle.color.a < 0.3 ? MMaterial.Size.pixel1 : 0
            }

            Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutQuart } }

            MouseArea {
                id: mouseArea
                anchors.fill: parent

                acceptedButtons: Qt.LeftButton | Qt.RightButton
                hoverEnabled: true

                onDoubleClicked: root.doubleClicked(circle.color)

                onClicked: (_mouse) => {
                               root.currentIndex = index
                               root.clicked(circle.color, index, _mouse)
                           }
            }
        }
    }

    MMaterial.ColorUtils { id: utils }
}
