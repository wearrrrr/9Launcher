pragma Singleton

import QtQuick

import MMaterial.UI as UI

UI.ThemeBase{
    id: root

	property UI.ThemeBase currentTheme: UI.DarkTheme
	property list<color> chartColors: [root.primary, root.secondary, root.info, root.success, root.warning, root.error]

	function setTheme(theme: UI.ThemeBase) : void {
        console.log("Theme switched to " + theme.objectName)
        currentTheme = theme;
    }

	function getChartColorPattern(index: int) : UI.PaletteBasic {
        return chartColors[index % chartColors.length];
    }

	function getChartPatternColor(index: int, pattern: UI.PaletteBasic) : color {
        let switchArg = index % 5;
        switch(switchArg) {
            case 1:
                return pattern.light;
            case 2:
                return pattern.dark;
            case 3:
                return pattern.lighter;
            case 4:
                return pattern.darker;
            default:
                return pattern.main;
        }
    }

    primary: currentTheme?.primary ?? null
    secondary: currentTheme?.secondary ?? null
    info: currentTheme?.info ?? null
    success: currentTheme?.success ?? null
    warning: currentTheme?.warning ?? null
    error: currentTheme?.error ?? null
    main: currentTheme?.main ?? null
    social: currentTheme?.social ?? null
    background: currentTheme?.background ?? null
    other: currentTheme?.other ?? null
    text: currentTheme?.text ?? null
    action: currentTheme?.action ?? null
    common: currentTheme?.common ?? null
    defaultNeutral: currentTheme?.defaultNeutral ?? null
    passive: currentTheme?.passive ?? null
}
