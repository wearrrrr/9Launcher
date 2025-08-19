import QtQuick 
import QtQuick.Layouts

import MMaterial.UI as UI

RowLayout {
    id: _root

	property real lineWidth: UI.Size.pixel4

	property UI.PaletteBasic accent: UI.Theme.primary
    property color foregroundColor: accent.main
    property color backgroundColor: accent.transparent.p24
    property bool showLabel: false
    
    property alias barHeight: _bar.height
    property alias label: _label

    property int progress: 50

    implicitWidth: 300
	implicitHeight: UI.Size.pixel10

    Rectangle {
        id: _bar

        Layout.alignment: Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.preferredHeight: _root.lineWidth

        color: _root.backgroundColor
        radius: 50

        Rectangle {
            id: _innerBar

            anchors {
                top: _bar.top
                left: _bar.left
                bottom: _bar.bottom
            }

            width: _root.progress * _bar.width / 100

            color: _root.foregroundColor
            radius: _bar.radius

            Behavior on width { SmoothedAnimation { duration: 50;} }
        }
    }

	UI.Caption{
        id: _label

        Layout.preferredWidth: contentWidth
        Layout.alignment: Qt.AlignVCenter

        visible: _root.showLabel
		color: UI.Theme.text.secondary
        text: _root.progress + "%"
        verticalAlignment: Qt.AlignVCenter

        onContentWidthChanged: font.pixelSize * 2.6
    }
}
