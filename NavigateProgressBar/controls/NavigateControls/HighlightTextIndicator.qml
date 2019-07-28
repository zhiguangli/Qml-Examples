import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent

    property alias textItem: text
    property bool selected: false
    property color foregroundColor: Qt.lighter("#00B2EE")
    property color backgroundColor: Qt.lighter("#8B7E66")
    property alias indicatorVisible: toolTip.visible

    property real backgroundWidth: 90
    property real backgroundHeight: 30

    property real verticalOffset: 16

    Rectangle {
        id: indicator
        color: indicatorVisible ? foregroundColor : backgroundColor
        width: 16;
        height: 16;
        rotation: 45

        visible: toolTip.visible

        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: -verticalOffset
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Rectangle {
        id: toolTip
        radius: 10;
        width: backgroundWidth; height: backgroundHeight
        border.color: backgroundColor
        border.width: 0
        color: indicatorVisible ? foregroundColor : backgroundColor

        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: -(verticalOffset + indicator.height)
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: text
            anchors.centerIn: parent
        }
    }

    function show() {
        toolTip.x = root.x + (root.width - toolTip.width) / 2;
        toolTip.y =  - (verticalOffset + toolTip.height + indicator.height);
        toolTip.visible = true
    }

    function hide() {
        toolTip.visible = false;
    }
}
