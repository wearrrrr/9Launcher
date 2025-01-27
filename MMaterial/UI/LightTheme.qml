pragma Singleton

import MMaterial.UI as UI

UI.ThemeBase{
    objectName: "Light UI.Theme"

	primary: UI.BasicGreen
	secondary: UI.BasicBlue

	info: UI.PaletteBasic{
        lighter: "#CAFDF5"
        light: "#61F3F3"
        main: "#00B8D9"
        dark: "#006C9C"
        darker: "#003768"
        contrastText: "#FFFFFF"
    }

	success: UI.PaletteBasic{
        lighter: "#D8FBDE"
        light: "#86E8AB"
        main: "#36B37E"
        dark: "#1B806A"
        darker: "#0A5554"
        contrastText: "#FFFFFF"
    }

	warning: UI.PaletteBasic{
        lighter: "#FFF5CC"
        light: "#FFD666"
        main: "#FFAB00"
        dark: "#B76E00"
        darker: "#7A4100"
        contrastText: "#212B36"
    }

	error: UI.PaletteBasic{
        lighter: "#FFE9D5"
        light: "#FFAC82"
        main: "#FF5630"
        dark: "#B71D18"
        darker: "#7A0916"
        contrastText: "#FFFFFF"
    }

	social: UI.PaletteSocial{
        facebook: "#1877F2"
        twitter: "#00AAEC"
        instagram: "#E02D69"
        linkedin: "#007EBB"
    }

	text: UI.PaletteText{
        primary: "#212B36"
        secondary: "#637381"
        disabled: "#919EAB"
    }

	background: UI.PaletteBackground{
        main: "#FFFFFF"
        paper: "#fafafa"
        neutral: "#F4F6F8"
    }

	action: UI.PaletteAction{
        active: "#637381"
        hover: Qt.rgba(0, 0, 0, 0.03)
        selected: Qt.rgba(0, 0, 0, 0.06)
        disabled: Qt.rgba(0, 0, 0, 0.2)
        disabledBackground: Qt.rgba(0, 0, 0, 0.05)
        focus: Qt.rgba(0, 0, 0, 0.14)
    }

	other: UI.PaletteOther{
        divider: "#919EAB"
        outline: Qt.rgba(145, 158, 171, 0.32)
    }

	main: UI.PaletteGrey{
        p100: "#F9FAFB"
        p200: "#F4F6F8"
        p300: "#DFE3E8"
        p400: "#C4CDD5"
        p500: "#919EAB"
        p600: "#637381"
        p700: "#454F5B"
        p800: "#212B36"
        p900: "#161C24"
    }
}
