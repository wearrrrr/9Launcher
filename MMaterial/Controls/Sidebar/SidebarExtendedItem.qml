pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Item {
    id: _root

	required property int index

    property SidebarData sidebarData

    property string category

    property alias icon: _icon
    property alias text: _title.text
    property alias model: _listView.model
    property alias list: _listView
    property QtObject chip: null

    property bool checked: index == _root.sidebarData.currentIndex
    property bool isOpen: false

    property real openingSpeed: 150

    function selectItem(subindex) : void {
		if (ListView.view) {
            if(typeof index !== "undefined")
                ListView.view.currentIndex = index;
            else if(typeof ObjectModel.index !== "undefined")
                ListView.view.currentIndex = ObjectModel.index;

            _root.sidebarData.currentIndex = index;

            if (subindex >= 0)
                _root.sidebarData.currentSubIndex = subindex;
        }
    }

    signal clicked

    height: _listView.height + _listView.anchors.topMargin + _mainItem.height
    width: ListView.view ? ListView.view.width : 0

    states: [
        State{
            when: _root.isOpen
            name: "open"
            PropertyChanges{ target: _listView; height: _listView.count * (_listView.delegateHeight + _listView.spacing) - _listView.spacing; }
        },
        State{
            when: !_root.isOpen
            name: "closed"
            PropertyChanges{ target: _listView; height: 0; }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "open"
            NumberAnimation { target: _listView; property: "height"; duration: _root.openingSpeed; easing.type: Easing.InOutQuad }
        },
        Transition {
            from: "*"
            to: "closed"
            NumberAnimation { target: _listView; property: "height"; duration: _root.openingSpeed; easing.type: Easing.InOutQuad }
        }
    ]

	Controls.Checkable {
        id: _mainItem

        height: 50 * UI.Size.scale
        width: _root.width

        customCheckImplementation: true

        onClicked: {
            if (_root.model && _root.model.length > 0) {
                _root.isOpen = !_root.isOpen;
            } else {
                _root.selectItem();
            }
            _root.clicked();
        }

        states: [
            State {
                name: "disabled"
                when: !_root.enabled
                PropertyChanges{ target: _checkableBackground; color: "transparent"; opacity: 0.64; }
                PropertyChanges { target: _title; font.family: UI.PublicSans.regular; color: UI.Theme.text.secondary }
                PropertyChanges{ target: _icon; color: UI.Theme.text.secondary }
                PropertyChanges{ target: _arrow; color: UI.Theme.text.secondary }
            },
            State {
                name: "checked"
                when: _root.checked
                PropertyChanges{ target: _checkableBackground; color: _mainItem.mouseArea.containsMouse ? UI.Theme.primary.transparent.p16 : UI.Theme.primary.transparent.p8; opacity: 1;}
                PropertyChanges { target: _title; font.family: UI.PublicSans.semiBold; color: UI.Theme.primary.main; }
                PropertyChanges{ target: _icon; color: UI.Theme.primary.main }
                PropertyChanges{ target: _arrow; color: UI.Theme.primary.main; }
            },
            State {
                name: "unchecked"
                when: !_root.checked
                PropertyChanges{ target: _checkableBackground; color: _mainItem.mouseArea.containsMouse ? UI.Theme.background.neutral : "transparent"; opacity: 1;}
                PropertyChanges { target: _title; font.family: UI.PublicSans.regular; color: UI.Theme.text.secondary }
                PropertyChanges{ target: _icon; color: UI.Theme.text.secondary }
                PropertyChanges{ target: _arrow; color: UI.Theme.text.secondary }
            }
        ]

        Rectangle {
            id: _checkableBackground

            anchors.fill: _mainItem
            radius: UI.Size.pixel8
        }

        RowLayout {
            anchors{
                fill: _mainItem
                leftMargin: UI.Size.pixel16
                rightMargin: UI.Size.pixel12
            }

            spacing: UI.Size.pixel8

            Media.Icon {
                id: _icon

                Layout.alignment: Qt.AlignVCenter

                visible: iconData.path != ""
                size: UI.Size.pixel24
				color: _title.color.toString()
            }

			UI.Subtitle2 {
                id: _title

                Layout.leftMargin: _icon.visible ? UI.Size.pixel8 : 0
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                elide: Text.ElideRight

                verticalAlignment: Qt.AlignVCenter
            }

            Loader {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredHeight: item ? item.height : 0
                Layout.preferredWidth: item ? item.width : 0
                asynchronous: true

                active: _root.chip ? _root.chip.text !== "" : false

                sourceComponent: Component {
					Controls.MButton {
						type: Controls.MButton.Type.Soft
                        text: _root.chip ? _root.chip.text : ""
                        accent: _root.chip ? _root.chip.accent : UI.Theme.primary
                        size: UI.Size.Grade.Custom
                        horizontalPadding: UI.Size.pixel8
                        verticalPadding: UI.Size.pixel6
                        pixelSize: UI.Size.pixel12
                        mouseArea {
                            enabled: false
                            anchors.fill: null
                        }
                    }
                }
            }

            Media.Icon {
                id: _arrow

                Layout.alignment: Qt.AlignVCenter

                visible: _root.model ? _root.model.length > 0 : 0
                iconData: Media.Icons.light.chevronRight
                rotation: _root.isOpen ? 90 : 0

                size: UI.Size.pixel16

                Behavior on rotation { SmoothedAnimation { duration: _root.openingSpeed;} }
            }
        }
    }

    ListView {
        id: _listView

        property real delegateHeight: 36 * UI.Size.scale

        anchors{
            top: _mainItem.bottom; topMargin: UI.Size.pixel4
            left: _root.left; right: _root.right
        }

        currentIndex: _root.checked ? _root.sidebarData.currentSubIndex : -1
        spacing: UI.Size.pixel4
        interactive: false
        clip: true

        delegate: Rectangle {
            id: _subItem

			required property var modelData
			required property int index

            property bool checked: _root.sidebarData.currentSubIndex == index
            property string text: modelData.text
            property var chip: modelData.chip ? modelData.chip : null

            enabled: modelData.enabled === undefined ? true : modelData.enabled
            radius: _checkableBackground.radius
            height: _listView.delegateHeight
            width: _listView.width
            color: _subItemMouseArea.containsMouse ? UI.Theme.background.neutral : "transparent"

            states: [
                State {
                    name: "disabled"
                    when: !_subItem.enabled
                    PropertyChanges{ target: _subItem; opacity: 0.68; }
                    PropertyChanges{ target: _dot; color: UI.Theme.text.secondary; scale: 1 }
                    PropertyChanges{ target: _label; color: UI.Theme.text.secondary; font.family: UI.PublicSans.regular }
                },
                State {
                    name: "checked"
					when: _root.sidebarData.currentSubIndex === _subItem.index && _root.checked
                    PropertyChanges{ target: _subItem; opacity: 1; }
                    PropertyChanges{ target: _dot; color: UI.Theme.primary.main; scale: 3 }
                    PropertyChanges{ target: _label; color: UI.Theme.text.primary; font.family: UI.PublicSans.semiBold }
                },
                State {
                    name: "unchecked"
                    when: true
                    PropertyChanges{ target: _subItem; opacity: 1; }
                    PropertyChanges{ target: _dot; color: UI.Theme.text.secondary; scale: 1 }
                    PropertyChanges{ target: _label; color: UI.Theme.text.secondary; font.family: UI.PublicSans.regular }
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "checked"
                    ColorAnimation { target: _dot; duration: 300; easing.type: Easing.InOutQuad }
                    ColorAnimation { target: _label; duration: 0; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: _dot; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                },
                Transition {
                    from: "*"
                    to: "unchecked"
                    ColorAnimation { target: _dot; duration: 300; easing.type: Easing.InOutQuad }
                    ColorAnimation { target: _label; duration: 0; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: _dot; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                }
            ]

            RowLayout {
                anchors {
                    fill: _subItem
                    leftMargin: UI.Size.pixel16
                    rightMargin: UI.Size.pixel12
                }

                spacing: UI.Size.pixel16

                Item {
                    id: _dotContainer

                    Layout.preferredHeight: UI.Size.pixel24
                    Layout.preferredWidth: height
                    Layout.alignment: Qt.AlignVCenter

                    Rectangle { id: _dot; height: UI.Size.pixel4; width: UI.Size.pixel4; anchors.centerIn: _dotContainer; radius: 100 }
                }

				UI.Subtitle2 {
                    id: _label

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter

                    verticalAlignment: Qt.AlignVCenter

                    text: _subItem.text
                }

                Loader {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: item ? item.height : 0
                    Layout.preferredWidth: item ? item.width : 0
                    asynchronous: true

                    active: _subItem.chip

                    sourceComponent: Component {
						Controls.MButton {
							type: Controls.MButton.Type.Soft
                            text: _subItem.chip ? _subItem.chip.text : ""
                            accent: _subItem.chip ? _subItem.chip.accent : UI.Theme.primary
                            size: UI.Size.Grade.Custom
                            horizontalPadding: UI.Size.pixel6
                            verticalPadding: UI.Size.pixel6
                            pixelSize: UI.Size.pixel11

                            mouseArea {
                                enabled: false
                                anchors.fill: null
                            }
                        }
                    }
                }
            }


            MouseArea {
                id: _subItemMouseArea

                anchors.fill: _subItem

                hoverEnabled: _subItem.enabled
                cursorShape: Qt.PointingHandCursor

                onClicked: {
					_listView.currentIndex = _root.index;
					_root.selectItem(_subItem.index);
					_subItem.modelData.onClicked();
                }
            }
        }
    }
}
