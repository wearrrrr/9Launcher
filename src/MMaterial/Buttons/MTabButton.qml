import QtQuick
import QtQuick.Layouts

import MMaterial

Item {
    id: _root

    property PaletteBasic accent: Theme.primary

    property alias leftIcon: _leftIcon
    property alias rightIcon: _rightIcon
    property alias text: _title.text
    property alias pixelSize: _title.font.pixelSize

    property real horizontalPadding: 0
    property real verticalPadding: Size.pixel12

    property bool selected: ListView.view?.currentIndex === ObjectModel?.index;

    signal clicked

    implicitHeight: _title.contentHeight + _root.verticalPadding * 2
    implicitWidth: _mainLayout.implicitWidth + _root.horizontalPadding * 2

    opacity: _mouseArea.pressed ? 0.7 : _mouseArea.containsMouse ? 0.85 : 1

    onClicked: {
        if(typeof index !== "undefined")
            ListView.view.currentIndex = index;
        else if(typeof ObjectModel.index !== "undefined")
            ListView.view.currentIndex = ObjectModel.index;
    }

    RowLayout {
        id: _mainLayout

        anchors.fill: _root

        spacing: Size.pixel8

        Icon {
            id: _leftIcon

            Layout.alignment: _title.visible ? Qt.AlignLeft : Qt.AlignCenter

            color: _title.color
            size: _root.pixelSize * 1.42
            visible: iconData && !_root.isLoading
        }

        H2{
            id: _title

            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true

            visible: text !== "" && !_root.isLoading
            text: _root.text
            color: _root.selected ? Theme.text.primary : Theme.text.secondary

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            font{
                pixelSize: Size.pixel14
                capitalization: Font.Capitalize
                bold: true
            }
        }

        Icon {
            id: _rightIcon

            Layout.alignment: _title.visible ? Qt.AlignRight : Qt.AlignCenter

            color:  _title.color
            visible: iconData && !_root.isLoading
            size: _root.pixelSize * 1.42
        }
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: _root
        hoverEnabled: true

        onClicked: _root.clicked()
    }
}
