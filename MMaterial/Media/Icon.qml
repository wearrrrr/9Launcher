pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Media as Media

Loader {
    id: _root

	property Media.IconData iconData
    readonly property bool containsMouse: _root.item?.containsMouse ?? false

	property real size: UI.Size.pixel30
    property string color

    property bool interactive: false
    property bool hoverable: true

    signal clicked

    height: _root.size
    width: _root.size

    Layout.preferredHeight: _root.size
    Layout.preferredWidth: _root.size

	// sourceComponent: iconData?.type == Media.IconData.Light ? lightIcon : heavyIcon
    sourceComponent: lightIcon
    asynchronous: true
    // visible: _root.status == Loader.Ready

    Component {
        id: lightIcon

		Media.LightIcon {
            iconData: _root.iconData
            size: _root.size
            color: _root.color
            interactive: _root.interactive
            hoverable: _root.hoverable

            onClicked: _root.clicked()
        }
    }

    // Component {
    //     id: heavyIcon

	// 	Media.HeavyIcon {
    //         iconData: _root.iconData
    //         size: _root.size
    //         color: _root.color
    //         interactive: _root.interactive
    //         hoverable: _root.hoverable

    //         onClicked: _root.clicked()
    //     }
    // }
}
