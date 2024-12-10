import QtQuick

import MMaterial

ListView {
    id: _root

    orientation: ListView.Horizontal
    spacing: Size.pixel40

    highlightMoveDuration: 400
    highlightFollowsCurrentItem: true

    highlight: Component {
        Item {
            id: _highlight

            width: _root.currentItem?.width; height: _root.currentItem?.height

            Behavior on width { NumberAnimation { duration: _root.highlightMoveDuration; easing.type: Easing.InOutBack } }

            Rectangle {
                anchors.bottom:_highlight.bottom

                height: orientation == ListView.Horizontal ? Size.pixel1 * 2 : _highlight.height
                width: orientation == ListView.Horizontal ? _highlight.width : Size.pixel1 * 2

                color: Theme.primary.main
            }
        }
    }

    model: ObjectModel {
        id: _objectModel
    }
}
