import QtQuick
import "../"
import "../../Settings"

BaseText {
    lineHeight: 1.5
    wrapMode: Text.WordWrap

    font {
        family: PublicSans.bold
        pixelSize: Size.pixel12
        capitalization: Font.AllUppercase
        bold: true
    }
}
