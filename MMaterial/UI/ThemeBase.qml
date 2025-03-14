pragma ComponentBehavior: Bound

import QtQuick

import MMaterial.UI as UI

QtObject{
    id: root

	required property UI.PaletteBasic primary
	required property UI.PaletteBasic secondary
	required property UI.PaletteBasic info
	required property UI.PaletteBasic success
	required property UI.PaletteBasic warning
	required property UI.PaletteBasic error
	required property UI.PaletteText text
	required property UI.PaletteBackground background
	required property UI.PaletteAction action
	required property UI.PaletteOther other

	required property UI.PaletteGrey main
	// required property UI.PaletteSocial social

	property UI.PaletteCommon common: UI.PaletteCommon{}

	property UI.PaletteBasic defaultNeutral: UI.PaletteBasic{
        main: root.text.primary
        contrastText: root.background.main
    }

	property UI.PaletteBasic passive: UI.PaletteBasic{
        darker: root.main.transparent.p32
        dark: root.main.transparent.p16
        main: root.text.primary
        light: root.main.transparent.p16
        lighter: root.main.transparent.p32
        contrastText: root.text.secondary
    }
}
