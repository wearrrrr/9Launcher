import QtQuick
import QtQuick.Templates as T

import MMaterial.UI as UI

T.Slider {
    id: control

	property UI.PaletteBasic accent: UI.Theme.primary

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6


    handle: Item {
        id: _handle

        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))

        implicitWidth: 24
        implicitHeight: 24

        MToolTip {
            visible: control.hovered
            text: control.value.toFixed(1)
            delay: 200
        }

        Rectangle {
            id: _highlight

            anchors.centerIn: _handle

            height: _handle.height
            width: height

            radius: height / 2
            color: control.accent.transparent.p8

            states: [
                State {
                    when: control.pressed
                    name: "pressed"
                    PropertyChanges {
                        target: _highlight
                        scale: 1.9
                    }
                },
                State {
                    when: true
                    name: "released"
                    PropertyChanges {
                        target: _highlight
                        scale: 1
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "released"
                    NumberAnimation {
                        target: _highlight
                        property: "scale"
                        duration: 150
                        easing.type: Easing.OutQuad
                    }
                },
                Transition {
                    from: "pressed"
                    NumberAnimation {
                        target: _highlight
                        property: "scale"
                        duration: 1200
                        easing.type: Easing.OutElastic
                    }
                }
            ]
        }

        Rectangle {
            implicitHeight: _handle.height
            implicitWidth: height

            radius: width / 2
            color: control.accent.main
        }
    }

    background: Rectangle {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)

        implicitWidth: control.horizontal ? 200 : 6
        implicitHeight: control.horizontal ? 6 : 200

        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight

        radius: 3
        color: control.accent.transparent.p48
        scale: control.horizontal && control.mirrored ? -1 : 1

        Rectangle {
            y: control.horizontal ? 0 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : 6
            height: control.horizontal ? 6 : control.position * parent.height

            radius: 3
            color: control.accent.main
        }
    }
}
