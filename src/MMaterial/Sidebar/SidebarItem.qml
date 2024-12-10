import QtQuick

import MMaterial

Item {
    component ChipData: Item {
        property string text
        property PaletteBasic accent: Theme.primary
    }

    property string category

    property IconData icon
    property string text
    property var model

    property ChipData chip: ChipData {}

    property var onClicked


}
