import QtQuick
import "../"
import "../../Settings"

BaseText {
    lineHeight: 1.5
    elide: Text.ElideRight

    font {
        family: PublicSans.bold
        pixelSize: Size.pixel18
        bold: true
    }
}
