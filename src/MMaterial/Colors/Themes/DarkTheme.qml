pragma Singleton

import "../BaseObjects"
import "../BasicPalettes"

ThemeBase{
    objectName: "Dark Theme"

    primary: BasicGreen
    secondary: BasicBlue

    info: PaletteBasic{
        darker: "#CAFDF5"
        dark: "#61F3F3"
        main: "#00B8D9"
        light: "#006C9C"
        lighter: "#003768"
        contrastText: "#FFFFFF"
    }

    success: PaletteBasic{
        darker: "#D8FBDE"
        dark: "#86E8AB"
        main: "#36B37E"
        light: "#1B806A"
        lighter: "#0A5554"
        contrastText: "#FFFFFF"
    }

    warning: PaletteBasic{
        darker: "#FFF5CC"
        dark: "#FFD666"
        main: "#FFAB00"
        light: "#B76E00"
        lighter: "#7A4100"
        contrastText: "#212B36"
    }

    error: PaletteBasic{
        darker: "#FFE9D5"
        dark: "#FFAC82"
        main: "#FF5630"
        light: "#B71D18"
        lighter: "#7A0916"
        contrastText: "#FFFFFF"
    }

    social: PaletteSocial{
        facebook: "#1877F2"
        twitter: "#00AAEC"
        instagram: "#E02D69"
        linkedin: "#007EBB"
    }

    text: PaletteText{
        primary: "#FFFFFF"
        secondary: "#919EAB"
        disabled: "#637381"
    }

    background: PaletteBackground{
        main: "#161C24"
        paper: "#212B36"
        neutral: "#212B36"
    }

    action: PaletteAction{
        active: "#919EAB"
        hover: Qt.rgba(145, 158, 171, 0.08)
        selected: Qt.rgba(145, 158, 171, 0.16)
        disabled: Qt.rgba(145, 158, 171, 0.80)
        disabledBackground: Qt.rgba(145, 158, 171, 0.24)
        focus: Qt.rgba(145, 158, 171, 0.24)
    }

    other: PaletteOther{
        divider: "#919EAB"
        outline: Qt.rgba(145, 158, 171, 0.32)
    }

    main: PaletteGrey{
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
