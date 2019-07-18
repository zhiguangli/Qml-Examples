import QtQuick 2.0
import QtQuick.Controls 2.3

ListView {
    id: root

    anchors.fill: parent

    property bool isPullOn: false
    property bool isDropDown: false
    property int  loadDuration: 2500
    signal load();              //下拉更新
    signal loadMore();          //上拉加载

    property double bottomContentY: 0.0;
    interactive: true


    Rectangle {
        id: loadTip
        width: parent.width
        height: -root.contentY
        color: Qt.lighter("green")
        z: -2
        clip: true

        Text {
            anchors.top: loadImage.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("loading")
            font.pointSize: 10
            color: Qt.lighter("white")
        }

        Image {
            id: loadImage
            source: "qrc:/images/loading.ico"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: loadMoreTip
        width: parent.width
        anchors.bottom: root.bottom
        height: 65
        z: -2
        clip: true

        Text {
            anchors.top: loadMoreImage.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Load More")
            font.pointSize: 8
            color: Qt.lighter("white")
        }

        Image {
            id: loadMoreImage
            source: "qrc:/images/loading.ico"
            anchors.centerIn: parent
            sourceSize: Qt.size(parent.height, parent.height)
        }
    }

    ParallelAnimation {
        id: dropDownAnimation
        NumberAnimation {
            target:  root
            property: "contentY"
            to: -100;
            duration: 1
        }

        SequentialAnimation {
            RotationAnimation {
                target: loadImage
                from: 0
                to: 360
                duration: loadDuration
            }
            NumberAnimation {
                target: root
                property: "contentY"
                to: 0
                duration: 100
            }
        }

        onStopped: {root.load(); isDropDown = false; }
    }

    ParallelAnimation {
        id: pullOnAnimation



        NumberAnimation {
            target:  root
            property: "contentY"
            to: root.bottomContentY + 65;
            duration: 100
        }

        SequentialAnimation {
            RotationAnimation {
                target: loadMoreImage
                from: 0
                to: 360
                duration: 1000
            }
            NumberAnimation {
                target: root
                property: "contentY"
                to: root.bottomContentY;
                duration: 100
            }
        }

        onStopped: { root.loadMore(); isPullOn = false; root.positionViewAtIndex(root.count - 1, ListView.Beginning); }
    }

    onIsPullOnChanged: {
        if(root.isPullOn)
            pullOnAnimation.restart();
    }


    onContentYChanged: {
        if( (root.height - Math.abs(contentY - contentHeight)) < 1.5
            && (root.height - Math.abs(contentY - contentHeight) ) > -1.5)
            root.bottomContentY = contentY;
    }

    onIsDropDownChanged: {
        if(isDropDown && !dropDownAnimation.running && (-contentY > 100.0))
            dropDownAnimation.restart();
    }

    onFlickingChanged: {
        if(!isDropDown && (-contentY > 100.0))
            isDropDown = true;

        if(!isPullOn && ((height - Math.abs(contentY - contentHeight)) > 65.0)) {
            isPullOn = true;
        }
    }
}
