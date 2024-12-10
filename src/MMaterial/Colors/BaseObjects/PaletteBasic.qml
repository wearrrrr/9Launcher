import QtQuick

QtObject{
    id: _root

    required property color main
    required property color contrastText

    property color lighter: Qt.lighter(main, 1.6)
    property color light: Qt.lighter(main, 1.3)
    property color dark: Qt.darker(main, 1.3)
    property color darker: Qt.darker(main, 1.6)

    property PaletteTransparent transparent: PaletteTransparent{
        mainColor: _root.main
    }
}
