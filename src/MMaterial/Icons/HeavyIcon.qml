import QtQuick
import QtQuick.Controls.Material
import QtQuick.Effects

IconBase {
    id: _root

    Image{
        anchors.fill: _root

        fillMode: Image.PreserveAspectFit
        source: visible ? _root.iconData?.path ?? "" : ""

        sourceSize.height: _root.size

        layer {
            enabled: _root.color != ""
            effect: MultiEffect {
                colorizationColor: _root.color
                colorization: 1
                brightness: 0.7
            }
        }
    }
}






