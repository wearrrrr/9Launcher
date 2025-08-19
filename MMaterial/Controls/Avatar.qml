import QtQuick

import MMaterial.UI as UI
import MMaterial.Controls as Controls

Rectangle {
    id: root

    readonly property bool isEmpty: image.source.toString() === ""

    property alias source: image.source
    property alias titleLabel: title
    property real size: UI.Size.pixel48
    property bool isLoading: false

    property string title: "A"
    property UI.PaletteBasic accent: UI.Theme.primary

    color: enabled ? accent.main : UI.Theme.action.disabled
    radius: height / 2

    implicitHeight: root.size
    implicitWidth: root.size

	antialiasing: true
	border.width: -1

    states: [
        State {
            name: "image"
            when: !root.isEmpty

            PropertyChanges { target: image; opacity: 1 }
            PropertyChanges { target: title; opacity: 0 }
        },
        State {
            name: "noImage"
            when: true

            PropertyChanges { target: image; opacity: 0 }
            PropertyChanges { target: title; opacity: 1 }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { properties: "opacity"; duration: 450 }
        }
    ]

    SequentialAnimation {
        id: transitionAnimation
    }

	UI.Subtitle2 {
        id: title

        anchors.centerIn: root

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        color: root.accent.contrastText
        text: root.title.length >= 1 ?root.title[0] : ""
        visible: opacity

        font {
            pixelSize: root.height * 0.4
            capitalization: Font.AllUppercase
        }
    }

	MaskedImage {
        id: image

        visible: opacity
        radius: root.radius

        anchors {
            fill: root
            margins: root.border.width
        }
    }

    Rectangle {
        id: overlay

        anchors.fill: root
        color: Qt.rgba(0, 0, 0, 0.87)
        radius: root.radius
        opacity: root.isLoading
        visible: opacity > 0

        Behavior on opacity { NumberAnimation { duration: 350 } }

        Controls.BusyIndicator{
            id: _busyIndicator

            anchors.centerIn: overlay
            show: root.isLoading
            size: Math.min(overlay.height, overlay.width) * 0.8
        }
    }
}
