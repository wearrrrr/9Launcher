import QtQuick

import MMaterial.UI as UI

UI.BaseText {
    elide: Text.ElideRight
    lineHeight: 1

    font {
		family: UI.PublicSans.extraBold
        pixelSize: UI.Size.pixel64
    }
}
