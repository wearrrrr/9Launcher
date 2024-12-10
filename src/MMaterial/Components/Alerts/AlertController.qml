import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../../Settings"

Popup {
    id: _root

    property int edgeOf: Item.TopLeft //TopRight, BottomLeft, BottomRight

    function activate(
        message,
        details = {},
        duration = 3500)
    {
        if(!message)
            console.warn("No text added for alert!")

        let alertObject = {
            text : message,
            closeTime : duration
        };

        if(details.severity)
            alertObject.severity = details.severity;
        if(details.icon)
            alertObject.icon = details.icon;
        if(details.variant)
            alertObject.variant = details.variant;
        if(details.dismissButton)
            alertObject.dismissButton = details.dismissButton;
        if(details.actionButton)
            alertObject.actionButton = details.actionButton;

        _contentRoot.model.append(alertObject);
    }

    x: _root.edgeOf === Item.TopLeft || _root.edgeOf === Item.BottomLeft || _root.edgeOf === Item.Left ? 20 : Overlay.overlay.width - 20 - width
    y: _root.edgeOf === Item.TopLeft || _root.edgeOf === Item.TopRight || _root.edgeOf === Item.Top ? 20 : Overlay.overlay.height - 20 - height

    enter: null

    parent: Overlay.overlay
    modal: false
    dim: false
    closePolicy: Popup.NoAutoClose
    visible: listModel.count > 0

    background: Item {}
    contentItem: ListView {
        id: _contentRoot

        implicitWidth: 300
        implicitHeight: Math.max(contentHeight, Size.pixel48)

        verticalLayoutDirection: d.verticalDirection == Item.Top ? ListView.TopToBottom : ListView.BottomToTop
        spacing: Size.pixel4
        interactive: false

        model: ListModel {
            id: listModel
        }

        delegate: Alert {
            id: _alertComponent

            property var item: listModel.get(index)
            property int closeTime: item ? item.closeTime : 0

            width: _contentRoot.width

            text: item && item.text ? item.text : ""
            severity: item && item.severity ? item.severity : severity
            variant: item && item.variant ? item.variant : variant

            dismissButton {
                text: item && item.dismissButton && item.dismissButton.text ? item.dismissButton.text : dismissButton.text
                onClicked: item && item.dismissButton && item.dismissButton.onClicked ? item.dismissButton.onClicked() : function(){
                    _alertComponent.close();
                }
            }

            actionButton {
                text: item && item.actionButton && item.actionButton.text && item.actionButton.text ? item.actionButton.text : actionButton.text
                onClicked: item && item.actionButton && item.actionButton.onClicked ? item.actionButton.onClicked() : null
            }

            onClose: listModel.remove(index)

            Timer {
                id: _timer

                running: visible
                interval: _alertComponent.closeTime

                onTriggered: {
                    if(index >= 0)
                        listModel.remove(index)
                }
            }
        }

        add: Transition {
            NumberAnimation { properties: "x"; from: d.horizontalDirection == Item.Left ? -_contentRoot.width : _contentRoot.width; duration: 500; easing.type: Easing.OutBack }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 500; easing.type: Easing.OutBack }
        }
    }

    QtObject {
        id: d

        property int horizontalDirection: _root.edgeOf === Item.TopLeft || _root.edgeOf === Item.BottomLeft || _root.edgeOf === Item.Left ? Item.Left : Item.Right
        property int verticalDirection: _root.edgeOf === Item.TopLeft || _root.edgeOf === Item.TopRight || _root.edgeOf === Item.Top ? Item.Top : Item.Bottom
    }
}




