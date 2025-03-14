pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls.Dialogs as Dialogs
import MMaterial.Controls as Controls

Dialogs.Dialog {
    id: root

    component AmPmSwitch: ColumnLayout {
        id: switchRoot

        property bool isAM: true

		UI.Subtitle1 {
            id: amLabel
            text: qsTr("AM")
            color: switchRoot.isAM ? UI.Theme.text.primary : UI.Theme.text.secondary
            opacity: amLabelMA.pressed ? 0.8 : 1

            MouseArea {
                id: amLabelMA

                anchors.fill: amLabel
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: switchRoot.isAM = true
            }
        }

		UI.Subtitle1 {
            id: pmLabel
            text: qsTr("PM")
            color: !switchRoot.isAM ? UI.Theme.text.primary : UI.Theme.text.secondary
            opacity: pmLabelMA.pressed ? 0.8 : 1

            MouseArea {
                id: pmLabelMA

                anchors.fill: pmLabel
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: switchRoot.isAM = false
            }
        }
    }

    component TimePresenter: RowLayout {
        id: timePresenter

        property bool isEditingHours: true
        property string hours: ""
        property string minutes: ""

        spacing: 0

		UI.H3 {
            id: hoursLabel

            text: timePresenter.hours + ":"
            color: timePresenter.isEditingHours ? UI.Theme.text.primary : UI.Theme.text.secondary
            font.bold: true
            opacity: hoursLabelMA.pressed ? 0.8 : 1

            MouseArea {
                id: hoursLabelMA

                anchors.fill: hoursLabel
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: timePresenter.isEditingHours = true
            }
        }

		UI.H3 {
            id: minutesLabel

            text: timePresenter.minutes
            color: !timePresenter.isEditingHours ? UI.Theme.text.primary : UI.Theme.text.secondary
            font.bold: true
            opacity: minutesLabelMA.pressed ? 0.8 : 1

            MouseArea {
                id: minutesLabelMA

                anchors.fill: minutesLabel
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: timePresenter.isEditingHours = false
            }
        }

        Item { Layout.fillWidth: true }
    }

    signal timeAccepted(date : var)

    function formatTime(date) {
        let hours = date.getHours();
        let minutes = date.getMinutes();

        // Ensure two digits for both hours and minutes
        let formattedHours = hours.toString().padStart(2, '0');
        let formattedMinutes = minutes.toString().padStart(2, '0');

        return `${formattedHours}:${formattedMinutes}`;
    }

    implicitHeight: 434 * UI.Size.scale
    implicitWidth: 320 * UI.Size.scale

    contentItem: ColumnLayout {
		UI.Overline {
            Layout.fillWidth: true

            text: qsTr("Select time")
            color: UI.Theme.text.secondary
        }

        RowLayout {
            Layout.preferredHeight: UI.Size.pixel48

            TimePresenter {
                id: timePresentation

                Layout.preferredWidth: UI.Size.scale * 90
                Layout.maximumWidth: UI.Size.scale * 90

                onIsEditingHoursChanged: {
                    secondHandAnimation.to = timePresentation.isEditingHours ? d.hourToAngle(parseInt(timePresentation.hours)) : d.minuteToAngle(parseInt(timePresentation.minutes));
                    secondRotation.shouldUpdateAngle = false;
                    secondHandAnimation.restart();
                }

                Component.onCompleted: {
                    timePresentation.hours = d.angleToHourString(secondRotation.angle)
                    timePresentation.minutes = d.angleToMinuteString(secondRotation.angle)
                }
            }

            AmPmSwitch {
                id: amPmPresentation

                Layout.maximumHeight: timePresentation.height
            }
        }

        Rectangle {
            id: clockFace

            property real clockNumbersMargin: UI.Size.scale * 18
            property alias hand: secondHand

            Layout.fillWidth: true
            Layout.preferredHeight: width
            Layout.topMargin: UI.Size.pixel32
            Layout.margins: UI.Size.pixel13 * 2

            radius: height / 2
            color: UI.Theme.action.disabledBackground

            Rectangle {
                id: secondHand

                width: 1.69 * UI.Size.scale
                height: clockFace.width / 2 - (UI.Size.pixel36 - (bigDot.height))

                color: UI.Theme.primary.main
                antialiasing: true

                anchors {
                    centerIn: parent
                    verticalCenterOffset: -height / 2
                }

                transform: Rotation {
                    id: secondRotation

                    property bool shouldUpdateAngle: true

                    origin.x: secondHand.width / 2
                    origin.y: secondHand.height
                    angle: 0

                    onAngleChanged: if (secondRotation.shouldUpdateAngle) d.setTimePresentation(angle);

                    NumberAnimation on angle { id: secondHandAnimation; duration: 250; easing.type: Easing.InOutQuad; onStopped: secondRotation.shouldUpdateAngle = true }
                }

                Rectangle {
                    height: UI.Size.pixel6
                    width: height
                    radius: height / 2
                    color: secondHand.color

                    anchors {
                        top: secondHand.bottom
                        topMargin: -height / 2
                        horizontalCenter: secondHand.horizontalCenter
                    }
                }

                Rectangle {
                    id: bigDot

                    readonly property bool isEnlarged:
                        (numberRepeater.showHours ? secondRotation.angle % 30 <= 5 : d.currentMinute % 5 == 0)
                        && !secondHandAnimation.running

                    height: bigDot.isEnlarged ? UI.Size.pixel36 : 0
                    width: height

                    radius: height / 2
                    color: secondHand.color

                    anchors {
                        top: secondHand.top
                        horizontalCenter: secondHand.horizontalCenter
                    }

                    Behavior on height { NumberAnimation { duration: 80 } }
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent

                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onPositionChanged: (mouse) => {
                                       if (!mouseArea.pressed || mouseTimer.running)
                                       return;

                                       secondRotation.angle = d.getHandlePosition(mouse);
                                   }

                onClicked: (mouse) => {
                               let positionAngle = d.getHandlePosition(mouse);

                               if (numberRepeater.showHours) {
                                   let rest = positionAngle % 30;
                                   if (rest < 15)
                                   positionAngle -= rest;
                                   else
                                   positionAngle += 30 - rest;
                               }

                               secondHandAnimation.to = positionAngle;

                               if (positionAngle !== secondRotation.angle)
                               secondHandAnimation.restart();
                           }

                Timer {
                    id: mouseTimer
                    running: mouseArea.pressed
                    repeat: false
                    interval: 80
                }
            }

            Repeater {
                id: numberRepeater

                property real delegateOpacity: 1
                property real marginFactor: 0
                property bool showHours: true

                model: [
                    {"hour": 12, "minute": 0},
                    {"hour": 1, "minute": 5},
                    {"hour": 2, "minute": 10},
                    {"hour": 3, "minute": 15},
                    {"hour": 4, "minute": 20},
                    {"hour": 5, "minute": 25},
                    {"hour": 6, "minute": 30},
                    {"hour": 7, "minute": 35},
                    {"hour": 8, "minute": 40},
                    {"hour": 9, "minute": 45},
                    {"hour": 10, "minute": 50},
                    {"hour": 11, "minute": 55}
                ]

                state: "hours"
                states: [
                    State {
                        name: "hours"
                        when: timePresentation.isEditingHours

                        PropertyChanges {
                            target: numberRepeater
                            showHours: true
                        }
                    },
                    State {
                        name: "minutes"
                        when: true

                        PropertyChanges {
                            target: numberRepeater
                            showHours: false

                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "*"
                        SequentialAnimation {
                            ParallelAnimation {
                                NumberAnimation { target: numberRepeater; property: "marginFactor"; to: UI.Size.pixel16; duration: 125; easing.type: Easing.InQuad }
                                NumberAnimation { target: numberRepeater; property: "delegateOpacity"; to: 0; duration: 125; easing.type: Easing.InQuad }
                            }

                            PropertyAnimation { target: numberRepeater; property: "showHours"; duration: 0 }

                            ParallelAnimation {
                                NumberAnimation { target: numberRepeater; property: "marginFactor"; to: 0; duration: 125; easing.type: Easing.OutQuad }
                                NumberAnimation { target: numberRepeater; property: "delegateOpacity"; to: 1; duration: 125; easing.type: Easing.OutQuad }
                            }
                        }
                    }
                ]

				delegate: UI.B1 {
                    id: numberDelegate

                    required property var modelData
                    required property int index

                    text: numberRepeater.showHours ? modelData.hour : modelData.minute
                    opacity: numberRepeater.delegateOpacity
                    color: (numberRepeater.showHours ? d.currentHour === modelData.hour : d.currentMinute === modelData.minute) && bigDot.isEnlarged
                           ? UI.Theme.primary.lighter
                           : UI.Theme.text.primary;

                    x: clockFace.width / 2 + Math.cos(Math.PI / 6 * index - Math.PI / 2) * (clockFace.width / 2 - clockFace.clockNumbersMargin - numberRepeater.marginFactor) - width / 2
                    y: clockFace.height / 2 + Math.sin(Math.PI / 6 * index - Math.PI / 2) * (clockFace.height / 2 - clockFace.clockNumbersMargin - numberRepeater.marginFactor) - height / 3

                    TapHandler {
                        cursorShape: Qt.PointingHandCursor
                        onTapped: {
                            if (numberRepeater.showHours)
                                secondHandAnimation.to = d.hourToAngle(numberDelegate.modelData.hour);
                            else
                                secondHandAnimation.to = d.minuteToAngle(modelData.minute);

                            secondHandAnimation.restart();
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
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
        onClicked: {
            let date = new Date();
            date.setHours(amPmPresentation.isAM ? d.currentHour : d.currentHour + 12);
            date.setMinutes(d.currentMinute);

            root.timeAccepted(date);
        }
    }

    QtObject {
        id: d

        property int currentMinute: 0
        property int currentHour: 12

        function setTimePresentation(angle) {
            if (timePresentation.isEditingHours)
                timePresentation.hours = d.angleToHourString(secondRotation.angle)
            else
                timePresentation.minutes = d.angleToMinuteString(secondRotation.angle)
        }

        function getHandlePosition(mouse) {
            const centerX = clockFace.width / 2;
            const centerY = clockFace.height / 2;
            const dx = mouse.x - centerX;
            const dy = mouse.y - centerY;
            let angle = Math.atan2(dy, dx) * (180 / Math.PI) + 90;
            if (angle < 0) {
                angle += 360;
            }
            return Math.round(angle);
        }

        function hourToAngle(hour) {
            if (hour > 12)
                hour -= 12;

            d.currentHour = hour;
            return hour * 30;
        }

        function minuteToAngle(minute) {
            d.currentMinute = minute;
            return minute * 6;
        }

        function angleToHour(angle) {
            let normalizedAngle = angle % 360;
            if (normalizedAngle < 0) {
                normalizedAngle += 360;
            }

            let hour = Math.floor(normalizedAngle / 30);
            if (hour > 12) {
                hour -= 12;
            }

            d.currentHour = hour == 0 ? 12 : hour;

            return hour;
        }

        function angleToHourString(angle) {
            let hour = angleToHour(angle);
            if (hour === 0)
                hour = 12;

            return hour.toString();
        }

        function angleToMinute(angle) {
            let normalizedAngle = angle % 360;
            if (normalizedAngle < 0) {
                normalizedAngle += 360;
            }

            normalizedAngle = (normalizedAngle + 3) % 360;
            let minute = Math.floor((normalizedAngle / 6)) % 60;

            d.currentMinute = minute;

            return minute;
        }

        function angleToMinuteString(angle) {
            let minute = angleToMinute(angle);
            return minute.toString().padStart(2, "0");
        }
    }
}
