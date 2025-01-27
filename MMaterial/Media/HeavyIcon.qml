pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import MMaterial.Media as Media

Media.IconBase {
    id: _root

    Image{
        anchors.fill: _root

        fillMode: Image.PreserveAspectFit
        source: (visible ? _root.iconData?.path ?? "" : "").toString()

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






