import QtQuick 
import QtQuick.Layouts

import MMaterial as MMaterial

Rectangle {
    id: root

    readonly property bool isEmpty: image.source.toString() === ""

    property alias source: image.source
    property real size: MMaterial.Size.pixel48

    property string title: "A"
    property MMaterial.PaletteBasic accent: MMaterial.Theme.primary

    color: enabled ? accent.main : MMaterial.Theme.action.disabled
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

    MMaterial.Subtitle2 {
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

    MMaterial.MaskedImage {
        id: image

        anchors.fill: root
        visible: opacity
        radius: root.radius
    }
}
