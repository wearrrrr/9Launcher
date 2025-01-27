import QtQuick

import MMaterial.UI as UI

QtObject{
    id: root

    required property color p100
    required property color p200
    required property color p300
    required property color p400
    required property color p500
    required property color p600
    required property color p700
    required property color p800
    required property color p900

	property UI.PaletteTransparent transparent: UI.PaletteTransparent{
        mainColor: root.p500
    }
}
