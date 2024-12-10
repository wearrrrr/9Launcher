import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial

ListView {
    id: _root

    required property SwipeView indexView

    property int numberOfPages: indexView.count

    implicitWidth: childrenRect.width
    implicitHeight: Size.pixel24

    model: numberOfPages
    currentIndex: indexView.currentIndex

    clip: true
    interactive: false
    spacing: 0
    orientation: ListView.Horizontal

    onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Center);

    delegate: Item {
        id: _delegateItem

        height: _root.height
        width: height

        Rectangle {
            id: _dot

            property bool checked: _root.currentIndex === index

            anchors.centerIn: _delegateItem

            height: _root.height / 3
            width: height

            radius: 100
            color: Theme.primary.main

            states: [
                State {
                    name: "checked"
                    when: _dot.checked

                    PropertyChanges {
                        target: _dot
                        opacity: 1
                        width: height * 2.2
                    }
                },
                State {
                    when: true
                    name: "unchecked"

                    PropertyChanges {
                        target: _dot
                        opacity: 0.32
                        width: height
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    NumberAnimation {
                        properties: "width"
                        duration: 1300
                        easing.type: Easing.OutElastic
                    }
                    NumberAnimation {
                        properties: "opacity"
                        duration: 300
                    }
                }
            ]
        }

        MouseArea {
            anchors.fill: _delegateItem

            cursorShape: Qt.PointingHandCursor

            onClicked: _root.indexView.currentIndex = index;
        }
    }
}
