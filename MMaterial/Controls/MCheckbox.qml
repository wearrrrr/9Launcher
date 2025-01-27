import QtQuick

import MMaterial.UI as UI
import MMaterial.Media as Media

Checkable {
    id: _root

	property UI.PaletteBasic accent: UI.Theme.primary

    implicitHeight: UI.Size.pixel24
    implicitWidth: UI.Size.pixel24

    state: "unchecked"
    states: [
        State {
            name: "checked"
            when: _root.checked
            PropertyChanges { target: _background; color: _root.enabled ? _root.accent.main : UI.Theme.action.disabled; border.width: 0; }
        },
        State {
            name: "unchecked"
            when: !_root.checked
            PropertyChanges { target: _background; color: "transparent"; border { width: UI.Size.pixel1*2; color: _root.enabled ? UI.Theme.action.active : UI.Theme.action.disabled } }
        }
    ]

    Rectangle {
        id: _background

        anchors.fill: _root

		radius: UI.Size.pixel6
    }

    Media.Icon {
        id: _icon

        anchors.centerIn: _root

        size: _root.height * 0.8
        iconData: Media.Icons.light.check
		color: UI.Theme.background.main.toString();
        visible: _root.checked
    }

    Rectangle {
        id: _highlight

        anchors.centerIn: _root

        height: _root.height * 1.9
        width: height

        radius: height
        visible: _root.mouseArea.containsMouse
        color: _root.accent.transparent.p8
    }

    Item {
        id: _substates

        state: "default"
        states: [
            State {
                when: _root.mouseArea.pressed
                name: "pressed"
                PropertyChanges { target: _root; scale: 0.85; }
                PropertyChanges { target: _highlight; color: _root.accent.transparent.p24; }
            },
            State {
                when: true
                name: "default"
                PropertyChanges { target: _root; scale: 1; }
                PropertyChanges { target: _highlight; color: _root.accent.transparent.p8; }
            }
        ]
        transitions: [
            Transition {
                from: "pressed"
                NumberAnimation { target: _root; properties: "scale"; duration: 1150; easing.type: Easing.OutElastic; }
                ColorAnimation { target: _highlight; duration: 300; easing.type: Easing.InOutQuad }
            },
            Transition {
                from: "default"
                NumberAnimation { target: _root; properties: "scale"; duration: 70; }
                ColorAnimation { target: _highlight; duration: 300; easing.type: Easing.InOutQuad }
            }
        ]
    }
}
