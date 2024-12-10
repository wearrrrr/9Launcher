pragma Singleton

import QtQuick

QtObject{
    id: _root

    readonly property string iconBasePath: Qt.resolvedUrl("./assets/png/")

    readonly property IconData woman: IconData { path: _root.iconBasePath + "programmer-female.png"; type: IconData.Heavy }
    readonly property IconData womanSitting: IconData { path: _root.iconBasePath + "programmer-female2.png"; type: IconData.Heavy }
    readonly property IconData man: IconData { path: _root.iconBasePath + "programmer-male.png"; type: IconData.Heavy }
    readonly property IconData manSitting: IconData { path: _root.iconBasePath + "programmer-male2.png"; type: IconData.Heavy }
    readonly property IconData realisticShape1: IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_1.jpeg"; type: IconData.Heavy }
    readonly property IconData realisticShape2: IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_2.jpeg"; type: IconData.Heavy }
    readonly property IconData realisticShape3: IconData { path: _root.iconBasePath + "abstract_futuristic_3D_shape_3.jpeg"; type: IconData.Heavy }
}
