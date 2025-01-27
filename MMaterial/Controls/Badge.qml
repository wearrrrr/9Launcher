pragma ComponentBehavior: Bound

import QtQuick 

import MMaterial.UI as UI
import MMaterial.Media as Media

Item {
    id: _root

    property alias icon: _icon
	property UI.PaletteBasic accent: UI.Theme.info
    property int type: Badge.Type.Dot

    property int quantity: 1
    property int maxQuantity: 999

    signal clicked

    enum Type { Dot, Number }

    implicitHeight: _icon.height
    implicitWidth: _icon.width

    states: [
        State{
            name: "dot"
            when: _root.type == Badge.Type.Dot
            PropertyChanges{
                target: _rootLoader
                sourceComponent: _iconDot
                anchors{
                    bottomMargin: -_icon.height * 0.05
                    leftMargin: -_icon.width * 0.05
                }
            }
        },
        State{
            name: "number"
            when: _root.type == Badge.Type.Number
            PropertyChanges{
                target: _rootLoader
                sourceComponent: _iconBadge
                anchors{
                    bottomMargin: -_icon.height * 0.47
                    leftMargin: -_icon.width * 0.5
                }
            }
        }
    ]

	Media.Icon {
        id: _icon

		iconData: Media.Icons.light.mail
        size: UI.Size.pixel32
		color: UI.Theme.text.primary.toString()
        interactive: true

        onClicked: _root.clicked()
    }
    Loader {
        id: _rootLoader

        anchors {
            bottom: _icon.top
            left: _icon.right
        }

        asynchronous: true
        active: _root.quantity > 0
    }

    Component {
        id: _iconBadge

        BadgeNumber{
            quantity: _root.quantity
            maxQuantity: _root.maxQuantity
            pixelSize: _icon.height * 0.6
            accent: _root.accent
        }
    }

    Component {
        id: _iconDot

        BadgeDot{
            pixelSize: _icon.height * 0.42
            accent: _root.accent
        }
    }
}
