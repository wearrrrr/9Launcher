import QtQuick
import QtCore
import QtQuick.Layouts
import QtQuick.Dialogs

import MMaterial.UI as UI
import MMaterial.Media as Media
import MMaterial.Controls as Controls

Item {
    id: control

	readonly property bool isEmpty: image.source.toString() === "" || removeImageAnimation.running
    readonly property url source: image.source

	property alias radius: image.radius

    property real size: UI.Size.scale * 128
    property alias background: background
	property color textColor: control.isEmpty ? UI.Theme.text.disabled : UI.Theme.common.white
	property list<string> acceptedFileTypes: ["jpg", "jpeg", "png", "svg"]
	property int progress: 100

	signal imageRejected
	signal imageAccepted(source : url)

    function removeImage() {
        removeImageAnimation.start();
    }

	function setSource(newSource) {
		image.source = newSource
	}

    implicitHeight: control.size
    implicitWidth: control.size

    QtObject {
        id: d

        property url imageSource: ""
		property bool isUploading: control.progress < 100 && imageSource.toString() !== ""

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

		nameFilters: ["Images (*." + acceptedFileTypes.join(" *.") + ")"]
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: {
            d.imageSource = selectedFile;
            imageAnimation.start();
			control.imageAccepted(control.source)
        }
    }

    Media.Icon {
        id: dash

        anchors.fill: control
        size: control.height

        iconData: Media.Icons.heavy.dashedCircle
		color: UI.Theme.main.transparent.p32.toString()

        Rectangle {
            id: background

            color: UI.Theme.background.neutral
			radius: image.radius
            opacity: tap.pressed ? 0.6 : (hoverHandler.hovered ? 0.8 : 1)

            Behavior on opacity { NumberAnimation { duration: 50 } }

            anchors {
                fill: dash
                margins: UI.Size.pixel8
            }
        }

		Controls.MaskedImage {
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
			color: UI.Theme.main.p900
			opacity: (hoverHandler.hovered && !control.isEmpty && !imageAnimation.running) || d.isUploading ? (tap.pressed ? 0.4 :  0.64) : 0
            radius: background.radius

            Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
        }

        ColumnLayout {
            anchors.fill: background
            spacing: UI.Size.pixel8
			opacity: ((hoverHandler.hovered && !control.isEmpty) || control.isEmpty || d.isUploading) && !imageAnimation.running ? 1 : 0
            visible: opacity > 0

            Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

            Item { Layout.fillHeight: true }

            Media.Icon {
                Layout.alignment: Qt.AlignHCenter
                size: UI.Size.pixel24
				color: control.textColor.toString()
				iconData: d.isUploading ? Media.Icons.light.uploadFile : Media.Icons.light.addAPhoto
            }

			UI.Caption {
				text: d.isUploading ? control.progress + qsTr("% Uploaded") : (control.isEmpty ? qsTr("Upload photo") : qsTr("Update photo"))
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

			cursorShape: Qt.PointingHandCursor
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
							   const urlStr = url.toString().toLowerCase();

							   if (control.acceptedFileTypes.some(ext => urlStr.endsWith("." + ext))) {
								   d.imageSource = url;
								   imageAnimation.start();
								   control.imageAccepted(control.source)
							   }
							   else {
								   control.imageRejected();
							   }
                           }
                       }
                   }
    }
}
