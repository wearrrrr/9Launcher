import QtQuick
import QtCore
import QtQuick.Layouts
import QtQuick.Dialogs

import MMaterial as MMaterial

Item {
    id: control

    readonly property bool isEmpty: image.source.toString() === ""
    readonly property url source: image.source

    property real size: MMaterial.Size.scale * 128
    property alias background: background
    property color textColor: control.isEmpty ? MMaterial.Theme.text.disabled : MMaterial.Theme.common.white

    function removeImage() {
        removeImageAnimation.start();
    }

    implicitHeight: control.size
    implicitWidth: control.size

    QtObject {
        id: d

        property url imageSource: ""

        function addImage() {
            image.source = d.imageSource
        }

        function removeImage() {
            image.source = ""
            d.imageSource = ""
        }
    }

    FileDialog {
        id: fileDialog

        nameFilters: ["Images (*.jpg *.jpeg *.png *.svg)"]
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: {
            d.imageSource = selectedFile;
            imageAnimation.start();
        }
    }

    MMaterial.Icon {
        id: dash

        anchors.fill: control
        size: control.height

        iconData: MMaterial.Icons.heavy.dashedCircle
        color: MMaterial.Theme.main.transparent.p32

        Rectangle {
            id: background

            color: MMaterial.Theme.background.neutral
            radius: control.height / 2
            opacity: tap.pressed ? 0.6 : (hoverHandler.hovered ? 0.8 : 1)

            Behavior on opacity { NumberAnimation { duration: 50 } }

            anchors {
                fill: dash
                margins: MMaterial.Size.pixel8
            }
        }

        MMaterial.MaskedImage {
            id: image

            anchors.fill: background
            fillMode: Image.PreserveAspectCrop
            visible: !control.isEmpty

            ParallelAnimation {
                id: imageAnimation

                NumberAnimation { target: image; property: "opacity"; from: 0; to: 1; duration: 350; easing.type: Easing.InQuad }
                NumberAnimation { target: image; property: "scale"; from: 2.2; to: 1; duration: 650; easing.type: Easing.OutBack }
                ScriptAction { script: d.addImage() }
            }

            SequentialAnimation {
                id: removeImageAnimation

                ParallelAnimation {
                    NumberAnimation { target: image; property: "opacity"; from: 1; to: 0; duration: 350; easing.type: Easing.OutQuad }
                    NumberAnimation { target: image; property: "scale"; from: 1; to: 1.5; duration: 650; easing.type: Easing.OutQuad }
                }
                ScriptAction { script: d.removeImage() }
            }
        }

        Rectangle {
            id: overlay

            anchors.fill: background
            visible: opacity > 0
            color: MMaterial.Theme.main.p900
            opacity: hoverHandler.hovered && !control.isEmpty && !imageAnimation.running ? (tap.pressed ? 0.4 :  0.64) : 0
            radius: background.radius

            Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
        }

        ColumnLayout {
            anchors.fill: background
            spacing: MMaterial.Size.pixel8
            opacity: ((hoverHandler.hovered && !control.isEmpty) || control.isEmpty) && !imageAnimation.running ? 1 : 0
            visible: opacity > 0

            Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

            Item { Layout.fillHeight: true }

            MMaterial.Icon {
                Layout.alignment: Qt.AlignHCenter
                size: MMaterial.Size.pixel24
                color: control.textColor
                iconData: MMaterial.Icons.light.addAPhoto
            }

            MMaterial.Caption {
                text: control.isEmpty ? qsTr("Upload photo") : qsTr("Update photo")
                color: control.textColor
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }

            Item { Layout.fillHeight: true }
        }

        TapHandler {
            id: tap

            onTapped: fileDialog.open()
        }

        HoverHandler {
            id: hoverHandler
        }
    }

    DropArea {
        anchors.fill: control

        onEntered: (dragEvent) => {
                       dragEvent.acceptProposedAction()
                   }

        onDropped: (dragEvent) => {
                       if (dragEvent.hasUrls) {
                           for (var i = 0; i < dragEvent.urls.length; ++i) {
                               var url = dragEvent.urls[i];
                               if (url.toString().toLowerCase().endsWith(".png") ||
                                   url.toString().toLowerCase().endsWith(".jpg") ||
                                   url.toString().toLowerCase().endsWith(".jpeg")) {
                                   d.imageSource = url;  // Set the source of the Image element
                                   imageAnimation.start();
                               }
                           }
                       }
                   }
    }
}
