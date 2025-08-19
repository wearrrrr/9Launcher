pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Media as Media
import MMaterial.Controls as Controls

Item {
    id: _root
    objectName: "extendedSidebar"

	property SidebarData sidebarData

    property alias logo: _logo
    property alias list: _sidebarLayout
    property alias avatar: _avatar
    property alias title: _title
    property alias subtitle: _subtitle
    property alias model: _sidebarLayout.model

    implicitWidth: 280
    implicitHeight: parent.height

    ColumnLayout {
        anchors {
            fill: _root
            margins: UI.Size.pixel16
            topMargin: UI.Size.pixel24
        }

		Media.Icon {
            id: _logo

            Layout.leftMargin: UI.Size.pixel8

			color: UI.Theme.primary.main.toString()
            size: UI.Size.pixel32
            iconData: Media.Icons.heavy.logo
        }

        Rectangle {
            id: _avatarRect

            Layout.leftMargin: UI.Size.pixel4
            Layout.rightMargin: UI.Size.pixel4
            Layout.topMargin: UI.Size.pixel32
            Layout.preferredHeight: 72 * UI.Size.scale
            Layout.fillWidth: true

            radius: 12
			color: UI.Theme.background.neutral

			Controls.Avatar{
                id: _avatar

                anchors{
                    left: _avatarRect.left; leftMargin: UI.Size.pixel20;
                    top: _avatarRect.top; topMargin: UI.Size.pixel16;
                    bottom: _avatarRect.bottom; bottomMargin: UI.Size.pixel16
                }

                height: UI.Size.pixel40
                width: UI.Size.pixel40

                title: _title.text
            }

			UI.Subtitle2 {
                id: _title

                anchors{
                    left: _avatar.right; leftMargin: UI.Size.pixel16;
                    top: _avatarRect.top; topMargin: UI.Size.pixel16;
                    right: _avatarRect.right; rightMargin: UI.Size.pixel20;
                }

                text: "John Doe"
                maximumLineCount: 1
                elide: Text.ElideRight
				color: UI.Theme.text.primary
            }

			UI.B2 {
                id: _subtitle

                anchors {
                    left: _avatar.right; leftMargin: UI.Size.pixel16;
                    bottom: _avatarRect.bottom; bottomMargin: UI.Size.pixel16;
                    right: _avatarRect.right; rightMargin: UI.Size.pixel20;
                }

                verticalAlignment: Qt.AlignBottom
                text: "Admin"
				color: UI.Theme.text.disabled
                maximumLineCount: 1
            }
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
				delegate: SidebarCategoryLabel{
                    required property string section

                    text: section
                }
            }

			delegate: SidebarExtendedItem {
                id: _delegate

				property SidebarItem data: _root.model[index]

                sidebarData: _root.sidebarData
                isOpen: _delegate.sidebarData.currentIndex == index
                text: _delegate.data.text;
                icon.iconData: _delegate.data.icon
                category: _delegate.data.category
                model: _delegate.data.model ?? []
                chip: _delegate.data.chip
                hidden: _delegate.data.hidden

                onClicked: typeof _delegate.data.onClicked === "function" ? _delegate.data.onClicked() : () => {}
            }
        }
    }
}
