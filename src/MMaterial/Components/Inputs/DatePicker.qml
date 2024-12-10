import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial as MMaterial
import QtQuick.Templates as T

MMaterial.Dialog {
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

    implicitHeight: 504 * MMaterial.Size.scale
    implicitWidth: 319 * MMaterial.Size.scale

    contentItem: Item {
        id: dialogContentRoot

        MMaterial.Overline {
            id: selectDateLabel

            anchors.top: dialogContentRoot.top
            width: dialogContentRoot.width

            text: qsTr("Select date")
            color: MMaterial.Theme.text.secondary
        }

        MMaterial.H4 {
            id: dateLabel

            width: dialogContentRoot.width
            maximumLineCount: 1
            text: root.startDateString === root.endDateString ? root.startDateString : root.startDateString + " - " + root.endDateString
            color: !root.startDate && !root.endDate ? MMaterial.Theme.text.secondary : MMaterial.Theme.text.primary

            font {
                bold: true
                pixelSize: MMaterial.Size.pixel22
            }

            anchors {
                top: selectDateLabel.bottom; topMargin: MMaterial.Size.pixel12
            }
        }

        RowLayout {
            id: controlsRow

            height: MMaterial.Size.scale * 42
            width: dialogContentRoot.width

            anchors {
                top: dateLabel.bottom
            }

            MMaterial.Subtitle1 {
                id: monthYearLabel

                Layout.fillHeight: true
                Layout.maximumHeight: MMaterial.Size.scale * 56

                verticalAlignment: Qt.AlignVCenter

                text: {
                    let dateData = new Date(calendar.currentYear, calendar.currentMonth);
                    return qsTr("%1 %2").arg(calendar.monthName(dateData)).arg(calendar.currentYear)
                }
            }

            MMaterial.Icon {
                id: yearDropdownIcon

                Layout.leftMargin: MMaterial.Size.pixel6

                interactive: true
                color: MMaterial.Theme.action.active
                iconData: MMaterial.Icons.light.arrowDropDown
                size: MMaterial.Size.pixel20

                onClicked: yearSelectionPopup.opened ? yearSelectionPopup.close() : yearSelectionPopup.open();

                MMaterial.Popup {
                    id: yearSelectionPopup

                    width: monthYearLabel.width + yearDropdownIcon.width + MMaterial.Size.pixel12
                    height: 300 * MMaterial.Size.scale

                    y: yearDropdownIcon.height

                    closePolicy: Popup.CloseOnPressOutsideParent

                    background: Rectangle {
                        radius: MMaterial.Size.pixel10
                        implicitWidth:  MMaterial.Size.scale * 420
                        implicitHeight: MMaterial.Size.pixel36
                        color: MMaterial.Theme.background.main
                        border.color:  MMaterial.Theme.background.neutral
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
                                topMargin: MMaterial.Size.pixel8
                                bottomMargin: MMaterial.Size.pixel8
                            }

                            onModelChanged: yearList.positionIndex();
                            onVisibleChanged: if (visible) yearList.positionIndex();

                            delegate: Rectangle {
                                id: yearDelegate

                                readonly property int year: modelData
                                readonly property bool selected: yearList.currentIndex == index

                                width: yearList.width
                                height: yearDelegateLabel.contentHeight + MMaterial.Size.pixel8

                                color: yearDelegate.selected ? MMaterial.Theme.primary.lighter : "transparent"

                                MMaterial.B1 {
                                    id: yearDelegateLabel

                                    text: yearDelegate.year
                                    opacity: yearDelegateMA.pressed ? 0.7 : (yearDelegateMA.containsMouse ? 0.85 : 1)
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                    color: yearDelegate.selected ? MMaterial.Theme.primary.dark : MMaterial.Theme.text.secondary

                                    anchors {
                                        fill: yearDelegate
                                        leftMargin: MMaterial.Size.pixel8
                                        rightMargin: MMaterial.Size.pixel8
                                    }
                                }

                                MouseArea {
                                    id: yearDelegateMA

                                    cursorShape: Qt.PointingHandCursor
                                    anchors.fill: yearDelegate
                                    hoverEnabled: true

                                    onClicked: {
                                        calendar.currentYear = year;
                                        yearList.currentIndex = index;
                                        yearSelectionPopup.close();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.fillWidth: true }

            MMaterial.Icon {
                Layout.rightMargin: MMaterial.Size.pixel30

                interactive: true
                color: MMaterial.Theme.action.active
                iconData: MMaterial.Icons.light.chevronLeft
                size: MMaterial.Size.pixel24

                onClicked: calendar.previousMonth();
            }

            MMaterial.Icon {
                interactive: true
                color: MMaterial.Theme.action.active
                iconData: MMaterial.Icons.light.chevronRight
                size: MMaterial.Size.pixel24

                onClicked: calendar.nextMonth();
            }
        }

        MMaterial.MCalendar {
            id: calendar

            width: dialogContentRoot.width

            anchors {
                top: controlsRow.bottom
                bottom: dialogContentRoot.bottom
            }
        }
    }

    Item { Layout.fillWidth: true }

    MMaterial.Dialog.DialogButton {
        text: qsTr("Cancel")
        type: MMaterial.MButton.Type.Text
        onClicked: root.close()
    }

    MMaterial.Dialog.DialogButton {
        text: qsTr("OK")
        type: MMaterial.MButton.Type.Text
        onClicked: root.dateAccepted(root.startDate, root.endDate);

    }
}
