import QtQuick 2.9

Rectangle {
    id: root
    PathView {
        id: pathView
        anchors.fill: parent

        delegate: flipCardDelegate
        model: 100
        path: Path {
            startX: 0
            startY: root.height / 2
            PathAttribute { name: "itemZ"; value: 50 }
            PathAttribute { name: "itemAngle"; value: +90.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathLine { x: root.width * 0.4; y: root.height / 2; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width * 0.5; y: root.height / 2; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width * 0.6; y: root.height / 2; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width; y: root.height / 2; }
            PathAttribute { name: "itemAngle"; value: -90.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 50 }
        }
        pathItemCount: 8

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }



    Component {
        id: flipCardDelegate

        Rectangle {
            id: wrapper

            width: 400
            height: 400
            antialiasing: true
            border.width: 2
            border.color: "gray"


            property var gradients: ["#2ed5fa", "#2467ec", "#68228B", "#43CD80", "#6E8B3D", "#7D26CD", "#7CCD7C"]

            gradient: Gradient {
                GradientStop { position: 0.0; color: gradients[Math.floor(Math.random() * 7)] }
                GradientStop { position: 1.0; color: gradients[Math.floor(Math.random() * 7)] }
            }


            visible: PathView.onPath

            scale: PathView.itemScale
            z: PathView.itemZ

            property variant rotX: PathView.itemAngle
            transform: Rotation {
                axis { x: 0; y: 1; z: 0 }
                angle: wrapper.rotX;
                origin { x: 200; y: 200; }
            }
            Text {
                anchors.centerIn: parent
                font { pointSize: 64 }
                text: index
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: pathView.currentIndex = index
            }
        }
    }
}








