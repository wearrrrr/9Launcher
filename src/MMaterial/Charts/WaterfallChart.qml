import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial as MMaterial

Item {
    id: root

    property alias descriptionWidth: valueList.width
    property alias chartList: chartList

    property bool showLockButton: true
    property real spacing: MMaterial.Size.pixel12
    property real barWidth: MMaterial.Size.pixel6
    property real fontSize: MMaterial.Size.pixel12

    property MMaterial.PaletteBasic positiveAccent: MMaterial.Theme.success
    property MMaterial.PaletteBasic negativeAccent: MMaterial.Theme.error

    property MMaterial.ChartElement chartModel: MMaterial.ChartElement {
        bars: [
            MMaterial.ChartElementBar { value: -100; name: qsTr("January") },
            MMaterial.ChartElementBar { value: 1800; name: qsTr("February") },
            MMaterial.ChartElementBar { value: 3000; name: qsTr("March") },
            MMaterial.ChartElementBar { value: 2700; name: qsTr("April") }
        ]
    }

    component VerticalBar: Item {
        id: verticalBarContainer

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
            radius: MMaterial.Size.pixel12
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
                width: delHover.hovered || barSelected ? MMaterial.Size.pixel1 * 2 : 0
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
                    barSelected = !barSelected;
                }
            }

            MMaterial.MToolTip {
                id: tooltip

                property MMaterial.PaletteBasic accent: verticalBar.isNegative ? root.negativeAccent : root.positiveAccent

                x: verticalBar.x
                closePolicy: Popup.NoAutoClose

                height: 87 * MMaterial.Size.scale
                width: 210 * MMaterial.Size.scale

                margins: 0
                topPadding: MMaterial.Size.pixel12
                bottomPadding: MMaterial.Size.pixel12
                leftPadding: MMaterial.Size.pixel12
                rightPadding: MMaterial.Size.pixel12

                delay: 0
                visible: delHover.hovered || (barSelected && verticalBarContainer.trueVisible)

                enter: Transition {
                    SequentialAnimation {
                        PropertyAction { property: "contentItem.textLayout.opacity"; value: 0.0 }

                        ParallelAnimation {
                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutQuad; duration: 340 }
                            NumberAnimation { property: "width"; from: 0.0; to: 210 * MMaterial.Size.scale; easing.type: Easing.OutQuad; duration: 340 }
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
                    radius: MMaterial.Size.pixel20
                    color: tooltip.accent.lighter
                    opacity: 0.8
                }

                contentItem:  RowLayout {
                    spacing: MMaterial.Size.pixel24

                    property alias textLayout: textLayout

                    Rectangle {
                        id: tooltipIconContainer

                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.maximumHeight: tooltip.height - tooltip.topPadding - tooltip.bottomPadding
                        Layout.preferredWidth: height

                        color: Qt.rgba(tooltip.accent.main.r, tooltip.accent.main.g, tooltip.accent.main.b, 0.18)
                        radius: MMaterial.Size.pixel16

                        MMaterial.Icon {
                            anchors.centerIn: tooltipIconContainer

                            iconData: verticalBar.isNegative ? MMaterial.Icons.light.trendingDown : MMaterial.Icons.light.trendingUp
                            color: tooltip.accent.dark
                            size: MMaterial.Size.pixel36
                        }
                    }

                    ColumnLayout {
                        id: textLayout

                        Layout.maximumHeight: tooltipIconContainer.height
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Item { Layout.fillHeight: true }

                        MMaterial.H4 {
                            property double percentage: MMaterial.ChartFunctions.calculateGrowthPercentage(verticalBarContainer.previousBarValue, barValue)

                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignRight
                            elide: Text.ElideNone
                            wrapMode: Text.NoWrap
                            text: (verticalBar.isNegative ? "" : "+") + percentage.toString() + "%"
                            color: tooltip.accent.darker
                            font.family: MMaterial.PublicSans.extraBold
                            font.bold: true
                        }

                        MMaterial.Subtitle2 {
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignRight
                            elide: Text.ElideNone
                            wrapMode: Text.NoWrap
                            text: barValue.toString()
                            color: tooltip.accent.darker
                            opacity: 0.72
                            font.pixelSize: MMaterial.Size.pixel12
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

        readonly property var valueListModel: MMaterial.ChartFunctions.generateAdaptiveCloseRangeNumbers(troughValue, peakValue, Math.ceil(root.height / (MMaterial.Size.scale * 100)))
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

        delegate: MMaterial.Caption {
            width: Math.min(70 * MMaterial.Size.scale, contentWidth)
            height: 0
            horizontalAlignment: Qt.AlignRight
            verticalAlignment: Qt.AlignVCenter
            text: Number(modelData).toLocaleString(Qt.locale(), 'f', 0)
            color: MMaterial.Theme.text.disabled
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

        radius: MMaterial.Size.pixel12
        color: "transparent"

        border.width: 1
        border.color: MMaterial.Theme.action.focus

        anchors {
            left: valueList.right; leftMargin: MMaterial.Size.pixel8
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
                margins: MMaterial.Size.pixel18
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

            ScrollBar.horizontal: MMaterial.ScrollBar {
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

        MMaterial.MToggleButton {
            accent: MMaterial.Theme.primary
            checked: d.autoscroll
            customCheckImplementation: true
            size: MMaterial.Size.Grade.S
            visible: root.showLockButton
            icon.iconData: checked ? MMaterial.Icons.light.lock : MMaterial.Icons.light.lockOpen

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
