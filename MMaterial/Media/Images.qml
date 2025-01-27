pragma Singleton

import QtQuick

import MMaterial.Media as Media

QtObject{
    id: _root

	readonly property string iconBasePath: "qrc:/MMaterial/Media/assets/other/"

	readonly property Media.IconData woman: Media.IconData { path: _root.iconBasePath + "programmer-female.png"; type: Media.IconData.Heavy }
	readonly property Media.IconData womanSitting: Media.IconData { path: _root.iconBasePath + "programmer-female2.png"; type: Media.IconData.Heavy }
	readonly property Media.IconData man: Media.IconData { path: _root.iconBasePath + "programmer-male.png"; type: Media.IconData.Heavy }
	readonly property Media.IconData manSitting: Media.IconData { path: _root.iconBasePath + "programmer-male2.png"; type: Media.IconData.Heavy }
	readonly property Media.IconData realisticShape1: Media.IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_1.jpeg"; type: Media.IconData.Heavy }
	readonly property Media.IconData realisticShape2: Media.IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_2.jpeg"; type: Media.IconData.Heavy }
	readonly property Media.IconData realisticShape3: Media.IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_3.jpeg"; type: Media.IconData.Heavy }
}
