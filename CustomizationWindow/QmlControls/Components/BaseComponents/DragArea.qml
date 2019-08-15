import QtQuick 2.9
import QtQuick.Controls 2.0


Item {
    id: root

    implicitWidth: 12       //隐式宽为12
    implicitHeight: 12      //隐式高为12

    property alias containsMouse: mouseArea.containsMouse

    signal positionChanged(int xOffset, int yOffset)


    readonly property int topLeftCorner: Qt.SizeFDiagCursor
    readonly property int topRightCorner: Qt.SizeBDiagCursor
    readonly property int bottomLeftCorner: Qt.SizeBDiagCursor
    readonly property int bottomRightCorner: Qt.SizeFDiagCursor
    readonly property int topEdge: Qt.SizeVerCursor
    readonly property int leftEdge: Qt.SizeHorCursor
    readonly property int rightEdge: Qt.SizeHorCursor
    readonly property int bottomEdge: Qt.SizeVerCursor

    property int dragOrientation: Qt.ArrowCursor

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property int lastX: 0
        property int lastY: 0

        onPressedChanged: {
            if(containsPress) {
                lastX = mouseX;
                lastY = mouseY;
            }
        }

        onContainsMouseChanged: cursorShape = mouseArea.containsMouse ? dragOrientation : Qt.ArrowCursor;


        onPositionChanged: {
            if(pressed)
                root.positionChanged(mouseX - lastX, mouseY - lastY);
        }
    }
}
