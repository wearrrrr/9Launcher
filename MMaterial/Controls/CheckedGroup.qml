import QtQuick

//Has to have clicked signal and checked property

QtObject {
    id: _root

	property bool enabled: true
    property var checkables: []
    property var checkedButton: null

    function check(clickedCheckable: Checkable) : void{
        for(let checkable of _root.checkables)
            if(checkable !== clickedCheckable)
                checkable.checked = false;

        _root.checkedButton = clickedCheckable;
    }

    Component.onCompleted: {
		if(!_root.enabled)
            return;

        _root.checkables = _root.checkables.filter(item => item.checked !== undefined && item.onClicked !== undefined);

        for(let checkable of _root.checkables){
            checkable.onClicked.connect(check.bind(null, checkable));
            if(checkable.checked)
                _root.checkedButton = checkable;
        }
    }
}

