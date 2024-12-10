import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import MMaterial as MMaterial

Item {
    id: root

    property alias orientation: chartList.orientation
    property alias spacing: chartList.spacing
    property alias graphContainer: rootContainer
    property alias model: root.chartModel.model

    property bool autoResize: true
    property real fontSize: MMaterial.Size.pixel12
    property real barContainerWidth: MMaterial.Size.pixel48

    property MMaterial.ChartModel chartModel: MMaterial.ChartModel {}

    onHeightChanged: stopAnimationTimer.restart()
    onWidthChanged: stopAnimationTimer.restart()
    onAutoResizeChanged: secondaryStopAnimationTimer.restart()

    component VerticalBars: ListView {
        id: verticalDelRoot

        readonly property MMaterial.ChartElement chartElement: element
        property real delegateWidth: (verticalDelRoot.width - (verticalDelRoot.count - 1) * verticalDelRoot.spacing) / verticalDelRoot.count
        property real contentX: 0
        property int elementIndex: index

        spacing: MMaterial.Size.pixel6
        height: chartList.height
        width: d.verticalBarWidth
        orientation: ListView.Horizontal
        model: verticalDelRoot.chartElement

        onCountChanged: peakValueTimer.restart()

        displaced: Transition {
            NumberAnimation { properties: "x, y, height, width"; duration: 250 }
        }

        Behavior on delegateWidth {
            enabled: !stopAnimationTimer.running && !secondaryStopAnimationTimer.running
            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }

        Behavior on width {
            enabled: !stopAnimationTimer.running

            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }

        delegate: Item {
            id: subChart

            property double value: barValue
            readonly property real prefMaxHeight: chartList.height * (subChart.value / d.peakValue)

            height: verticalDelRoot.height
            width: verticalDelRoot.delegateWidth

            onValueChanged: peakValueTimer.restart()

            Rectangle {
                id: verticalBar

                radius: MMaterial.Size.pixel4
                width: verticalDelRoot.delegateWidth
                height: subChart.prefMaxHeight
                anchors.bottom: parent.bottom

                color: barColor ?? MMaterial.Theme.getChartPatternColor(index, d.defaultColorPatterns[verticalDelRoot.elementIndex % d.defaultColorPatterns.length])

                border {
                    width: delHover.hovered ? MMaterial.Size.pixel1 * 2 : 0
                    color: Qt.lighter(subChart.color)
                }

                Behavior on border.width { NumberAnimation { duration: 50; easing.type: Easing.OutQuad } }
                NumberAnimation on height { id: heightInitAnimation; running: true; from: 0; to: subChart.prefMaxHeight; duration: 400; easing.type: Easing.InOutQuad }

                Behavior on height {
                    enabled: !heightInitAnimation.running && !stopAnimationTimer.running
                    NumberAnimation {
                        duration: 400; easing.type: Easing.InOutQuad
                    }
                }

                HoverHandler {
                    id: delHover

                    onHoveredChanged: {
                        if (delHover.hovered) {
                            tooltip.x = verticalDelRoot.contentX + subChart.x + subChart.width + MMaterial.Size.pixel8;
                            tooltip.y = verticalBar.y + verticalBar.height / 2 - tooltip.height / 2;
                            tooltip.show("<b>" + barName + "</b>: " + subChart.value, 0);
                            tooltipCloseTimer.restart();
                        }
                    }
                }
            }
        }
    }


    component HorizontalBars: ListView {
        id: horizontalDelRoot

        readonly property MMaterial.ChartElement chartElement: element
        property real delegateHeight: (horizontalDelRoot.height - (horizontalDelRoot.count - 1) * horizontalDelRoot.spacing) / horizontalDelRoot.count
        property real contentY: 0
        property int elementIndex: index

        spacing: MMaterial.Size.pixel6
        height: d.horizontalBarHeight
        width: chartList.width
        model: horizontalDelRoot.chartElement

        onCountChanged: peakValueTimer.restart()

        displaced: Transition {
            NumberAnimation { properties: "x, y, height, width"; duration: 250 }
        }

        Behavior on delegateHeight {
            enabled: !stopAnimationTimer.running && !secondaryStopAnimationTimer.running
            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }


        Behavior on height {
            enabled: !stopAnimationTimer.running

            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }

        delegate: Rectangle {
            id: horSubChart

            property real value: barValue
            readonly property real prefMaxWidth: chartList.width * (horSubChart.value / d.peakValue)

            radius: MMaterial.Size.pixel4

            height: horizontalDelRoot.delegateHeight
            width: horSubChart.prefMaxWidth

            color: barColor ?? MMaterial.Theme.getChartPatternColor(index, d.defaultColorPatterns[horizontalDelRoot.elementIndex % d.defaultColorPatterns.length])

            border {
                width: horDelHover.hovered ? MMaterial.Size.pixel1 * 2 : 0
                color: Qt.lighter(horSubChart.color)
            }

            onValueChanged: peakValueTimer.restart()

            Behavior on border.width { NumberAnimation { duration: 50; easing.type: Easing.OutQuad } }
            NumberAnimation on width { id: widthInitAnimation; running: true; from: 0; to: horSubChart.prefMaxWidth; duration: 400; easing.type: Easing.InOutQuad }

            Behavior on width {
                enabled: !widthInitAnimation.running && !stopAnimationTimer.running
                NumberAnimation {
                    duration: 400; easing.type: Easing.InOutQuad
                }
            }

            HoverHandler {
                id: horDelHover

                onHoveredChanged: {
                    if (horDelHover.hovered) {
                        tooltip.x = horSubChart.x + horSubChart.width + MMaterial.Size.pixel8;
                        tooltip.y = horizontalDelRoot.contentY + horizontalDelRoot.y + horSubChart.y + horSubChart.height / 2 - tooltip.height / 2;
                        tooltip.show("<b>" + barName + "</b>: " + horSubChart.value, 0);
                        tooltipCloseTimer.restart();
                    }
                }
            }
        }

    }

    Timer {
        id: stopAnimationTimer
        interval: 500
    }

    Timer {
        id: secondaryStopAnimationTimer
        interval: 500
    }

    Timer {
        id: peakValueTimer
        interval: 80
        onTriggered: d.peakValue = root.chartModel.getMaxValue();
    }

    QtObject {
        id: d

        property var valueListModel: MMaterial.ChartFunctions.generateSpreadNumbers(0, peakValue, Math.ceil(root.height / (MMaterial.Size.scale * 100)))
        property real peakValue: root.chartModel.getMaxValue()
        readonly property real verticalBarWidth: root.autoResize ? (chartList.width - (chartList.count - 1) * chartList.spacing) / chartList.count : root.barContainerWidth
        readonly property real horizontalBarHeight: root.autoResize ? (chartList.height - (chartList.count - 1) * chartList.spacing) / chartList.count : root.barContainerWidth
        readonly property list<MMaterial.PaletteBasic> defaultColorPatterns: [MMaterial.Theme.primary, MMaterial.Theme.secondary, MMaterial.Theme.info, MMaterial.Theme.success, MMaterial.Theme.warning, MMaterial.Theme.error]
    }

    ListView {
        id: valueList

        readonly property real delHeight: chartList.isHorizontalChart ? 0 : valueList.height
        readonly property real delWidth: chartList.isHorizontalChart ? valueList.width : 0

        verticalLayoutDirection: ListView.BottomToTop
        orientation: chartList.isHorizontalChart ? ListView.Vertical : ListView.Horizontal
        model: d.valueListModel
        spacing: chartList.isHorizontalChart ? chartList.height / (valueList.count - 1) : chartList.width / (valueList.count - 1)
        opacity: 0

        anchors {
            left: chartList.isHorizontalChart ? root.left : rootContainer.left
            leftMargin: chartList.isHorizontalChart ? 0 : chartList.anchors.margins
            right: chartList.isHorizontalChart ? rootContainer.left : rootContainer.right;
            rightMargin: chartList.isHorizontalChart ? MMaterial.Size.pixel8 : chartList.anchors.margins
            top: chartList.isHorizontalChart ? rootContainer.top : rootContainer.bottom
            topMargin: chartList.isHorizontalChart ? chartList.anchors.margins : MMaterial.Size.pixel8
            bottom: chartList.isHorizontalChart ? rootContainer.bottom : root.bottom
            bottomMargin: chartList.isHorizontalChart ? chartList.anchors.margins : 0
        }

        onModelChanged: valueListOpacityAnimation.restart()

        delegate: MMaterial.Caption {
            height: valueList.delHeight
            width: valueList.delWidth
            horizontalAlignment: chartList.isHorizontalChart ? Qt.AlignRight : Qt.AlignLeft
            verticalAlignment: chartList.isHorizontalChart ? Qt.AlignVCenter : Qt.AlignTop
            text: Number(modelData).toLocaleString(Qt.locale(), 'f', 0)
            color: MMaterial.Theme.text.disabled
            font.pixelSize: root.fontSize
        }

        NumberAnimation on opacity {
            id: valueListOpacityAnimation
            duration: 300
            running: true
            from: 0
            to: 1
        }
    }

    ListView {
        id: nameList

        property real delHeight: chartList.isHorizontalChart ? nameList.height : d.horizontalBarHeight
        property real delWidth: chartList.isHorizontalChart ? d.verticalBarWidth : nameList.width

        verticalLayoutDirection: ListView.BottomToTop
        orientation: chartList.isHorizontalChart ? ListView.Horizontal : ListView.Vertical
        model: root.chartModel
        spacing: chartList.spacing
        opacity: 0

        anchors {
            left: chartList.isHorizontalChart ? rootContainer.left : root.left
            leftMargin: chartList.isHorizontalChart ? chartList.anchors.margins : 0
            right: chartList.isHorizontalChart ? rootContainer.right : rootContainer.left
            rightMargin: chartList.isHorizontalChart ? chartList.anchors.margins : MMaterial.Size.pixel8
            top: chartList.isHorizontalChart ? rootContainer.bottom : rootContainer.top
            topMargin: chartList.isHorizontalChart ? MMaterial.Size.pixel8 : chartList.anchors.margins
            bottom: chartList.isHorizontalChart ? root.bottom : rootContainer.bottom
            bottomMargin: chartList.isHorizontalChart ? 0 : chartList.anchors.margins
        }

        delegate: MMaterial.Caption {
            height: nameList.delHeight
            width: nameList.delWidth
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            horizontalAlignment: chartList.isHorizontalChart ? Qt.AlignHCenter : Qt.AlignRight
            verticalAlignment: chartList.isHorizontalChart ? Qt.AlignTop : Qt.AlignVCenter
            text: name
            color: MMaterial.Theme.text.disabled
            font.pixelSize: root.fontSize
        }

        Behavior on delWidth {
            enabled: chartList.isHorizontalChart && !nameListOpacityAnimation.running && !stopAnimationTimer.running
            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }

        Behavior on delHeight {
            enabled: !chartList.isHorizontalChart && !nameListOpacityAnimation.running && !stopAnimationTimer.running
            NumberAnimation {
                duration: 400; easing.type: Easing.InOutQuad
            }
        }

        NumberAnimation on opacity {
            id: nameListOpacityAnimation
            duration: 300
            running: true
            from: 0
            to: 1
        }
    }

    Rectangle {
        id: rootContainer

        radius: MMaterial.Size.pixel12
        height: root.height - root.fontSize * 4
        width: root.width - MMaterial.Size.pixel48
        color: "transparent"

        border.width: 1
        border.color: MMaterial.Theme.action.focus

        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
        }

        ListView {
            id: chartList

            readonly property bool isHorizontalChart: chartList.orientation == ListView.Horizontal

            model: root.chartModel
            interactive: false
            spacing: MMaterial.Size.pixel12
            orientation: ListView.Horizontal
            verticalLayoutDirection: ListView.BottomToTop
            clip: true

            add: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 250 }
                    NumberAnimation { properties: "height"; from: 0; duration: 250; easing.type: Easing.OutQuad }
                }
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "opacity"; to: 0; duration: 150 }
                    NumberAnimation { properties: "height, width"; to: 0; duration: 250; easing.type: Easing.OutQuad }
                }
            }

            displaced: Transition {
                NumberAnimation { properties: "x, y, height, width"; duration: 250 }
            }

            anchors {
                fill: rootContainer
                margins: MMaterial.Size.pixel18
            }

            onIsHorizontalChartChanged: {
                valueListOpacityAnimation.restart()
                nameListOpacityAnimation.restart()
            }

            onCountChanged: {
                secondaryStopAnimationTimer.restart()
                peakValueTimer.restart()
            }

            delegate: Loader {
                id: del

                sourceComponent: chartList.isHorizontalChart ? verticalComponent : horizontalComponent

                Component {
                    id: verticalComponent

                    VerticalBars {
                        contentX: del.x + chartList.contentX
                    }
                }

                Component {
                    id: horizontalComponent

                    HorizontalBars {
                        contentY: del.y - (chartList.verticalLayoutDirection == ListView.BottomToTop ? chartList.contentY : -chartList.contentY)
                    }
                }
            }

            MMaterial.MToolTip {
                id: tooltip
                delay: 300

                Timer {
                    id: tooltipCloseTimer

                    interval: 2000
                    onTriggered: tooltip.hide();
                }
            }
        }
    }
}
