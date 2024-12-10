pragma Singleton

import QtQuick

import "./Themes"
import "./BaseObjects"

QtObject{
    property ThemeBase light: LightTheme
    property ThemeBase dark: DarkTheme
}
