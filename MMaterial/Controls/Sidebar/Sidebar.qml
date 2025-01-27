pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import MMaterial.UI as UI

Rectangle {
    id: root

    required property Item mainView

    default property list<SidebarItem> sidebarItems

    property alias loader: _loader

    property string name
    property string role

    property int currentIndex: -1

    implicitHeight: parent.height

	color: UI.Theme.background.main

    anchors {
        left: parent.left
        bottom: parent.bottom
    }

    layer{
        enabled: true
        effect: MultiEffect{
            shadowEnabled: true
            shadowBlur: 3
            shadowHorizontalOffset: 2
            shadowVerticalOffset: 5
        }
    }

    states: [
        State {
            name: "extended"
            when: UI.Size.format == UI.Size.Format.Extended

            PropertyChanges {
                root {
                    width: 280 * UI.Size.scale
                    height: root.parent.height

                    mainView.anchors {
                        margins: UI.Size.pixel32
                        left: root.right
                        top: root.parent.top
                        bottom: root.parent.bottom
                        right: root.parent.right
                    }
                }

            }
        },
        State {
            name: "compact"
            when: UI.Size.format == UI.Size.Format.Compact

            PropertyChanges {
                root {
                    width: 86 * UI.Size.scale
                    height: root.parent.height

                    mainView.anchors {
                        margins: UI.Size.pixel32
                        left: root.right
                        top: root.parent.top
                        bottom: root.parent.bottom
                        right: root.parent.right
                    }
                }

            }
        },
        State {
            name: "mobile"
            when: true

            PropertyChanges {
                root {
                    width: root.parent.width
                    height: UI.Size.pixel64

                    mainView.anchors {
                        margins: UI.Size.pixel32
                        left: root.parent.left
                        top: root.parent.top
                        bottom: root.top
                        right: root.parent.right
                    }
                }
            }
        }
    ]

    transitions: [
        Transition {
            from: "extended"
            to: "compact"

            SequentialAnimation {
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 0; to: 0; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; properties: "width"; duration: 220; easing.type: Easing.InOutQuad }
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 220; to: 1; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "compact"
            to: "extended"

            SequentialAnimation {
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 0; to: 0; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; properties: "width"; duration: 220; easing.type: Easing.InOutQuad }
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 220; to: 1; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "*"
            to: "mobile"

            SequentialAnimation {
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 0; to: 0; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; properties: "width"; duration: 320; to: 0; easing.type: Easing.InOutQuad }
                PropertyAction { target: root.mainView.anchors; property: "left"; }
                NumberAnimation { target: root; properties: "height"; duration: 0; to: 0; }
                PropertyAction { target: root.mainView.anchors; property: "bottom"; }
                NumberAnimation { target: root; properties: "width"; duration: 0;  }
                NumberAnimation { target: root; properties: "height"; duration: 220; easing.type: Easing.InOutQuad }
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 220; to: 1; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "mobile"
            to: "*"

            SequentialAnimation {
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 0; to: 0; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; properties: "height"; duration: 220; to: 0; easing.type: Easing.InOutQuad; }
                PropertyAction { target: root.mainView.anchors; property: "bottom"; }
                NumberAnimation { target: root; properties: "width"; duration: 0; to: 0 }
                PropertyAction { target: root.mainView.anchors; property: "left"; }
                NumberAnimation { target: root; properties: "height"; duration: 0; }
                NumberAnimation { target: root; properties: "width"; duration: 320; easing.type: Easing.InOutQuad }
                NumberAnimation { targets: _loader; properties: "opacity"; duration: 220; to: 1; easing.type: Easing.InOutQuad }
            }
        }
    ]

    Loader {
        id: _loader

        anchors.fill: root
		sourceComponent: d.getSources(UI.Size.format)
        visible: _loader.status == Loader.Ready
        asynchronous: true
    }

    Component {
        id: _extendedSidebar

        ExtendedSidebar{
            title.text: root.name
            subtitle.text: root.role

            model: root.sidebarItems
            sidebarData: d.sidebarData
        }
    }

    Component {
        id: _compactSidebar

        CompactSidebar{
            model: root.sidebarItems
            sidebarData: d.sidebarData
        }
    }

    Component {
        id: _mobileSidebar

        MobileSidebar{
            model: root.sidebarItems
            sidebarData: d.sidebarData
        }
    }

    QtObject {
        id: d

        property SidebarData sidebarData: SidebarData {}

        function getSources(format) {
            if (format == UI.Size.Format.Extended )
                return _extendedSidebar
            else if (format == UI.Size.Format.Mobile)
                return _mobileSidebar
            else
                return _compactSidebar
        }
    }
}
