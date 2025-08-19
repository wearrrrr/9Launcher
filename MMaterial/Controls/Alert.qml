import QtQuick
import QtQuick.Layouts

import MMaterial.Media as Media
import MMaterial.UI as UI

Rectangle {
    id: _root

    enum Severity { Info, Success, Warning, Error }
    enum Variant { Standard, Filled, Outlined }

    property alias actionButton: _actionButton
    property alias dismissButton: _dismissButton

    property int severity: Alert.Severity.Info
    property int variant: Alert.Variant.Filled

    property string text: ""
	property Media.IconData icon: {
		if(_root.severity == Alert.Severity.Info) return Media.Icons.light.info;
		if(_root.severity == Alert.Severity.Success) return Media.Icons.light.checkCircle;
		if(_root.severity == Alert.Severity.Warning) return Media.Icons.light.warning;
		if(_root.severity == Alert.Severity.Error) return Media.Icons.light.info;
    }

	property UI.PaletteBasic accent: {
		if(_root.severity == Alert.Severity.Info) return UI.Theme.info;
		if(_root.severity == Alert.Severity.Success) return UI.Theme.success;
		if(_root.severity == Alert.Severity.Warning) return UI.Theme.warning;
		if(_root.severity == Alert.Severity.Error) return UI.Theme.error;
    }

    signal clicked
    signal close

    implicitHeight: _text.implicitHeight > _private.recommendedHeight ? _text.implicitHeight + _mainLayout.anchors.margins*2 : _private.recommendedHeight
    implicitWidth: 720

    radius: 8

    state: "standard"
    states: [
        State{
            name: "standard"
            when: _root.variant == Alert.Variant.Standard
            PropertyChanges{ target: _root; color: _root.accent.lighter; border.width: 0}
            PropertyChanges{ target: _icon; color: _root.accent.main}
            PropertyChanges{ target: _closeIcon; color: _root.accent.main}
            PropertyChanges{ target: _text; color: _root.accent.darker}
        },
        State{
            name: "filled"
            when: _root.variant == Alert.Variant.Filled
            PropertyChanges{ target: _root; color: _root.accent.main; border.width: 0}
            PropertyChanges{ target: _icon; color: _root.accent.contrastText}
            PropertyChanges{ target: _closeIcon; color: _root.accent.contrastText}
            PropertyChanges{ target: _text; color: _root.accent.contrastText}
            PropertyChanges{ target: _dismissButton; title.color: _root.accent.contrastText; border.color: _root.accent.contrastText }
			PropertyChanges{ target: _actionButton; title.color: UI.Theme.main.p800; color: UI.Theme.common.white; }
        },
        State{
            name: "outlined"
            when: _root.variant == Alert.Variant.Outlined
            PropertyChanges{ target: _root; color: UI.Theme.background.main; border.width: UI.Size.pixel1; border.color: accent.dark}
            PropertyChanges{ target: _icon; color: _root.accent.main}
            PropertyChanges{ target: _closeIcon; color: _root.accent.main}
            PropertyChanges{ target: _text; color: _root.accent.dark}
        }
    ]

    QtObject{
        id: _private

        readonly property int recommendedHeight: UI.Size.scale * 50
    }

    MouseArea {
        id: mouseArea

        anchors.fill: _root

        onClicked: _root.clicked()
    }

    RowLayout {
        id: _mainLayout

        anchors{
            fill: _root
            margins: UI.Size.pixel8
        }

		Media.Icon {
            id: _icon

            Layout.alignment: _text.lineCount <= 1 ? Qt.AlignVCenter : Qt.AlignTop
            Layout.topMargin: _text.lineCount <= 1 ? 0 : UI.Size.pixel6
            Layout.leftMargin: UI.Size.pixel8

            size: UI.Size.pixel24
            iconData: _root.icon
        }

		UI.B2 {
            id: _text

            Layout.fillWidth: true
            Layout.leftMargin: UI.Size.pixel12

            text: _root.text
			color: UI.Theme.info.darker
            verticalAlignment: Qt.AlignVCenter
            elide: Text.ElideNone
            wrapMode: Text.WordWrap
            lineHeight: 1
        }

        MButton {
            id: _actionButton

            type: MButton.Type.Contained
            size: UI.Size.S
            text: ""
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredHeight: _actionButton.implicitHeight
            Layout.preferredWidth: _actionButton.implicitWidth
            accent: _root.accent
            visible: text != ""
        }

        MButton {
            id: _dismissButton

            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredHeight: _dismissButton.implicitHeight
            Layout.preferredWidth: _dismissButton.implicitWidth

            type: MButton.Type.Outlined
            size: UI.Size.S
            text: ""
            accent: _root.accent
            visible: text != ""

            onClicked: _root.close()
        }

		Media.Icon {
            id: _closeIcon

            Layout.alignment: _text.lineCount <= 1 ? Qt.AlignVCenter : Qt.AlignTop
            Layout.topMargin: _text.lineCount <= 1 ? 0 : UI.Size.pixel6
            Layout.rightMargin: UI.Size.pixel8

            visible: !_actionButton.visible && !_dismissButton.visible
            size: UI.Size.pixel18
			iconData: Media.Icons.light.close
            interactive: true

            onClicked: _root.close()
        }
    }
}

