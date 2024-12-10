import QtQuick
import QtQuick.Controls.Material

import "../../Colors"
import "../../Components/Common"

Text {
    id: _root

    property string tooltipText: _root.text
    property bool showTooltip: _root.truncated

    color: Theme.text.primary

    HoverHandler{
        id: _hoverHandler
        enabled: _root.showTooltip
    }

    MToolTip {
        visible: _hoverHandler.hovered
        text: _root.tooltipText
        delay: 300
    }
}
