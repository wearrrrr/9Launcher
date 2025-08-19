pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Charts as Charts
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Item {
    id: root

    property alias descriptionWidth: valueList.width
    property alias chartList: chartList

    property bool showLockButton: true
    property real spacing: UI.Size.pixel12
    property real barWidth: UI.Size.pixel6
    property real fontSize: UI.Size.pixel12

	property UI.PaletteBasic positiveAccent: UI.Theme.success
	property UI.PaletteBasic negativeAccent: UI.Theme.error

    property Charts.ChartElement chartModel: Charts.ChartElement {
        bars: [
            Charts.ChartElementBar { value: -100; name: qsTr("January") },
            Charts.ChartElementBar { value: 1800; name: qsTr("February") },
            Charts.ChartElementBar { value: 3000; name: qsTr("March") },
            Charts.ChartElementBar { value: 2700; name: qsTr("April") }
        ]
    }

    component VerticalBar: Item {
        id: verticalBarContainer

        required property double barValue
        required property bool barSelected
        required property int index
		required property var model

        property alias barOpacity: verticalBar.opacity

        property real contentX: 0
        property double previousBarValue: 0

        readonly property double totalValue: barValue - previousBarValue
        readonly property double totalValueAbs: Math.abs(totalValue)
        readonly property bool trueVisible: x + width > chartList.contentX && x < chartList.contentX + chartList.width

        readonly property double previousBarHeight: index == 0 ? 0 : calculateBarHeight(previousBarValue)
        readonly property double currentBarHeight: verticalBarContainer.calculateBarHeight(verticalBarContainer.totalValueAbs)

        function calculateBarHeight(value) {
            const totalRange = d.peakRange + Math.abs(d.troughRange)
            const normalizedValue = value / totalRange

            return height * normalizedValue
        }

        Rectangle {
            id: verticalBar

            readonly property real prefHeight: Math.max(verticalBarContainer.currentBarHeight, 1)
            readonly property bool isNegative: verticalBarContainer.totalValue < 0

            width: verticalBarContainer.width - root.spacing / 2
            height: verticalBar.prefHeight
            radius: UI.Size.pixel12
            color: verticalBar.isNegative ? root.negativeAccent.main : root.positiveAccent.main

            anchors {
                right: verticalBarContainer.right
                bottom: verticalBarContainer.bottom
                bottomMargin: {
                    let result = 0
                    if (verticalBar.isNegative)
                        result = (verticalBarContainer.previousBarHeight - verticalBarContainer.currentBarHeight)
                    else
                        result = verticalBarContainer.previousBarHeight

                    const totalRange = d.peakRange + Math.abs(d.troughRange)

                    return result + verticalBarContainer.calculateBarHeight(Math.abs(d.troughRange))
                }
            }

            border {
                width: delHover.hovered || verticalBarContainer.barSelected ? UI.Size.pixel1 * 2 : 0
                color: Qt.lighter(verticalBar.color)
            }

            Behavior on border.width { NumberAnimation { duration: 50; easing.type: Easing.OutQuad } }
            Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }

            HoverHandler {
                id: delHover
            }

            TapHandler {
                onTapped: {
                    d.autoscroll = false;
					verticalBarContainer.model.barSelected = !verticalBarContainer.barSelected;
                }
            }

			Controls.MToolTip {
                id: tooltip

                property UI.PaletteBasic accent: verticalBar.isNegative ? root.negativeAccent : root.positiveAccent

                x: verticalBar.x
                closePolicy: Popup.NoAutoClose

                height: 87 * UI.Size.scale
                width: 210 * UI.Size.scale

                margins: 0
                topPadding: UI.Size.pixel12
                bottomPadding: UI.Size.pixel12
                leftPadding: UI.Size.pixel12
                rightPadding: UI.Size.pixel12

                delay: 0
                visible: delHover.hovered || (verticalBarContainer.barSelected && verticalBarContainer.trueVisible)

                enter: Transition {
                    SequentialAnimation {
                        PropertyAction { property: "contentItem.textLayout.opacity"; value: 0.0 }

                        ParallelAnimation {
                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutQuad; duration: 340 }
                            NumberAnimation { property: "width"; from: 0.0; to: 210 * UI.Size.scale; easing.type: Easing.OutQuad; duration: 340 }
                            SequentialAnimation {
                                PauseAnimation { duration: 150 }
                                NumberAnimation { property: "contentItem.textLayout.opacity"; from: 0.0; to: 1.0; duration: 190 }
                            }
                        }
                    }

                }

                exit: Transition {
                    ParallelAnimation {
                        NumberAnimation { property: "contentItem.textLayout.opacity"; to: 0; duration: 190 }
                        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.InQuad; duration: 340 }
                        NumberAnimation { property: "width"; to: 0; easing.type: Easing.InQuad; duration: 340 }
                    }
                }

                background: Rectangle {
                    radius: UI.Size.pixel20
                    color: tooltip.accent.lighter
                    opacity: 0.8
                }

                contentItem:  RowLayout {
                    spacing: UI.Size.pixel24

                    property alias textLayout: textLayout

                    Rectangle {
                        id: tooltipIconContainer

                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.maximumHeight: tooltip.height - tooltip.topPadding - tooltip.bottomPadding
                        Layout.preferredWidth: height

                        color: Qt.rgba(tooltip.accent.main.r, tooltip.accent.main.g, tooltip.accent.main.b, 0.18)
                        radius: UI.Size.pixel16

                        Media.Icon {
                            anchors.centerIn: tooltipIconContainer

                            iconData: verticalBar.isNegative ? Media.Icons.light.trendingDown : Media.Icons.light.trendingUp
							color: tooltip.accent.dark.toString()
                            size: UI.Size.pixel36
                        }
                    }

                    ColumnLayout {
                        id: textLayout

                        Layout.maximumHeight: tooltipIconContainer.height
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Item { Layout.fillHeight: true }

						UI.H4 {
                            property double percentage: Charts.ChartFunctions.calculateGrowthPercentage(verticalBarContainer.previousBarValue, verticalBarContainer.barValue)

                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignRight
                            elide: Text.ElideNone
                            wrapMode: Text.NoWrap
                            text: (verticalBar.isNegative ? "" : "+") + percentage.toString() + "%"
                            color: tooltip.accent.darker
                            font.variableAxes: { "wght": 700 }
                        }

						UI.Subtitle2 {
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignRight
                            elide: Text.ElideNone
                            wrapMode: Text.NoWrap
                            text: verticalBarContainer.barValue.toString()
                            color: tooltip.accent.darker
                            opacity: 0.72
                            font.pixelSize: UI.Size.pixel12
                        }

                        Item { Layout.fillHeight: true }
                    }
                }
            }
        }
    }

    Timer {
        id: extremasTimer
        interval: 80
        onTriggered: root.chartModel.refreshExtremas();
    }

    QtObject {
        id: d

        readonly property var valueListModel: Charts.ChartFunctions.generateAdaptiveCloseRangeNumbers(troughValue, peakValue, Math.ceil(root.height / (UI.Size.scale * 100)))
        property bool autoscroll: true
        property real oldContentX: chartList.contentX

        readonly property real peakValue: root.chartModel.peak
        readonly property real troughValue: root.chartModel.trough

        readonly property real peakRange: valueListModel[valueListModel.length - 1]
        readonly property real troughRange: valueListModel[0]
    }

    ListView {
        id: valueList

        readonly property real delHeight: 0

        verticalLayoutDirection: ListView.BottomToTop
        orientation: ListView.Vertical
        model: d.valueListModel
        spacing: chartList.height / (valueList.count - 1)
        opacity: 0
        width: contentWidth
        interactive: false

        anchors {
            left: root.left
            top: rootContainer.top
            topMargin: chartList.anchors.margins - 1
            bottom: rootContainer.bottom
            bottomMargin: chartList.anchors.margins
        }

        onModelChanged: valueListOpacityAnimation.restart()

		delegate: UI.Caption {
            required property string modelData

            width: Math.min(70 * UI.Size.scale, contentWidth)
            height: 0
            horizontalAlignment: Qt.AlignRight
            verticalAlignment: Qt.AlignVCenter
            text: Number(modelData).toLocaleString(Qt.locale(), 'f', 0)
            color: UI.Theme.text.disabled
            font.pixelSize: root.fontSize

            onWidthChanged: if (width > valueList.width) valueList.width = width
        }

        NumberAnimation on opacity {
            id: valueListOpacityAnimation
            duration: 300
            running: true
            from: 0
            to: 1
        }
    }

    Rectangle {
        id: rootContainer

        radius: UI.Size.pixel12
        color: "transparent"

        border.width: 1
        border.color: UI.Theme.action.focus

        anchors {
            left: valueList.right; leftMargin: UI.Size.pixel8
            top: root.top
            bottom: root.bottom
            right: root.right
        }

        ListView {
            id: chartList

            anchors.fill: rootContainer
            model: root.chartModel
            spacing: 0
            orientation: ListView.Horizontal
            opacity: 0
            interactive: true
            clip: true

            anchors {
                fill: rootContainer
                margins: UI.Size.pixel18
            }

            add: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "width"; from: 0; to: root.barWidth + root.spacing; duration: 500 }
                    NumberAnimation { properties: "barOpacity"; from: 0; to: 1; duration: 500 }
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "width"; to: 0; duration: 500 }
                    NumberAnimation { properties: "opacity"; to: 0; duration: 250 }
                }
            }

            displaced: Transition {
                NumberAnimation { properties: "x, y, height, width, opacity"; duration: 250 }
            }

            onContentWidthChanged: if (d.autoscroll && !chartList.dragging && !horizontalScrollBar.pressed && !chartList.flicking) { chartList.positionViewAtEnd(); }
            onCountChanged: extremasTimer.restart()
            onDraggingChanged: chartList.currentIndex = -1

            onContentXChanged: {
                if (chartList.atXEnd)
                    d.autoscroll = true
                else if (contentX < d.oldContentX && (chartList.dragging || horizontalScrollBar.pressed))
                    d.autoscroll = false
                d.oldContentX = contentX
            }

            delegate:  VerticalBar {
                id: del

                contentX: del.x - chartList.contentX
                width: root.barWidth + root.spacing
                height: chartList.height
                previousBarValue: index == 0 ? 0 : root.chartModel.at(index - 1).value
            }

			ScrollBar.horizontal: Controls.ScrollBar {
                id: horizontalScrollBar

                parent: rootContainer
                anchors {
                    right: chartList.right
                    bottom: chartList.bottom
                    bottomMargin: - (chartList.anchors.margins - height / 2)
                    left: chartList.left
                }
            }

            OpacityAnimator on opacity {
                from: 0
                to: 1
                duration: 1000
                easing.type: Easing.InOutQuad
                running: true
            }
        }

		Controls.MToggleButton {
            accent: UI.Theme.primary
            checked: d.autoscroll
            customCheckImplementation: true
            size: UI.Size.Grade.S
            visible: root.showLockButton
            icon.iconData: checked ? Media.Icons.light.lock : Media.Icons.light.lockOpen

            anchors {
                right: rootContainer.right
                top: rootContainer.top
                margins: chartList.anchors.margins
            }

            onClicked: {
                d.autoscroll = !d.autoscroll;

                if (d.autoscroll)
                    chartList.positionViewAtEnd();
            }
        }
    }
}
