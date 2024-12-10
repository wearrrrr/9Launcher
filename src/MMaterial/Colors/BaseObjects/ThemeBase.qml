import QtQuick

QtObject{
    id: root

    required property PaletteBasic primary
    required property PaletteBasic secondary
    required property PaletteBasic info
    required property PaletteBasic success
    required property PaletteBasic warning
    required property PaletteBasic error
    required property PaletteText text
    required property PaletteBackground background
    required property PaletteAction action
    required property PaletteOther other

    required property PaletteGrey main
    required property PaletteSocial social

    property PaletteCommon common: PaletteCommon{}

    property PaletteBasic defaultNeutral: PaletteBasic{
        main: text.primary
        contrastText: background.main
    }

    property PaletteBasic passive: PaletteBasic{
        darker: root.main.transparent.p32
        dark: root.main.transparent.p16
        main: text.primary
        light: root.main.transparent.p16
        lighter: root.main.transparent.p32
        contrastText: text.secondary
    }
}
