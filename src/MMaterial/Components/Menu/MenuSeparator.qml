import QtQuick
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T

import MMaterial as MMaterial

T.MenuSeparator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: MMaterial.Size.pixel2
    verticalPadding: padding + MMaterial.Size.pixel4

    contentItem: Rectangle {
        radius: MMaterial.Size.pixel6
        implicitWidth: 188
        implicitHeight: 1
        color: MMaterial.Theme.text.secondary
    }
}
