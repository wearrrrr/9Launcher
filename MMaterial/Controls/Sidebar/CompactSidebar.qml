pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Media as Media

Item {
    id: _root
    objectName: "compactSidebar"

    property SidebarData sidebarData

    default property alias container: _sidebarLayout.data

    property alias logo: _logo
    property alias list: _sidebarLayout
    property alias model: _sidebarLayout.model

    implicitWidth: 86 * UI.Size.scale
    implicitHeight: parent.height

    ColumnLayout {
        anchors {
            fill: _root
            margins: UI.Size.pixel6
            topMargin: UI.Size.pixel24
        }

		Media.Icon {
            id: _logo

            Layout.alignment: Qt.AlignHCenter

            size: UI.Size.pixel32

			color: UI.Theme.primary.main.toString()
            iconData: Media.Icons.heavy.logo
        }

        ListView {
            id: _sidebarLayout

            Layout.topMargin: UI.Size.pixel16
            Layout.fillHeight: true;
            Layout.fillWidth: true

            spacing: UI.Size.pixel4
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
