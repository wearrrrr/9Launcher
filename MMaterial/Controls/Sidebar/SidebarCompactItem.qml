pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Controls.Checkable {
    id: _root

    required property int index

    property SidebarData sidebarData

    property string category

    property alias icon: _icon
    property alias text: _title.text
    property alias model: _listView.model
    property alias list: _listView
    property alias contextMenu: _contextMenu

    property bool isOpen: false
    property bool hidden: false

    function selectItem(subindex) : void {
        if (ListView.view) {
            _root.sidebarData.currentIndex = index;

            if (subindex >= 0)
                _root.sidebarData.currentSubIndex = subindex;
        }
    }

    implicitWidth: ListView.view ? ListView.view.width : 0
    implicitHeight: _root.hidden ? 0 : 54 * UI.Size.scale
    clip: true

    checked: _root.sidebarData.currentIndex === index
    customCheckImplementation: true
    state: "checked"

    onVisibleChanged: { if(_contextMenu.opened){ _contextMenu.close(); }}
    onClicked: {
        if(_root.model.length > 0){
            if (_contextMenu.opened)
                _contextMenu.close();
            else
                _contextMenu.open();
        }
        else
            selectItem(-1);
    }

    states: [
        State {
            name: "disabled"
            when: !_root.enabled
            PropertyChanges{ target: _root; opacity: 0.64 }
            PropertyChanges{ target: _background; color: "transparent" }
            PropertyChanges { target: _title; font.variableAxes: { "wght": 400 }; color: UI.Theme.text.secondary }
			PropertyChanges{ target: _icon; color: UI.Theme.text.secondary }
			PropertyChanges{ target: _arrow; color: UI.Theme.text.secondary }
        },
        State {
            name: "checked"
            when: _root.checked
            PropertyChanges{ target: _root; opacity: 1;}
			PropertyChanges{ target: _background; color: _root.mouseArea.containsMouse ? UI.Theme.primary.transparent.p16 : UI.Theme.primary.transparent.p8; }
            PropertyChanges { target: _title; font.variableAxes: { "wght": 600 }; color: UI.Theme.primary.main; }
			PropertyChanges{ target: _icon; color: UI.Theme.primary.main }
			PropertyChanges{ target: _arrow; color: UI.Theme.primary.main; }
        },
        State {
            name: "unchecked"
            when: !_root.checked
            PropertyChanges{ target: _root; opacity: 1;}
			PropertyChanges{ target: _background; color: _root.mouseArea.containsMouse ? UI.Theme.background.neutral : "transparent"; }
            PropertyChanges { target: _title; font.variableAxes: { "wght": 400 }; color: UI.Theme.text.secondary }
			PropertyChanges{ target: _icon; color: UI.Theme.text.secondary }
			PropertyChanges{ target: _arrow; color: UI.Theme.text.secondary }
        }
    ]

    Rectangle {
        id: _background

        anchors.fill: _root
        radius: UI.Size.pixel8
    }

	Media.Icon {
        id: _icon

        anchors {
            horizontalCenter: _root.horizontalCenter
            top: _root.top; topMargin: UI.Size.pixel8
        }

        size: UI.Size.pixel22
		color: UI.Theme.primary.main.toString()
        iconData: Media.Icons.light.star
    }

	UI.B2 {
        id: _title

        anchors {
            horizontalCenter: _root.horizontalCenter
            bottom: _root.bottom; bottomMargin: UI.Size.pixel4
        }

        width: _root.width
        height: UI.Size.pixel16

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        font.pixelSize: UI.Size.pixel10
    }

	Media.Icon {
        id: _arrow

        anchors {
            verticalCenter: _icon.verticalCenter
            left: _icon.right; leftMargin: UI.Size.pixel6
        }

        visible: _root.model ? _root.model.length > 0 : 0
        iconData: Media.Icons.light.chevronRight

        size: UI.Size.pixel16
    }

    //Popup
    Menu {
        id: _contextMenu

        x: _root.width + UI.Size.pixel6
        currentIndex: _root.sidebarData.currentSubIndex
        closePolicy: Popup.CloseOnPressOutsideParent

        background: Rectangle {
            radius: 12
			color: UI.Theme.background.main
            implicitWidth: 200
            implicitHeight: 0
			border.color: UI.Theme.action.disabledBackground
        }

        contentItem: Item {
            id: _contentItem

            implicitHeight: _listView.contentHeight + UI.Size.pixel8

            ListView {
                id: _listView

                anchors.centerIn: _contentItem

                width: _contentItem.width - UI.Size.pixel8
                implicitHeight: contentHeight

                model: _contextMenu.contentModel
                interactive: Window.window
                             ? contentHeight + _contextMenu.topPadding + _contextMenu.bottomPadding > Window.window.height
                             : false
                clip: true
                currentIndex: _contextMenu.currentIndex

                ScrollIndicator.vertical: ScrollIndicator {}

				delegate: Controls.ListItem {
					id: _subItem
                    required property int index
					required property var modelData

					property var chip: modelData.chip ? modelData.chip : null

					text: modelData.text
                    width: _listView.width
                    selected: index == _root.sidebarData.currentSubIndex && _root.checked

                    onClicked: {
                        _root.selectItem(index);
						modelData.onClicked();
                        _contextMenu.close();
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
								horizontalPadding: UI.Size.pixel5
								verticalPadding: UI.Size.pixel5
								pixelSize: UI.Size.pixel10

								mouseArea {
									enabled: false
									anchors.fill: null
								}
							}
						}
					}
                }
            }
        }
    }
}
