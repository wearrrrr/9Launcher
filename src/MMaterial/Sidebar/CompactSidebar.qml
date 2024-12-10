import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import MMaterial

Item {
    id: _root
    objectName: "compactSidebar"

    property SidebarData sidebarData

    default property alias container: _sidebarLayout.data

    property alias logo: _logo
    property alias list: _sidebarLayout
    property alias model: _sidebarLayout.model

    implicitWidth: 86 * Size.scale
    implicitHeight: parent.height

    ColumnLayout {
        anchors {
            fill: _root
            margins: Size.pixel6
            topMargin: Size.pixel24
        }

        Icon {
            id: _logo

            Layout.alignment: Qt.AlignHCenter

            size: Size.pixel32

            color: Theme.primary.main
            iconData: Icons.heavy.logo
        }

        ListView {
            id: _sidebarLayout

            Layout.topMargin: Size.pixel16
            Layout.fillHeight: true;
            Layout.fillWidth: true

            spacing: Size.pixel4
            clip: true
            currentIndex: _root.sidebarData.currentIndex

            section {
                property: "category"
                delegate: SidebarSeparator{
                    required property string section
                }
            }

            delegate: SidebarCompactItem {
                id: _delegate

                property SidebarItem data: _root.model[index]

                sidebarData: _root.sidebarData
                text: _delegate.data.text;
                icon.iconData: _delegate.data.icon
                category: _delegate.data.category
                model: _delegate.data.model ?? []

                onClicked: typeof _delegate.data.onClicked === "function" ? _delegate.data.onClicked() : () => {}

            }
        }
    } 
}
