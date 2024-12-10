import QtQuick
import QtQuick.Layouts

import MMaterial

Item {
    id: root
    objectName: "mobileSidebar"

    property SidebarData sidebarData

    default property alias container: barList.data

    property alias list: barList
    property alias model: barList.model

    implicitWidth: parent.width
    implicitHeight: Size.pixel54 + barList.anchors.margins * 2

    ListView {
        id: barList

        anchors {
            top: root.top
            bottom: root.bottom
            margins: Size.pixel6
            horizontalCenter: root.horizontalCenter
        }

        width: Math.min(root.width - Size.pixel40, barList.contentWidth)
        spacing: Size.pixel8
        clip: true
        currentIndex: root.sidebarData.currentIndex
        orientation: ListView.Horizontal

        delegate: SidebarCompactItem {
            id: _delegate

            property SidebarItem data: root.model[index]

            width: Size.pixel36 * 2
            height: barList.height

            sidebarData: root.sidebarData
            text: _delegate.data.text;
            icon.iconData: _delegate.data.icon
            category: _delegate.data.category
            model: _delegate.data.model ?? []

            contextMenu {
                x: 0
                y: -_delegate.contextMenu.height - Size.pixel6
            }

            onClicked: typeof _delegate.data.onClicked === "function" ? _delegate.data.onClicked() : () => {}
        }
    }
}