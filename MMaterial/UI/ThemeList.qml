pragma Singleton

import QtQuick

import MMaterial.UI as UI

QtObject{
	property UI.ThemeBase light: UI.LightTheme
	property UI.ThemeBase dark: UI.DarkTheme
}
