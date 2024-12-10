import QtQuick
import QtQuick.Controls.Material

import MMaterial

Checkable {
    id: _root

    property SidebarData sidebarData

    property string category

    property alias icon: _icon
    property alias text: _title.text
    property alias model: _listView.model
    property alias list: _listView
    property alias contextMenu: _contextMenu

    property bool isOpen: false

    function selectItem(subindex) : void {
        if (ListView.view) {
            _root.sidebarData.currentIndex = index;

            if (subindex >= 0)
                _root.sidebarData.currentSubIndex = subindex;
        }
    }

    implicitWidth: ListView.view ? ListView.view.width : 0
    implicitHeight: 54 * Size.scale

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
            selectItem();
    }

    states: [
        State {
            name: "disabled"
            when: !_root.enabled
            PropertyChanges{ target: _root; opacity: 0.64 }
            PropertyChanges{ target: _background; color: "transparent" }
            PropertyChanges { target: _title; font.family: PublicSans.regular; color: Theme.text.secondary }
            PropertyChanges{ target: _icon; color: Theme.text.secondary }
            PropertyChanges{ target: _arrow; color: Theme.text.secondary }
        },
        State {
            name: "checked"
            when: _root.checked
            PropertyChanges{ target: _root; opacity: 1;}
            PropertyChanges{ target: _background; color: _root.mouseArea.containsMouse ? Theme.primary.transparent.p16 : Theme.primary.transparent.p8; }
            PropertyChanges { target: _title; font.family: PublicSans.semiBold; color: Theme.primary.main; }
            PropertyChanges{ target: _icon; color: Theme.primary.main }
            PropertyChanges{ target: _arrow; color: Theme.primary.main; }
        },
        State {
            name: "unchecked"
            when: !_root.checked
            PropertyChanges{ target: _root; opacity: 1;}
            PropertyChanges{ target: _background; color: _root.mouseArea.containsMouse ? Theme.background.neutral : "transparent"; }
            PropertyChanges { target: _title; font.family: PublicSans.regular; color: Theme.text.secondary }
            PropertyChanges{ target: _icon; color: Theme.text.secondary }
            PropertyChanges{ target: _arrow; color: Theme.text.secondary }
        }
    ]

    Rectangle {
        id: _background

        anchors.fill: _root
        radius: Size.pixel8
    }

    Icon {
        id: _icon

        anchors {
            horizontalCenter: _root.horizontalCenter
            top: _root.top; topMargin: Size.pixel8
        }

        size: Size.pixel22
        color: Theme.primary.main
        iconData: Icons.light.star
    }

    B2 {
        id: _title

        anchors {
            horizontalCenter: _root.horizontalCenter
            bottom: _root.bottom; bottomMargin: Size.pixel4
        }

        width: _root.width
        height: Size.pixel16

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        font.pixelSize: Size.pixel10
    }

    Icon {
        id: _arrow

        anchors {
            verticalCenter: _icon.verticalCenter
            left: _icon.right; leftMargin: Size.pixel6
        }

        visible: _root.model ? _root.model.length > 0 : 0
        iconData: Icons.light.chevronRight

        size: Size.pixel16
    }

    //Popup
    Menu {
        id: _contextMenu

        x: _root.width + Size.pixel6
        currentIndex: _root.sidebarData.currentSubIndex
        closePolicy: Popup.CloseOnPressOutsideParent

        background: Rectangle {
            radius: 12
            color: Theme.background.main
            implicitWidth: 200
            implicitHeight: 0
            border.color: Theme.action.disabledBackground
        }

        contentItem: Item {
            id: _contentItem

            implicitHeight: _listView.contentHeight + Size.pixel8

            ListView {
                id: _listView

                anchors.centerIn: _contentItem

                width: _contentItem.width - Size.pixel8
                implicitHeight: contentHeight

                model: _contextMenu.contentModel
                interactive: Window.window
                             ? contentHeight + _contextMenu.topPadding + _contextMenu.bottomPadding > Window.window.height
                             : false
                clip: true
                currentIndex: _contextMenu.currentIndex

                ScrollIndicator.vertical: ScrollIndicator {}

                delegate: ListItem {
                    property var modelItem: _root.model[index]

                    text: modelItem.text
                    width: _listView.width
                    selected: index == _root.sidebarData.currentSubIndex && _root.checked

                    onClicked: {
                        _root.selectItem(index);
                        modelItem.onClicked();
                        _contextMenu.close();
                    }
                }
            }
        }
    }
}
