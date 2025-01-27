import QtQuick

import MMaterial.UI as UI
import MMaterial.Media as Media

Item {
    component ChipData: Item {
        property string text
        property UI.PaletteBasic accent: UI.Theme.primary
    }

    property string category

    property Media.IconData icon
    property string text
    property var model

    property ChipData chip: ChipData {}

    property var onClicked


}
