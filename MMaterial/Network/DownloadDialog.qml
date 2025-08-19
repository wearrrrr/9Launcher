pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import MMaterial.Media as Media
import MMaterial.UI as UI
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.Controls as Controls
import MMaterial.Network as Network

Dialogs.Dialog {
	id: root

	property bool pauseOnClosed: false

	property alias downloadModel: downloadModel

	closePolicy: Dialogs.Dialog.NoAutoClose
	implicitWidth: 350 * UI.Size.scale
	iconData: Media.Icons.light.download
	title: qsTr("Downloads")
	contentHeight: Math.min(Math.max(downloadList.contentHeight, downloadList.delHeight), (downloadList.delHeight + downloadList.spacing) * 5)

	onAboutToHide: {
		if (pauseOnClosed) {
			downloadModel.pauseRunning()
		}
	}

	contentItem: Rectangle {
		id: contentRoot

		color: "transparent"

		ListView {
			id: downloadList

			readonly property real delHeight: 78 * UI.Size.scale

			anchors.fill: contentRoot
			spacing: UI.Size.pixel8
			interactive: false

			Behavior on height { UI.EasedAnimation {} }

			add: Transition {
				ParallelAnimation {
					UI.EasedAnimation { properties: "height"; from: 0; to: downloadList.delHeight; duration: 200; }
					UI.EasedAnimation { properties: "opacity"; from: 0; to: 1; duration: 400; }
				}
			}

			displaced: Transition {
				UI.EasedAnimation { properties: "x, y, scale, opacity, height"; duration: 150; }
			}

			model: Network.DownloadModel {
				id: downloadModel
			}

			delegate: Rectangle {
				id: delRoot

				required property int progress
				required property int status
				required property string fileName
				required property string fileFullName
				required property string fileSize
				required property string fileDownloadedSize
				required property url url
				required property int index

				property UI.PaletteBasic accent: UI.Theme.success

				height: downloadList.delHeight
				width: downloadList.width
				color: UI.Theme.background.neutral
				radius: UI.Size.pixel12

				border {
					width: 0
					color: UI.Theme.other.outline
				}

				state: "downloading"
				states: [
					State {
						when: delRoot.status == Network.Download.Downloading || delRoot.status == Network.Download.Idle
						name: "downloading"
						PropertyChanges { target: delRoot; accent: UI.Theme.primary }
						PropertyChanges { target: downloadIcon; icon.iconData: Media.Icons.light.playArrow; onClicked: { downloadModel.pauseDownload(delRoot.index) } }
					},
					State {
						when: delRoot.status == Network.Download.Finished
						name: "downloaded"
						PropertyChanges { target: delRoot; accent: UI.Theme.success }
						PropertyChanges { target: downloadIcon; icon.iconData: Media.Icons.light.check; onClicked: {} }
					},
					State {
						when: delRoot.status == Network.Download.Error
						name: "failed"
						PropertyChanges { target: delRoot; accent: UI.Theme.error }
						PropertyChanges { target: downloadIcon; icon.iconData: Media.Icons.light.restartAlt; onClicked: { downloadModel.startDownload(delRoot.index) } }
					},
					State {
						when: delRoot.status == Network.Download.Retrying
						name: "retrying"
						PropertyChanges { target: delRoot; accent: UI.Theme.error }
						PropertyChanges { target: downloadIcon; icon.iconData: Media.Icons.light.restartAlt; onClicked: {} }
					},
					State {
						when: delRoot.status == Network.Download.Paused
						name: "paused"
						PropertyChanges { target: delRoot; accent: UI.Theme.warning }
						PropertyChanges { target: downloadIcon; checked: false; icon.iconData: Media.Icons.light.pause; onClicked: { downloadModel.startDownload(delRoot.index) } }
					}
				]

				transitions: [
					Transition {
						from: "failed"
						to: "retrying"

						RotationAnimation { target: downloadIcon.icon; properties: "rotation"; from: 360; to: 0; duration: 1300; loops: Animation.Infinite; easing.type: Easing.InOutQuad }
					},
					Transition {
						from: "retrying"
						to: "*"
						RotationAnimation { target: downloadIcon.icon; properties: "rotation"; to: 0; duration: 500; easing.type: Easing.InOutQuad }
					},
					Transition {
						SequentialAnimation {
							PropertyAnimation { target: downloadIcon.icon; properties: "scale"; to: 0; duration: 300; easing.type: Easing.InQuad }
							PropertyAction { target: downloadIcon.icon; properties: "iconData" }
							PropertyAction { target: delRoot; properties: "accent" }
							PropertyAnimation { target: downloadIcon.icon; properties: "scale"; to: 1; duration: 300; easing.type: Easing.OutQuad }
						}
					}
				]

				SequentialAnimation {
					id: removeAnimation

					ParallelAnimation {
						UI.EasedAnimation { target: delRoot; properties: "height"; to: 0; duration: 400; }
						UI.EasedAnimation { target: delRoot; properties: "opacity"; to: 0; duration: 200; }
					}
					ScriptAction { script: { downloadModel.removeDownload(delRoot.index) } }
				}

				Media.Icon {
					iconData: Media.Icons.light.close
					size: UI.Size.pixel12
					interactive: true
					enabled: !removeAnimation.running

					anchors {
						right: delRoot.right
						top: delRoot.top
						margins: UI.Size.pixel6
					}

					onClicked: removeAnimation.start()
				}

				Item {
					id: delContainer

					anchors {
						fill: delRoot
						margins: UI.Size.pixel12
						bottomMargin: UI.Size.pixel10
					}

					RowLayout {
						width: delContainer.width

						Controls.MToggleButton {
							id: downloadIcon

							checked: true
							customCheckImplementation: true
							size: UI.Size.Grade.S
							accent: delRoot.accent

							icon {
								iconData: Media.Icons.light.download
								rotation: 0
							}

							Behavior on color { ColorAnimation { duration: 250 } }
							Behavior on border.color { ColorAnimation { duration: 250 } }
							Behavior on icon.color { ColorAnimation { duration: 250 } }
						}

						Controls.MToggleButton {
							id: openFolderButton

							Layout.preferredWidth: implicitWidth * scale

							checked: false
							customCheckImplementation: true
							size: UI.Size.Grade.S
							visible: scale > 0
							scale: delRoot.state === "downloaded"

							icon {
								iconData: Media.Icons.light.openInNew
								rotation: 0
							}

							onClicked: Qt.openUrlExternally(delRoot.fileFullName)

							Behavior on scale { UI.EasedAnimation { duration: 400 } }

							Controls.MToolTip {
								visible: openFolderButton.mouseArea.containsMouse
								text: delRoot.fileFullName
								delay: 500
							}
						}

						ColumnLayout {
							id: textLayout

							spacing: 0

							Layout.leftMargin: UI.Size.pixel8

							UI.B1 {
								Layout.fillWidth: true
								maximumLineCount: 1
								color: UI.Theme.text.primary
								text: delRoot.fileName
								font.pixelSize: UI.Size.pixel14
								elide: Text.ElideLeft
								wrapMode: Text.NoWrap
							}

							UI.B2 {
								Layout.fillWidth: true
								maximumLineCount: 1
								color: UI.Theme.text.secondary
								text: delRoot.fileSize
								font.pixelSize: UI.Size.pixel10
								wrapMode: Text.NoWrap
							}
						}
					}

					Controls.MProgressBar{
						anchors {
							bottom: delContainer.bottom
						}

						width: delContainer.width
						progress: delRoot.progress
						showLabel: true
						accent: delRoot.accent

						Behavior on backgroundColor { ColorAnimation { duration: 250 } }
						Behavior on foregroundColor { ColorAnimation { duration: 250 } }
					}
				}

			}
		}
	}


	Dialogs.Dialog.DialogCloseButton {
		Layout.fillWidth: true
		accent: downloadModel.isRunning ? UI.Theme.error : UI.Theme.defaultNeutral
		text: qsTr("Close")
		onClicked: root.close()

	}
}
