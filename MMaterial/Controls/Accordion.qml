import QtQuick 
import QtQuick.Layouts
import QtQuick.Effects

import MMaterial.UI as UI
import MMaterial.Media as Media

Rectangle {
    id: _root

    property bool isOpen: false
    property real padding: UI.Size.pixel20
    property string title: "Accordion Item"
    property string subtitle: "Donec id justo. Curabitur blandit mollis lacus. Vivamus quis mi. In ut quam vitae odio lacinia tincidunt. In consectetuer turpis ut velit."

    radius: 8
    clip: true
	color: UI.Theme.background.paper

    layer{
        enabled: _root.isOpen
        effect: MultiEffect{
            shadowEnabled: true
            shadowBlur: 3
            shadowHorizontalOffset: 5
            shadowVerticalOffset: 5

        }
    }
    state: "closed"
    states: [
        State {
            name: "open"
            when: _root.isOpen
            PropertyChanges {
                target: _arrow
                rotation: 180
            }
            PropertyChanges {
                target: _root
                height: _title.contentHeight + _root.padding * 3 + _subtitle.contentHeight
            }
            PropertyChanges {
                target: _subtitle
                opacity: 1
            }

        },
        State {
            name: "closed"
            when: !_root.isOpen
            PropertyChanges {
                target: _arrow
                rotation: 0
            }
            PropertyChanges {
                target: _root
                height: _title.contentHeight + _root.padding * 2
            }
            PropertyChanges {
                target: _subtitle
                opacity: 0.0
            }
        }
    ]

    transitions: [
        Transition {
            from: "closed"
            to: "open"

            ParallelAnimation{
                NumberAnimation {
                    properties: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                    easing.type: Easing.InExpo
                }
            }
        },
        Transition {
            from: "open"
            to: "closed"

            ParallelAnimation{
                NumberAnimation {
                    properties: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                    easing.type: Easing.OutExpo
                }
            }
        }
    ]

    RowLayout {
        id: _titleLayout

        anchors{
            top: _root.top
            left: _root.left
            right: _root.right
            margins: _root.padding
        }

		UI.Subtitle1 {
            id: _title

            Layout.fillWidth: true

            verticalAlignment: Qt.AlignVCenter
            text: _root.title
			color: UI.Theme.text.primary
            maximumLineCount: 1
        }

		Media.Icon {
            id: _arrow

            size: UI.Size.pixel20
			iconData: Media.Icons.light.keyboardArrowDown
            interactive: true
			color: UI.Theme.text.primary.toString()

            onClicked: _root.isOpen = !_root.isOpen
        }
    }

	UI.B1{
        id: _subtitle

        anchors{
            top: _titleLayout.bottom; topMargin: _root.padding / 2
            bottom: _root.bottom
            left: _root.left
            right: _root.right
            margins: _root.padding
        }

        verticalAlignment: Qt.AlignBottom
		color: UI.Theme.text.primary
        text: _root.subtitle
        visible: opacity > 0
    }

    MouseArea {
        anchors.fill: _root

        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        hoverEnabled: true

        onClicked: _root.isOpen = !_root.isOpen
    }
}
