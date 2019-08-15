import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/controls/NavigateControls/"
import QtQml 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Row {
        id: row
        x: (parent.width - width) / 2
        Repeater {
            model: 4
                Column {

                    Button {
                        id: control
                        text: (index + 1) + " -> 50%"
                        onClicked: {

                            progressBar.setSectionValue(index, 0.5);
                            progressBar2.setSectionValue(index, 0.5);
                            progressBar3.setSectionValue(index, 0.5);
                            progressBar4.setSectionValue(index, 0.5);
                        }

                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            border.color: control.down ? "#17a81a" : "#21be2b"
                            border.width: 1
                            radius: 2
                        }
                    }
                    Button {
                        id: control1
                        text: (index + 1) + " -> 100%"
                        onClicked:{

                            progressBar.setSectionValue(index, 1.0);
                            progressBar2.setSectionValue(index, 1.0);

                            var date = new Date();
                            progressBar3.setSectionValue(index, 1.0);
                            progressBar3.setSectionDateTime(index + 1, date.toLocaleDateString());
                            progressBar4.setSectionValue(index, 1.0);
                            progressBar4.setSectionDateTime(index + 1, date.toLocaleDateString());
                            progressBar5.setCurrentProgressIndex(index);
                            progressBar6.setCurrentProgressIndex(index);
                        }

                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            border.color: control1.down ? "#17a81a" : "#21be2b"
                            border.width: 1
                            radius: 2
                        }
                    }
            }
        }
    }

    Button {
        id: resetBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: row.bottom
        text: qsTr("重置")
        onClicked: {
            progressBar.reset();
            progressBar2.reset();
            progressBar3.reset();
            progressBar4.reset();
            progressBar5.reset();
            progressBar6.reset();
        }
    }


    Column {
        id: column
        spacing: 50
        x: 200
        y: 150
        NavigateProgressBar_1 {
            id: progressBar

        }
        NavigateProgressBar_1 {
            id: progressBar2
            foregroundColor: Qt.lighter("green")
        }
        NavigateProgressBar_2 {
            id: progressBar3
        }
        NavigateProgressBar_2 {
            id: progressBar4
            modelDatas: ["拍下商品", "付款到微信" , "卖家发货" , "确认收货" , "评价"]
            foregroundColor: Qt.lighter("green")
        }
        NavigateProgressBar_3 {
            id: progressBar5
        }
        NavigateProgressBar_3 {
            id: progressBar6
            foregroundColor: Qt.lighter("green")
        }
    }
}
