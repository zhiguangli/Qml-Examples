import QtQuick 2.9
import QtQuick.Controls 2.3

Action {
    id: root
    text: ""
    checkable: true
    property int index: 0
    signal actionTriggerd(int i);

    onTriggered:  {
        root.actionTriggerd(index);
    }
}
