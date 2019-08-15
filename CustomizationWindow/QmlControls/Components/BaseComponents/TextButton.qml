import QtQuick 2.9
import QtQuick.Controls 2.0

Rectangle {
    id: root
    color: "transparent"
    z: 3

    property alias textItem: _text
    property alias text: _text.text
    property alias textColor: _text.color
    property alias containsMouse: _mouseArea.containsMouse
    property alias containsPress: _mouseArea.containsPress

    signal clicked()

    Text {
        id: _text
        text: qsTr("text")
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        hoverEnabled: parent.enabled
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
