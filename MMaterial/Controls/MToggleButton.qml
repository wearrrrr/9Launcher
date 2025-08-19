import QtQuick 

import MMaterial.UI as UI
import MMaterial.Media as Media

Rectangle {
    id: _root

    property bool checked: false
    property alias mouseArea: mouseArea
	property UI.PaletteBasic accent: UI.Theme.primary
    property bool customCheckImplementation: false

	property int size: UI.Size.Grade.L

    property alias icon: _icon

    signal clicked

	radius: UI.Size.pixel8
    opacity: mouseArea.pressed ? 0.7 : 1 //TODO replace with ripple effect when OpacityMask is fixed in Qt6
	border.width: UI.Size.pixel1

    state: ""
    states: [
        State{
            when: !_root.enabled
            name: "Disabled"
			PropertyChanges{ target: _root; opacity: 1; border.color: UI.Theme.action.disabledBackground; color: UI.Theme.action.selected }
			PropertyChanges{ target: _icon; color: UI.Theme.action.disabled; }
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
            PropertyChanges{ target: _root; opacity: 1; border.color: UI.Theme.main.transparent.p24; color: "transparent" }
			PropertyChanges{ target: _icon; color: UI.Theme.action.active; }
        }
    ]

	Media.Icon {
        id: _icon

        anchors.centerIn: _root

		iconData: Media.Icons.heavy.logo
		visible: iconData && iconData.path !== ""
        size: _root.height * 0.7

		states: [
			State {
				when: mouseArea.pressed
				name: "pressed"
				PropertyChanges { target: _icon; scale: 0.8; }
			},
			State {
				when: true
				name: "default"
				PropertyChanges { target: _icon; scale: 1; }
			}
		]

		transitions: [
			Transition {
				from: "pressed"
				NumberAnimation { target: _icon; properties: "scale"; duration: 1150; easing.type: Easing.OutElastic; }
			},
			Transition {
				from: "default"
				NumberAnimation { target: _icon; properties: "scale"; duration: 70; }
			}
		]
    }

    //Non-Visual elements
    MouseArea {
        id: mouseArea

        anchors.fill: _root

        hoverEnabled: true
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

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
				when: _root.size == UI.Size.Grade.L
                name: "L"
				PropertyChanges{ target: _root; implicitHeight: 56 * UI.Size.scale; implicitWidth: implicitHeight }
				PropertyChanges{ target: _icon; size: UI.Size.pixel24 }
            },
            State{
				when: _root.size == UI.Size.Grade.M
                name: "M"
				PropertyChanges{ target: _root; implicitHeight: 48 * UI.Size.scale; implicitWidth: implicitHeight }
				PropertyChanges{ target: _icon; size: UI.Size.pixel24 }
            },
            State{
				when: _root.size == UI.Size.Grade.S
                name: "S"
				PropertyChanges{ target: _root; implicitHeight: 36 * UI.Size.scale; implicitWidth: implicitHeight }
				PropertyChanges{ target: _icon; size: UI.Size.pixel20 }
            },
            State{
                when: true
                name: "Custom"
            }
        ]
    }
}
