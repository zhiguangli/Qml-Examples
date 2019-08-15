import QtQuick 2.7

MouseArea {
    id: root

    property real __lastX: 0
    property real __lastY: 0

    property bool enableMove: true
    property var  target: parent

    onPressed: {
        __lastX = mouseX;
        __lastY = mouseY;
    }

    //修改鼠标样式
    onContainsMouseChanged: cursorShape = containsMouse ? Qt.SizeAllCursor : Qt.ArrowCursor;

    onPositionChanged: {
        if(enableMove && pressed && target) {
            target.x += mouseX - __lastX;
            target.y += mouseY - __lastY;
        }
    }
}
