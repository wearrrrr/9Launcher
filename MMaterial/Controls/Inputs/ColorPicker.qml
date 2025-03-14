pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial as MMaterial
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.Controls.Inputs as Inputs
import MMaterial.UI as UI
import MMaterial.Media as Media

Dialogs.Dialog {
    id: root

    property color initialColor
    property color selectedColor
    property alias currentColor: internal.color

    function toggle() {
        if (visible) close()
        else open()
    }

    function addToHistory(color) {
        MMaterial.ColorHistoryModel.append(color)
    }

    property Window pickingWindow: Window {

        property alias pickerPreview: pickerPreview

        function stopPicking() {
            root.pickingWindow.close()
            pickingAction.trigger()
        }

        color: "transparent"
        visible: false
        flags: Qt.FramelessWindowHint | Qt.WA_TranslucentBackground

        Component.onCompleted: pickerPreview.currentWindow = pickingWindow

        MMaterial.ColorPickerPreview {
            id: pickerPreview
            anchors.fill: parent
        }

        Rectangle {
            color: "transparent"
            anchors.fill: parent
            focus: true
            radius: UI.Size.pixel6

            border {
                width: 2
                color: UI.Theme.primary.main
            }

            Keys.onEscapePressed: {
                internal.revertPicking()
                root.pickingWindow.stopPicking()
            }
        }

        MouseArea {
            id: mousePicker
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.CrossCursor

            onPositionChanged: {
                const mousePosition = Qt.point(mouseX, mouseY)
                pickerPreview.mousePosition = mousePosition
                internal.eyedrop(mousePosition)
                pickerPreview.update()
            }

            onClicked: {
                root.pickingWindow.stopPicking()
                root.addToHistory(internal.color)
            }
        }
    }

    component Line: Rectangle {
        Layout.preferredHeight: 1
        color: UI.Theme.other.divider
    }

    implicitWidth: 300 * UI.Size.scale
    implicitHeight: mainLayout.implicitHeight + padding * 2
    padding: UI.Size.pixel20

    onAccepted: () => {
        root.selectedColor = root.currentColor
        root.addToHistory(root.currentColor)
        root.close()
    }

    onClosed: () => {
        hexField.input.focus = false
        hexField.input.deselect()
        opacityInput.focus = false
        opacityInput.deselect()
    }

    enter: Transition {
        NumberAnimation { property: "scale"; from: 0.9; to: 1; easing.type: Easing.OutQuart; duration: 220 }
    }

    exit: Transition {
        NumberAnimation { property: "scale"; to: 0.9; easing.type: Easing.OutQuart; duration: 220 }
        NumberAnimation { property: "opacity"; to: 0.0; easing.type: Easing.OutQuart; duration: 150 }
    }

    contentItem: Item {
        id: contentItemRoot

        Component.onCompleted: {
            if (root.currentColor.valid)
                root.addToHistory(root.currentColor)
        }

        Action {
            id: pickingAction

            checkable: true

            onToggled: {
                if (pickingAction.checked && root.visible) {
                    internal.startPicking()
                    root.pickingWindow.showFullScreen()
                }
            }
        }

        ColumnLayout {
            id: mainLayout

            width: contentItemRoot.width
            spacing: 0

            Item {
                Layout.fillWidth: true
                Layout.minimumHeight: width

				Inputs.ShadeChooser {
                    color: internal.color

                    anchors {
                        fill: parent
                    }

                    onColorChanged: internal.color = color
                }
            }

            ColorSlider {
                id: hueSlider

                Layout.fillWidth: true
                Layout.topMargin: UI.Size.pixel10
                Layout.leftMargin: UI.Size.pixel4
                Layout.rightMargin: UI.Size.pixel4
                Layout.preferredHeight: UI.Size.pixel15
                value: internal.color.hsvHue

                onValueChanged: if (hueSlider.pressed) internal.color.hsvHue = value
            }

            OpacitySlider {
                id: opacitySlider

                Layout.fillWidth: true
                Layout.topMargin: UI.Size.pixel10
                Layout.leftMargin: UI.Size.pixel4
                Layout.rightMargin: UI.Size.pixel4
                Layout.preferredHeight: UI.Size.pixel15
                colorPickerController: internal
            }

            RowLayout {
                id: textInputLayout

                Layout.fillWidth: true
                Layout.leftMargin: UI.Size.pixel4
                Layout.rightMargin: UI.Size.pixel4
                Layout.minimumHeight: UI.Size.pixel36
                Layout.topMargin: -UI.Size.pixel10

                spacing: UI.Size.pixel15

                Inputs.MTextField {
                    id: hexField

                    Layout.leftMargin: UI.Size.pixel5
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    placeholder: ""

                    input {
                        horizontalAlignment: Text.AlignLeft
                        inputMask: "HHHHHHhh"
                        topPadding: 0
                        bottomPadding: 0
                        leftPadding: hashtagPrefix.contentWidth + hashtagPrefix.anchors.leftMargin + UI.Size.pixel2
                        rightPadding: UI.Size.pixel6
                        text: internal.color.toString().toUpperCase()
                        font.pixelSize: UI.Size.pixel16

                        onEditingFinished: internal.color = `#${text}`
                        onActiveFocusChanged: if (hexField.input.activeFocus) hexField.input.selectAll()
                    }

                    UI.Caption {
                        id: hashtagPrefix

                        anchors {
                            left: hexField.left; leftMargin: UI.Size.pixel15
                            verticalCenter: hexField.verticalCenter; verticalCenterOffset: hexField.height / 7
                        }

                        font: hexField.input.font
                        text: "#"
                    }

                    UI.Caption {
                        id: percentSuffix

                        anchors {
                            right: hexField.right; rightMargin: UI.Size.pixel15
                            verticalCenter: opacityInput.verticalCenter
                        }

                        font: hexField.input.font
                        text: "%"
                    }

                    TextInput {
                        id: opacityInput

                        anchors {
                            right: percentSuffix.left
                            rightMargin: 1
                            verticalCenter: hexField.verticalCenter; verticalCenterOffset: hashtagPrefix.anchors.verticalCenterOffset
                        }

                        height: hexField.height
                        width: UI.Size.pixel36
                        text: Math.round(internal.color.a * 100)

                        color: hexField.input.color
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                        font: hexField.input.font
                        selectByMouse: true
                        selectionColor: hexField.input.selectionColor

                        onEditingFinished: internal.color.a = (parseInt(opacityInput.text) / 100)
                        onActiveFocusChanged: if (activeFocus) opacityInput.selectAll()

                        validator: RegularExpressionValidator { // Allows for a number between 0 and 100, including the boundary values
                            regularExpression: /^(100|[1-9]?\d(\.\d{1,2})?)$/
                        }

                        Line {
                            anchors.verticalCenter: opacityInput.verticalCenter
                            height: opacityInput.height - UI.Size.pixel18
                            color: UI.Theme.action.selected
                        }
                    }
                }

                Media.Icon {
                    Layout.alignment: Qt.AlignBottom
                    Layout.bottomMargin: hexField.height / 10

                    size: UI.Size.pixel24
					color: UI.Theme.text.primary.toString()
                    interactive: true
                    iconData: Media.Icons.light.colorize
                    visible: Qt.platform.os === "windows"

                    onClicked: pickingAction.toggle()
                }
            }

            ColorSelection {
                id: history

                Layout.preferredHeight: history.count > 8 ? cellHeight * 2 : history.count === 0 ? 0 : cellHeight
                Layout.leftMargin: UI.Size.pixel4
                Layout.rightMargin: UI.Size.pixel4
                Layout.topMargin: root.padding / 2
                Layout.fillWidth: true

				model: Inputs.ColorHistoryModel

                parentBackgroundColor: root.background.color

                onDoubleClicked: (_color) => {
                                     root.currentColor = _color
                                     root.accept()
                                 }
                onClicked: (_color, _index, _mouseEvent) => {
                               if (_mouseEvent.button === Qt.LeftButton) {
                                   internal.color = _color
                               } else if (_mouseEvent.button === Qt.RightButton) {
                                   menu.parent = history.itemAtIndex(_index)
                                   menu.open()
                               }
                           }

                Behavior on Layout.preferredHeight {
                    NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
                }
            }

            Dialogs.Dialog.DialogButton {
                Layout.fillWidth: true
                Layout.topMargin: root.padding / 2

                text: qsTr("Accept")
                onClicked: root.accept()
            }
        }

        MMaterial.Menu {
            id: menu

            width: UI.Size.scale * 200
            x: UI.Size.pixel15
            y: UI.Size.pixel15

            MMaterial.MenuItem {
                text: qsTr("Delete")
                iconData: Media.Icons.light.deleteElement

                onTriggered: MMaterial.ColorHistoryModel.removeAt(history.currentIndex)
            }

            MMaterial.MenuItem {
                text: qsTr("Clear History")
                iconData: Media.Icons.light.refresh

                onTriggered: MMaterial.ColorHistoryModel.clear()
            }
        }
    }

    MMaterial.ColorPickerController {
        id: internal
    }
}


