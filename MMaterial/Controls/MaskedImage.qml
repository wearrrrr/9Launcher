import QtQuick
import QtQuick.Effects

import MMaterial.UI as UI

Item {
    id: control

    property alias source: sourceImageItem.source
    property alias fillMode: sourceImageItem.fillMode

	property alias mask: mask
    property alias radius: mask.radius
    property alias topLeftRadius: mask.topLeftRadius
    property alias topRightRadius: mask.topRightRadius
    property alias bottomLeftRadius: mask.bottomLeftRadius
    property alias bottomRightRadius: mask.bottomRightRadius

    implicitHeight: UI.Size.pixel48
    implicitWidth: UI.Size.pixel48

    Image {
        id: sourceImageItem

        fillMode: Image.PreserveAspectCrop

        anchors.fill: control
        visible: false
        asynchronous: true
    }

    MultiEffect {
        source: sourceImageItem
        anchors.fill: sourceImageItem
        maskEnabled: true
        maskSource: mask
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
        maskSpreadAtMax: 1
    }

    Rectangle {
        id: mask

        width: sourceImageItem.width
        height: sourceImageItem.height
        layer.enabled: true
        visible: false
        radius: width / 2
		color: "black"
		antialiasing: true
    }
}
