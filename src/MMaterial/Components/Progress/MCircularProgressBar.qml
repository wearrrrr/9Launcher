import QtQuick 
import QtQuick.Layouts

import MMaterial

Item {
    id: _root

    property int size: Size.pixel48 * 2
    property int lineWidth: Size.pixel4
    property int progress: 0

    property var accent: Theme.primary
    property color primaryColor: accent.main
    property color secondaryColor: "transparent"
    property bool showLabel: false

    property int animationDuration: 80

    implicitHeight: size
    implicitWidth: size

    onProgressChanged: canvas.degree = (progress/100) * 360;


    Caption{
        anchors.centerIn: _root

        text: _root.progress + "%"
        visible: _root.showLabel
        font.pixelSize: _root.height* 0.25
        color: Theme.text.primary

        verticalAlignment: Qt.AlignVCenter
    }

    Canvas {
        id: canvas

        property real degree: 0

        anchors.fill: _root
        antialiasing: true

        onDegreeChanged: requestPaint();

        onPaint: {
            var ctx = getContext("2d");

            var x = _root.width/2;
            var y = _root.height/2;

            var radius = _root.size/2 - _root.lineWidth
            var startAngle = (Math.PI/180) * 270;
            var fullAngle = (Math.PI/180) * (270 + 360);
            var progressAngle = (Math.PI/180) * (270 + degree);

            ctx.reset()
            ctx.lineWidth = _root.lineWidth;

            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, fullAngle);
            ctx.strokeStyle = _root.secondaryColor;
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, progressAngle);
            ctx.strokeStyle = _root.primaryColor;
            ctx.stroke();
        }

        Behavior on degree {
            NumberAnimation {
                duration: _root.animationDuration
            }
        }
    }
}
