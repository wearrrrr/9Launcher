pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.Media as Media
import MMaterial.Controls as Controls
import MMaterial.Controls.Inputs as Inputs

Dialogs.Dialog {
    id: root

    readonly property var startDate: calendar.beginDate
    readonly property var endDate: calendar.endDate

    readonly property string startDateString: calendar.dateFormater(startDate)
    readonly property string endDateString: calendar.dateFormater(endDate)

    property var yearSpan: (from, to, currentYear) => {
                               let years = [];
                               for (let year = from; year <= to; year++) {
                                   years.push(year);
                               }
                               return years;
                           }

    signal dateAccepted(var startDate, var endDate)

    implicitHeight: 504 * UI.Size.scale
    implicitWidth: 319 * UI.Size.scale

    contentItem: Item {
        id: dialogContentRoot

        UI.Overline {
            id: selectDateLabel

            anchors.top: dialogContentRoot.top
            width: dialogContentRoot.width

            text: qsTr("Select date")
            color: UI.Theme.text.secondary
        }

		UI.H4 {
            id: dateLabel

            width: dialogContentRoot.width
            maximumLineCount: 1
            text: root.startDateString === root.endDateString ? root.startDateString : root.startDateString + " - " + root.endDateString
            color: !root.startDate && !root.endDate ? UI.Theme.text.secondary : UI.Theme.text.primary

            font {
                bold: true
                pixelSize: UI.Size.pixel22
            }

            anchors {
                top: selectDateLabel.bottom; topMargin: UI.Size.pixel12
            }
        }

        RowLayout {
            id: controlsRow

            height: UI.Size.scale * 42
            width: dialogContentRoot.width

            anchors {
                top: dateLabel.bottom
            }

            UI.Subtitle1 {
                id: monthYearLabel

                Layout.fillHeight: true
                Layout.maximumHeight: UI.Size.scale * 56

                verticalAlignment: Qt.AlignVCenter

                text: {
                    let dateData = new Date(calendar.currentYear, calendar.currentMonth);
                    return qsTr("%1 %2").arg(calendar.monthName(dateData)).arg(calendar.currentYear)
                }
            }

            Media.Icon {
                id: yearDropdownIcon

                Layout.leftMargin: UI.Size.pixel6

                interactive: true
				color: UI.Theme.action.active.toString()
                iconData: Media.Icons.light.arrowDropDown
                size: UI.Size.pixel20

                onClicked: yearSelectionPopup.opened ? yearSelectionPopup.close() : yearSelectionPopup.open();

				Controls.Popup {
                    id: yearSelectionPopup

                    width: monthYearLabel.width + yearDropdownIcon.width + UI.Size.pixel12
                    height: 300 * UI.Size.scale

                    y: yearDropdownIcon.height

                    closePolicy: Popup.CloseOnPressOutsideParent

                    background: Rectangle {
                        radius: UI.Size.pixel10
                        implicitWidth:  UI.Size.scale * 420
                        implicitHeight: UI.Size.pixel36
                        color: UI.Theme.background.main
                        border.color:  UI.Theme.background.neutral
                    }

                    contentItem: Item {
                        id: contentItemRoot

                        ListView {
                            id: yearList

                            function positionIndex() {
                                yearList.currentIndex = yearList.model.indexOf(calendar.currentYear);
                                yearList.positionViewAtIndex(yearList.currentIndex, ListView.Center);
                            }

                            clip: true
                            highlightFollowsCurrentItem: true
                            highlightMoveDuration: 100
                            model: root.yearSpan(1900, 2100)

                            anchors {
                                fill: contentItemRoot
                                topMargin: UI.Size.pixel8
                                bottomMargin: UI.Size.pixel8
                            }

                            onModelChanged: yearList.positionIndex();
                            onVisibleChanged: if (visible) yearList.positionIndex();

                            delegate: Rectangle {
                                id: yearDelegate

                                required property int modelData
                                required property int index

                                readonly property int year: modelData
                                readonly property bool selected: yearList.currentIndex == index

                                width: yearList.width
                                height: yearDelegateLabel.contentHeight + UI.Size.pixel8

                                color: yearDelegate.selected ? UI.Theme.primary.lighter : "transparent"

                                UI.B1 {
                                    id: yearDelegateLabel

                                    text: yearDelegate.year
                                    opacity: yearDelegateMA.pressed ? 0.7 : (yearDelegateMA.containsMouse ? 0.85 : 1)
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                    color: yearDelegate.selected ? UI.Theme.primary.dark : UI.Theme.text.secondary

                                    anchors {
                                        fill: yearDelegate
                                        leftMargin: UI.Size.pixel8
                                        rightMargin: UI.Size.pixel8
                                    }
                                }

                                MouseArea {
                                    id: yearDelegateMA

                                    cursorShape: Qt.PointingHandCursor
                                    anchors.fill: yearDelegate
                                    hoverEnabled: true

                                    onClicked: {
                                        calendar.currentYear = yearDelegate.year;
                                        yearList.currentIndex = yearDelegate.index;
                                        yearSelectionPopup.close();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.fillWidth: true }

            Media.Icon {
                Layout.rightMargin: UI.Size.pixel30

                interactive: true
				color: UI.Theme.action.active.toString()
                iconData: Media.Icons.light.chevronLeft
                size: UI.Size.pixel24

                onClicked: calendar.previousMonth();
            }

            Media.Icon {
                interactive: true
				color: UI.Theme.action.active.toString()
                iconData: Media.Icons.light.chevronRight
                size: UI.Size.pixel24

                onClicked: calendar.nextMonth();
            }
        }

		Inputs.MCalendar {
            id: calendar

            width: dialogContentRoot.width

            anchors {
                top: controlsRow.bottom
                bottom: dialogContentRoot.bottom
            }
        }
    }

    Item { Layout.fillWidth: true }

    Dialogs.Dialog.DialogButton {
        text: qsTr("Cancel")
        type: Controls.MButton.Type.Text
        onClicked: root.close()
    }

    Dialogs.Dialog.DialogButton {
        text: qsTr("OK")
        type: Controls.MButton.Type.Text
        onClicked: root.dateAccepted(root.startDate, root.endDate);

    }
}
