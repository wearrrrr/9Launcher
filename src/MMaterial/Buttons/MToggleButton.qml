import QtQuick 
import QtQuick.Layouts

import "../Settings"
import "../Icons"
import "../Colors"

Rectangle {
    id: _root

    property bool checked: false
    property alias mouseArea: mouseArea
    property var accent: Theme.primary //Needs to be PaletteBasic type
    property bool customCheckImplementation: false

    property int size: Size.Grade.L

    property alias icon: _icon

    signal clicked

    radius: 8
    opacity: mouseArea.pressed ? 0.7 : 1 //TODO replace with ripple effect when OpacityMask is fixed in Qt6
    border.width: Size.pixel1

    state: ""
    states: [
        State{
            when: !_root.enabled
            name: "Disabled"
            PropertyChanges{ target: _root; opacity: 1; border.color: Theme.action.disabledBackground; color: Theme.action.selected }
            PropertyChanges{ target: _icon; color: Theme.action.disabled; }
        },
        State{
            when: _root.checked
            name: "Checked"
            PropertyChanges{ target: _root; opacity: 1; border.color: _root.accent.main; color: _root.accent.transparent.p8 }
            PropertyChanges{ target: _icon; color: _root.accent.main; }
        },
        State{
            when: !_root.checked
            name: "Unchecked"
            PropertyChanges{ target: _root; opacity: 1; border.color: Theme.main.transparent.p24; color: "transparent" }
            PropertyChanges{ target: _icon; color: Theme.action.active; }
        }
    ]

    Icon {
        id: _icon

        anchors.centerIn: _root

        iconData: Icons.heavy.logo
        visible: iconData.path != ""
        size: _root.height * 0.7
    }

    //Non-Visual elements
    MouseArea {
        id: mouseArea

        anchors.fill: _root

        hoverEnabled: true
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: !_root.isLoading

        onClicked: {
            _root.clicked();
            if(!_root.customCheckImplementation)
                _root.checked = !_root.checked;
        }
    }

    Item {
        id: _sizeStates

        state: "L"
        states: [
            State{
                when: _root.size == Size.Grade.L
                name: "L"
                PropertyChanges{ target: _root; implicitHeight: 56 * Size.scale; implicitWidth: implicitHeight }
                PropertyChanges{ target: _icon; size: Size.pixel24 }
            },
            State{
                when: _root.size == Size.Grade.M
                name: "M"
                PropertyChanges{ target: _root; implicitHeight: 48 * Size.scale; implicitWidth: implicitHeight }
                PropertyChanges{ target: _icon; size: Size.pixel24 }
            },
            State{
                when: _root.size == Size.Grade.S
                name: "S"
                PropertyChanges{ target: _root; implicitHeight: 36 * Size.scale; implicitWidth: implicitHeight }
                PropertyChanges{ target: _icon; size: Size.pixel20 }
            },
            State{
                when: true
                name: "Custom"
            }
        ]
    }
}
