import QtQuick

QtObject {
    required property color mainColor;

    readonly property color p8: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.08)
    readonly property color p12: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.12)
    readonly property color p16: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.16)
    readonly property color p20: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.20)
    readonly property color p24: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.24)
    readonly property color p32: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.32)
    readonly property color p48: Qt.rgba(mainColor.r, mainColor.g, mainColor.b, 0.48)
}
