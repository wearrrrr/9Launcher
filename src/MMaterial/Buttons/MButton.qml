import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial as MMaterial

Rectangle {
    id: _root

    property alias mouseArea: mouseArea
    property alias title: _title
    property MMaterial.PaletteBasic accent: MMaterial.Theme.primary //Needs to be PaletteBasic type

    property int pixelSize: {
        if(_root.size == MMaterial.Size.Grade.L)
            return MMaterial.Size.pixel15
        if(_root.size == MMaterial.Size.Grade.M)
            return MMaterial.Size.pixel14
        return MMaterial.Size.pixel13
    }
    property real horizontalPadding: {
        if(_root.size == MMaterial.Size.Grade.L)
            return MMaterial.Size.pixel22;
        if(_root.size == MMaterial.Size.Grade.M)
            return MMaterial.Size.pixel16;
        return MMaterial.Size.pixel10;
    }
    property real verticalPadding: {
        if(_root.size == MMaterial.Size.Grade.L)
            return MMaterial.Size.pixel12;
        if(_root.size == MMaterial.Size.Grade.M)
            return MMaterial.Size.pixel6;
        return MMaterial.Size.pixel4;
    }

    property bool isLoading: false
    property bool backgroundVisible: true
    property string text: "Button"

    property int type: MButton.Type.Contained
    property int size: MMaterial.Size.Grade.L

    property alias leftIcon: _leftIcon
    property alias rightIcon: _rightIcon

    signal clicked

    enum Type {
        Contained,
        Outlined,
        Text,
        Soft,
        Custom
    }

    implicitHeight: _private.oneOrLessChildrenVisible ? _title.contentHeight + _root.verticalPadding * 2 : _title.contentHeight + _root.verticalPadding * 2
    implicitWidth:  _mainLayout.implicitWidth + _root.horizontalPadding * 2

    radius: MMaterial.Size.pixel8
    opacity: mouseArea.pressed ? 0.7 : 1 //TODO replace with ripple effect when OpacityMask is fixed in Qt6
    color: _private.backgroundColor
    border.color: _private.borderColor

    state: "contained"
    states: [
        State{
            when: _root.type == MButton.Type.Contained
            name: "contained"
            PropertyChanges { target: _root; border.width: 0 }
            PropertyChanges {
                target: _private;
                backgroundColor: _root.enabled ? (mouseArea.containsMouse ? _root.accent.dark : _root.accent.main) : MMaterial.Theme.action.disabledBackground
                textColor: _root.enabled ? _root.accent.contrastText : MMaterial.Theme.action.disabled
                borderColor: "transparent"
            }
            PropertyChanges{ target: _leftIcon; color: _private.textColor }
            PropertyChanges{ target: _rightIcon; color: _private.textColor }
        },
        State{
            when: _root.type == MButton.Type.Outlined
            name: "outlined"
            PropertyChanges { target: _root; border.width: 1; }
            PropertyChanges {
                target: _private;
                backgroundColor: _root.enabled ? (mouseArea.containsMouse ? _root.accent.transparent.p8 : "transparent") : "transparent"
                textColor: _root.enabled ? _root.accent.main : MMaterial.Theme.action.disabled
                borderColor:  _root.enabled ? (_root.mouseArea.containsMouse ? _root.accent.main : _root.accent.transparent.p24) : MMaterial.Theme.action.disabled
            }
            PropertyChanges{ target: _leftIcon; color: _private.textColor }
            PropertyChanges{ target: _rightIcon; color: _private.textColor }
        },
        State{
            when: _root.type == MButton.Type.Text
            name: "text"
            PropertyChanges { target: _root;  border.width: 0; }
            PropertyChanges {
                target: _private;
                backgroundColor: mouseArea.containsMouse ? _root.accent.transparent.p8 : "transparent"
                textColor:  _root.enabled ? _root.accent.main : MMaterial.Theme.action.disabled
                borderColor: "transparent"
            }
            PropertyChanges{ target: _leftIcon; color: _private.textColor }
            PropertyChanges{ target: _rightIcon; color: _private.textColor }
        },
        State{
            when: _root.type == MButton.Type.Soft
            name: "soft"
            PropertyChanges { target: _root; border.width: 0; }
            PropertyChanges {
                target: _private;
                backgroundColor: _root.enabled ? (mouseArea.containsMouse ? _root.accent.transparent.p32 : _root.accent.transparent.p16) : MMaterial.Theme.action.disabledBackground
                textColor:  _root.enabled ? _root.accent.dark : MMaterial.Theme.action.disabled
                borderColor: "transparent"
            }
            PropertyChanges{ target: _leftIcon; color: _private.textColor }
            PropertyChanges{ target: _rightIcon; color: _private.textColor }
        },
        State{
            when: true
            name: "custom"
        }
    ]

    QtObject{
        id: _private

        property color backgroundColor: "#FFFFFF"
        property color textColor: "#FFFFFF"
        property color borderColor: "#FFFFFF"
        property bool oneOrLessChildrenVisible: !_title.visible && (!_leftIcon.visible || !_rightIcon.visible)
    }

    Behavior on implicitWidth {
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
    }

    RowLayout {
        id: _mainLayout

        anchors.centerIn: _root

        spacing: MMaterial.Size.pixel8

        MMaterial.Icon {
            id: _leftIcon

            Layout.alignment: _title.visible ? Qt.AlignLeft : Qt.AlignCenter
            size: _title.contentHeight * 0.65
            visible: iconData && !_root.isLoading
        }

        MMaterial.H2{
            id: _title

            Layout.alignment: Qt.AlignCenter

            visible: text !== "" && !_root.isLoading
            font.pixelSize: _root.pixelSize
            text: _root.text
            color: _private.textColor

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter

            font{
                capitalization: Font.Capitalize
                bold: true
            }
        }

        MMaterial.Icon {
            id: _rightIcon

            Layout.alignment: _title.visible ? Qt.AlignRight : Qt.AlignCenter

            visible: iconData && !_root.isLoading
            size: _title.contentHeight * 0.65
        }

        BusyIndicator{
            Layout.alignment: Qt.AlignCenter

            Layout.preferredHeight: _root.height* 0.7
            Layout.preferredWidth: height

            Material.accent: _title.color
            visible: _root.isLoading
        }
    }


    MouseArea {
        id: mouseArea

        anchors.fill: _root

        hoverEnabled: _root.enabled
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: !_root.isLoading

        onClicked: { _root.clicked(); }
    }
}
