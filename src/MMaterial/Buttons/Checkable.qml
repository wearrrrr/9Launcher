import QtQuick 

Item {
    id: _root

    property bool checked: false
    property bool customCheckImplementation: false

    property alias mouseArea: mouseArea

    signal clicked

    MouseArea {
        id: mouseArea

        anchors.fill: _root

        hoverEnabled: _root.enabled
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            _root.clicked();
            if(!_root.customCheckImplementation)
                _root.checked = !_root.checked;
        }
    }
}
