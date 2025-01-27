import QtQuick

import MMaterial.Controls as Controls

Loader {
    id: _root

    property alias busyIndicator: _busyIndicator

	Controls.BusyIndicator{
        id: _busyIndicator

        anchors.centerIn: _root

        z: 2

        show: _root.status == Loader.Loading
    }
}
