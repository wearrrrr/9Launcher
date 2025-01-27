import QtQuick

import MMaterial.UI as UI

Rectangle {
    id: root

    readonly property bool isEmpty: image.source.toString() === ""

    property alias source: image.source
    property real size: UI.Size.pixel48

    property string title: "A"
    property UI.PaletteBasic accent: UI.Theme.primary

    color: enabled ? accent.main : UI.Theme.action.disabled
    radius: height / 2

    implicitHeight: root.size
    implicitWidth: root.size

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

        anchors.fill: root
        visible: opacity
        radius: root.radius
    }
}
