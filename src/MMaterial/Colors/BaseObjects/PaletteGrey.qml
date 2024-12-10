import QtQuick

QtObject{
    required property color p100
    required property color p200
    required property color p300
    required property color p400
    required property color p500
    required property color p600
    required property color p700
    required property color p800
    required property color p900

    property PaletteTransparent transparent: PaletteTransparent{
        mainColor: p500
    }
}
