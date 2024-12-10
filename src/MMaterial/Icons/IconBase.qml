import QtQuick

import MMaterial

Item {
    id: _root

    property IconData iconData

    property real size: Size.pixel20

    property string color: ""
    property bool interactive: false
    property bool hoverable: true
    property bool containsMouse: mouseArea.containsMouse

    signal clicked

    implicitHeight: size
    implicitWidth: size

    states: [
        State {
            when: mouseArea.pressed && _root.interactive
            name: "pressed"
            PropertyChanges { target: _root; scale: 0.8; }
        },
        State {
            when: _root.interactive
            name: "default"
            PropertyChanges { target: _root; scale: 1; }
        }
    ]

    transitions: [
        Transition {
            from: "pressed"
            NumberAnimation { id: _clickedAnimation; target: _root; properties: "scale"; duration: 1150; easing.type: Easing.OutElastic; }
        },
        Transition {
            from: "default"
            NumberAnimation { target: _root; properties: "scale"; duration: 70; }
        }
    ]

    MouseArea {
        id: mouseArea

        anchors.fill: _root

        enabled: visible
        visible: _root.interactive
        hoverEnabled: _root.hoverable
        cursorShape: containsMouse && _root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: if(_root.interactive){ _root.clicked(); }
    }
}
