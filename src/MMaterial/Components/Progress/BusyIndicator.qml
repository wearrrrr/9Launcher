import QtQuick

import MMaterial as MMaterial

Item {
    id: root

    property alias animation: animation
    property bool show: false
    property real size: 150 * MMaterial.Size.scale

    implicitHeight: root.size
    implicitWidth: root.size

    visible: opacity > 0 // Change the "show" property instead of "visible" to animate the component properly

    states: [
        State {
            name: "show"
            when: root.show

            PropertyChanges {
                target: root

                opacity: 1
                scale: 1
            }
        },
        State {
            name: "hide"
            when: !root.show

            PropertyChanges {
                target: root

                opacity: 0
                scale: 1.2
            }
        }
    ]

    transitions: [
        Transition {
            from: "show"
            to: "hide"

            ParallelAnimation {
                MMaterial.EasedAnimation {
                    target: root
                    property: "opacity"
                    duration: 250
                }

                MMaterial.EasedAnimation {
                    target: root
                    property: "scale"
                    duration: 350
                }
            }
        },

        Transition {
            from: "hide"
            to: "show"

            SequentialAnimation {
                PropertyAction {
                    target: root
                    property: "scale"
                    value: 1.2
                }

                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 650
                    easing.type: Easing.InQuart
                }

                MMaterial.EasedAnimation {
                    target: root
                    property: "scale"
                    duration: 350
                }
            }
        }
    ]

    QtObject {
        id: animation

        property real radius: root.height * 0.26
        property real duration: 1900
    }

    Rectangle {
        id: thinRect

        color: "transparent"
        radius: animation.radius * 1.35
        anchors.fill: root
        opacity: 0.1

        border {
            width: MMaterial.Size.pixel8
            color: MMaterial.Theme.primary.light
        }
    }

    Rectangle {
        id: thickRect

        color: "transparent"
        radius: animation.radius
        opacity: 0.2

        anchors {
            fill: root
            margins: root.height * 0.14
        }

        border {
            width: 3 * MMaterial.Size.scale
            color: MMaterial.Theme.primary.light
        }
    }

    MMaterial.Icon {
        id: _logo

        size: root.width * 0.3
        anchors.centerIn: root

        iconData: MMaterial.Icons.heavy.logo
        color: MMaterial.Theme.primary.main
    }

    ParallelAnimation {
        loops: Animation.Infinite
        running: root.visible

        SequentialAnimation {
            ScaleAnimator {
                id: scaleAnimator1
                target: _logo

                from: 1
                to: 0.75
                duration: animation.duration * 0.55
                easing.type: Easing.InOutQuart
            }

            ScaleAnimator {
                id: scaleAnimator2
                target: _logo

                from: 0.75
                to: 1
                duration: animation.duration * 0.35
                easing.type: Easing.InOutQuart
            }
        }

        SequentialAnimation {
            ParallelAnimation {
                ScaleAnimator {
                    target: thinRect

                    from: 1
                    to: 0.6
                    duration: scaleAnimator1.duration
                    easing.type: Easing.InOutQuart
                }
                ScaleAnimator {
                    target: thickRect

                    from: 1
                    to: 1.3
                    duration: scaleAnimator1.duration
                    easing.type: Easing.InOutQuart
                }
                OpacityAnimator {
                    target: _logo

                    from: 1
                    to: 0.45
                    duration: scaleAnimator1.duration
                    easing.type: scaleAnimator1.easing.type
                }
                OpacityAnimator {
                    target: thinRect

                    from: 0.1
                    to: 0.45
                    duration: scaleAnimator1.duration
                    easing.type: scaleAnimator1.easing.type
                }
            }

            ParallelAnimation {
                ScaleAnimator {
                    target: thinRect

                    from: 0.6
                    to: 1
                    duration: scaleAnimator2.duration
                    easing.type: Easing.InOutQuart
                }
                ScaleAnimator {
                    target: thickRect

                    from: 1.3
                    to: 1
                    duration: scaleAnimator2.duration
                    easing.type: Easing.InOutQuart
                }
                OpacityAnimator {
                    target: _logo

                    from: 0.45
                    to: 1
                    duration: scaleAnimator2.duration
                    easing.type: scaleAnimator2.easing.type
                }
                OpacityAnimator {
                    target: thinRect

                    from: 0.45
                    to: 0.1
                    duration: scaleAnimator1.duration
                    easing.type: scaleAnimator1.easing.type
                }
            }
        }

        RotationAnimator {
            target: thickRect

            from: 0
            to: 360
            duration: animation.duration
            easing.type: Easing.InOutQuart
        }

        RotationAnimator {
            target: thinRect

            from: 0
            to: -360
            duration: animation.duration
            easing.type: Easing.InOutQuart
        }
    }
}
