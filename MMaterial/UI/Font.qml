pragma Singleton

import QtQuick

Item {
    id: root
    // can't set a webfont path by default as there is a race in qt (request sent, the app might set a font during startup,
    // request comes back and thinks it is important. e.g., when offline, an error is reported and the app font is not set).
    property string normalFamilyPath:    "qrc:/MMaterial/UI/fonts/Public_Sans/PublicSans-VariableFont_wght.ttf"
    property string bodyFamilyPath:      "qrc:/MMaterial/UI/fonts/Public_Sans/PublicSans-VariableFont_wght.ttf"
    property string italicFamilyPath:    "qrc:/MMaterial/UI/fonts/Public_Sans/PublicSans-Italic-VariableFont_wght.ttf"
    property string monospaceFamilyPath: "qrc:/MMaterial/UI/fonts/Roboto_Mono/RobotoMono-VariableFont_wght.ttf"

    readonly property string normal: normalFamilyLoader.name
    readonly property string body: bodyFamilyLoader.name
    readonly property string italic: italicFamilyLoader.name
    readonly property string monospace: monospaceFamilyLoader.name

    FontLoader{ id: normalFamilyLoader; source: root.normalFamilyPath; }
    FontLoader{ id: bodyFamilyLoader; source: root.bodyFamilyPath;}
    FontLoader{ id: italicFamilyLoader; source: root.italicFamilyPath; }
    FontLoader{ id: monospaceFamilyLoader; source: root.monospaceFamilyPath; }
}
