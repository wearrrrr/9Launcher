import QtQuick

Item {
    id: root

    property string fontName

    readonly property string extraBold: extraBoldFont.name
    readonly property string bold: boldFont.name
    readonly property string semiBold: semiBoldFont.name
    readonly property string medium: mediumFont.name
    readonly property string regular: regularFont.name
    readonly property string light: lightFont.name
    readonly property string extraLight: extraLightFont.name

    readonly property string basePath: "./Families/" + fontName + "/" + fontName

    FontLoader{ id: extraBoldFont; source: root.basePath + "-ExtraBold.ttf" }
    FontLoader{ id: boldFont; source: root.basePath + "-Bold.ttf"; }
    FontLoader{ id: semiBoldFont; source: root.basePath + "-SemiBold.ttf" }
    FontLoader{ id: mediumFont; source: root.basePath + "-Medium.ttf" }
    FontLoader{ id: regularFont; source: root.basePath + "-Regular.ttf" }
    FontLoader{ id: lightFont; source: root.basePath + "-Light.ttf" }
    FontLoader{ id: extraLightFont; source: root.basePath + "-ExtraLight.ttf" }
}
