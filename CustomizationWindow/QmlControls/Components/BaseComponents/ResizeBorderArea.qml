import QtQuick 2.7


Rectangle {
    id: root
    color: "transparent"
//    border.width: 4
//    border.color: "black"
    width: parent.width
    height: parent.height

    property var target: parent
    DragArea {
        id: topLeftDragArea
        dragOrientation: topLeftCorner
        onPositionChanged: {
            //不要简化这个判断条件，至少让以后维护的人能看懂。化简过后我自己都看不懂了。
            if (target.x + xOffset < target.x + target.width)
                target.x += xOffset;
            if (target.y + yOffset < target.y + target.height)
                target.y += yOffset;
            if (target.width - xOffset > 0)
                target.width-= xOffset;
            if (target.height -yOffset > 0)
                target.height -= yOffset;
        }
    }
    DragArea {
        dragOrientation: topEdge
        x: (parent.width - width) / 2
        onPositionChanged: {
            if (target.y + yOffset < target.y + target.height)
                target.y += yOffset;
            if (target.height - yOffset > 0)
                target.height -= yOffset;
        }
    }
    DragArea {
        dragOrientation: topRightCorner
        x: parent.width - width
        onPositionChanged: {            if (target.width + xOffset > 0)
                target.width += xOffset;
            if (target.height - yOffset > 0)
                target.height -= yOffset;
            if (target.y + yOffset < target.y + target.height)
                target.y += yOffset;
            //向左拖动时，xOffset为负数

        }
    }
    DragArea {
        dragOrientation: leftEdge
        y: (parent.height - height) / 2
        onPositionChanged: {
            if (target.x + xOffset < target.x + target.width)
                target.x += xOffset;
            if (target.width - xOffset > 0)
                target.width-= xOffset;
        }
    }
    DragArea {
        dragOrientation: rightEdge
        x: parent.width - width
        y: (parent.height - height) / 2
        onPositionChanged: {
            if (target.width + xOffset > 0)
                target.width += xOffset;
        }
    }
    DragArea {
        dragOrientation: bottomLeftCorner
        y: parent.height - height
        onPositionChanged: {
            if (target.x + xOffset < target.x + target.width)
                target.x += xOffset;
            if (target.width - xOffset > 0)
                target.width-= xOffset;
            if (target.height + yOffset > 0)
                target.height += yOffset;
        }
    }
    DragArea {
        dragOrientation: bottomEdge
        x: (parent.width - width) / 2
        y: parent.height - height
        onPositionChanged: {
            if (target.height + yOffset > 0)
                target.height += yOffset;
        }
    }
    DragArea {
        dragOrientation: bottomRightCorner
        x: parent.width - width
        y: parent.height - height
        onPositionChanged: {
            if (target.width + xOffset > 0)
                target.width += xOffset;
            if (target.height + yOffset > 0)
                target.height += yOffset;
        }
    }
}
