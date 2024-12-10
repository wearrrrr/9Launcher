import QtQuick
import QtQuick.Controls.Material

import MMaterial as MMaterial

Loader {
    id: _root

    property alias busyIndicator: _busyIndicator

    MMaterial.BusyIndicator{
        id: _busyIndicator

        anchors.centerIn: _root

        z: 2

        show: _root.status == Loader.Loading
    }
}
