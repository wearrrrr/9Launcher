import QtQuick
import "../Colors"

Rectangle {
    id: _root

    property bool containsMouse: _mouseArea.containsMouse
    property alias mouseArea: _mouseArea
    property bool selected: ListView.isCurrentItem

    signal clicked

    opacity: 1
    radius: 8
    color: Theme.background.main

    onClicked: {
        if(typeof index !== "undefined" && ListView.view)
            ListView.view.currentIndex = index;
        else if(typeof ObjectModel.index !== "undefined" && ListView.view)
            ListView.view.currentIndex = ObjectModel.index;
    }

    states: [
        //states based on this _mouseArea.pressed || selected ? Theme.action.selected : _root.containsMouse ? Theme.action.hover : Theme.background.main
        State {
            name: "disabled"
            when: !_root.enabled
            PropertyChanges {
                target: _root
                color: Theme.action.disabled
                opacity: 0.4
            }
        },
        State {
            name: "pressed"
            when: _mouseArea.pressed
            PropertyChanges {
                target: _root
                color: Theme.action.selected
            }
        },
        State {
            name: "hovered"
            when: _root.containsMouse && !_mouseArea.pressed
            PropertyChanges {
                target: _root
                color: Theme.action.hover
            }
        },
        State {
            name: "selected"
            when: _root.selected
            PropertyChanges {
                target: _root
                color: Theme.action.selected
            }
        }
    ]

    MouseArea {
        id: _mouseArea

        anchors.fill: _root

        hoverEnabled: _root.enabled
        cursorShape: Qt.PointingHandCursor

        onClicked: _root.clicked()
    }
}
