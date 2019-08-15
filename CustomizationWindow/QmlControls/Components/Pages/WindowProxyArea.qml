import QtQuick 2.0
import "qrc:/QmlControls/Components/BaseComponents/"
import "qrc:/QmlControls/Components/Pages/"

Rectangle {
    id: root
    anchors.fill: parent
    border.width: 1
    border.color: Qt.lighter("gray")
    clip: true

    property var window: undefined
    property alias titleBarItem: titleBar
    property alias isFullScreen: titleBar.isMaxed


    TitleBar {
        id: titleBar
        anchors.top: parent.top
        width: parent.width
        height: 60
        clip: true

        target: window

        MovableArea {
            target: window
            anchors.fill: parent

            onDoubleClicked: {
                if(titleBar.isMaxed){
                    window.showNormal();
                    titleBar.isMaxed = false;
                } else {
                    window.showMaximized();
                    titleBar.isMaxed = true;
                }
            }
        }
    }



    ResizeBorderArea {
        target: window
        anchors.fill: parent
        color: 'transparent'
    }

}
