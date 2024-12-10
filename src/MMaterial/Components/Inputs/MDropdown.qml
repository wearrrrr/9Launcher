import QtQuick 
import QtQuick.Controls.Material

import MMaterial

MTextField {
    id: _root

    property var model: ["Label 1", "Label 2", "Label 3"]
    property alias delegate: _listView.delegate
    property int delegateCount: 5

    function toggle() : void {
        if(_contextMenu.opened)
            _contextMenu.close();
        else
            _contextMenu.open();
    }

    signal accepted(index : int)

    showPlaceholder: !input.focus && input.text === "" && !_contextMenu.opened

    type: MTextField.Type.Outlined
    hoverHandler: _hoverHandler

    rightIcon {
        rotation: _contextMenu.opened ? 180 : 0
        iconData: Icons.light.keyboardArrowDown
        onClicked: _root.toggle();
    }

    input {
        enabled: false
        readOnly: true
        text: _listView.currentItem ? _listView.currentItem.text : ""
    }

    Behavior on rightIcon.rotation { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }

    TapHandler{
        id: _tapHandler

        onTapped: _root.toggle();
    }

    HoverHandler{
        id: _hoverHandler

        cursorShape: Qt.PointingHandCursor
    }

    Menu {
        id: _contextMenu

        y: _root.height + 1
        closePolicy: Menu.CloseOnEscape | Menu.CloseOnReleaseOutsideParent

        background: Rectangle {
            implicitWidth: _root.width

            radius: 12
            color: Theme.background.main
            border.color: Theme.action.disabledBackground
        }

        contentItem: Item {
            id: _contentItem

            implicitHeight: _listView.height + Size.pixel8

            ListView {
                id: _listView

                anchors.centerIn: _contentItem

                width: _contentItem.width - Size.pixel8
                height: count > _root.delegateCount ? _root.delegateCount * Size.pixel46 : contentHeight

                model: _root.model

                clip: true
                currentIndex: _contextMenu.currentIndex

                ScrollIndicator.vertical: ScrollIndicator {}

                delegate: ListItem {
                    text: modelData
                    width: _listView.width
                    onClicked: {
                        _contextMenu.close();
                        _root.accepted(index);
                    }
                }
            }
        }
    }
}
