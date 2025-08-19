import QtQuick

import MMaterial.UI as UI

UI.BaseText {
    lineHeight: 1
    elide: Text.ElideRight

    font {
        variableAxes: { "wght": 700 }
        pixelSize: UI.Size.pixel48
    }
}
