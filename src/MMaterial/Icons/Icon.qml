import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial

Loader {
    id: _root

    property IconData iconData
    readonly property bool containsMouse: _root.item?.containsMouse ?? false

    property real size: Size.pixel30
    property string color: ""

    property bool interactive: false
    property bool hoverable: true

    signal clicked

    height: _root.size
    width: _root.size

    Layout.preferredHeight: _root.size
    Layout.preferredWidth: _root.size

    sourceComponent: iconData?.type == IconData.Light ? lightIcon : heavyIcon
    asynchronous: true
    // visible: _root.status == Loader.Ready

    Component {
        id: lightIcon

        LightIcon {
            iconData: _root.iconData
            size: _root.size
            color: _root.color
            interactive: _root.interactive
            hoverable: _root.hoverable

            onClicked: _root.clicked()
        }
    }

    Component {
        id: heavyIcon

        HeavyIcon {
            iconData: _root.iconData
            size: _root.size
            color: _root.color
            interactive: _root.interactive
            hoverable: _root.hoverable

            onClicked: _root.clicked()
        }
    }
}
