import QtQuick

import MMaterial.UI as UI

UI.BaseText {
    lineHeight: 1
    elide: Text.ElideRight

    font {
        variableAxes: { "wght": 800 }
        pixelSize: UI.Size.pixel64
    }
}
