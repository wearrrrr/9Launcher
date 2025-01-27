import QtQuick

import MMaterial.UI as UI

UI.BaseText {
    lineHeight: 1
    elide: Text.ElideRight

    font {
		family: UI.PublicSans.bold
        pixelSize: UI.Size.pixel48
    }
}
