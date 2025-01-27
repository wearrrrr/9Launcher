import QtQuick

import MMaterial.UI as UI

import QtQuick.Shapes 1.6

Shape {
    id: _root

    implicitHeight: 50
    implicitWidth: 50

    smooth: true
    antialiasing: true

	property color color: UI.Theme.primary.main
    property MBorder border: MBorder {}
    property CornerRadii radius: CornerRadii {
        topLeft: 0
        topRight: 0
        bottomLeft: 0
        bottomRight: 0
    }

    QtObject {
        id: d

        property real rawTopLeftRadius: Math.min(_root.radius.topLeft, Math.min(_root.width, _root.height) / 2)
        property real rawTopRightRadius: Math.min(_root.radius.topRight, Math.min(_root.width, _root.height) / 2)
        property real rawBottomLeftRadius: Math.min(_root.radius.bottomLeft, Math.min(_root.width, _root.height) / 2)
        property real rawBottomRightRadius: Math.min(_root.radius.bottomRight, Math.min(_root.width, _root.height) / 2)
    }

    ShapePath {
        strokeWidth: _root.border.width > 0 ? _root.border.width : -1
        strokeColor: _root.border.color
        fillColor: _root.color

        // Start just below the top left corner
        startX: d.rawTopLeftRadius
        startY: 0

        // Draw top line to beginning of top right corner arc
        PathLine { x: _root.width - d.rawTopRightRadius; y: 0 }
        // Draw the top right corner arc
        PathArc { x: _root.width; y: d.rawTopRightRadius; radiusX: d.rawTopRightRadius; radiusY: d.rawTopRightRadius }
        // Draw right line to beginning of bottom right corner arc
        PathLine { x: _root.width; y: _root.height - d.rawBottomRightRadius }
        // Draw the bottom right corner arc
        PathArc { x: _root.width - d.rawBottomRightRadius; y: _root.height; radiusX: d.rawBottomRightRadius; radiusY: d.rawBottomRightRadius }
        // Draw bottom line to beginning of bottom left corner arc
        PathLine { x: d.rawBottomLeftRadius; y: _root.height }
        // Draw the bottom left corner arc
        PathArc { x: 0; y: _root.height - d.rawBottomLeftRadius; radiusX: d.rawBottomLeftRadius; radiusY: d.rawBottomLeftRadius }
        // Draw left line to close the shape back at the start
        PathLine { x: 0; y: d.rawTopLeftRadius }
        // Draw the top left corner arc
        PathArc { x: d.rawTopLeftRadius; y: 0; radiusX: d.rawTopLeftRadius; radiusY: d.rawTopLeftRadius }
    }
}
