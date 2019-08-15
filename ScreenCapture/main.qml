import QtQuick 2.7
import QtQuick.Controls 2.0
import com.zgl.qmlcomponents 1.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480
    title: qsTr("Screen Capture")

    //录屏
    Rectangle {
        anchors.fill: parent


        Text {
            anchors.centerIn: parent
            text: qsTr("Click Me")
        }


        Image {
            id: image
            anchors.fill: parent
            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    screenCapture.isActive ? screenCapture.stop() : screenCapture.start(10);
                }
            }

            source: "image://ImageSource/"
        }

        Connections {
            target: screenCapture
            onImageSourceChange: {
                image.source = "image://ImageSource/" + Math.random()
            }
        }

        Button {
            text: qsTr("save")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            onClicked: screenCapture.save();
        }
    }
}
