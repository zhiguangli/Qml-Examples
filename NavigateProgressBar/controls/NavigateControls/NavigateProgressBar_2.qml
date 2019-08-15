import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3


Item {

    property var modelDatas: ["拍下商品", "付款到支付宝" , "卖家发货" , "确认收货" , "评价"]
    property color foregroundColor: Qt.lighter("#00B2EE")
    property color backgroundColor: Qt.lighter("#8B7E66")

    implicitWidth:  rect.width + (row.width * (modelDatas.length - 1))
    implicitHeight: column.height

    property var __progressBars: []
    property var __dateTextControls: []
    property int __currentProgressIndex: 0

    Row {
        id: row
        spacing: -4


        Column {
            id: column
            Text {
                id: detailText
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: modelDatas[0]
                color: backgroundColor
            }

            Rectangle {
                id: rect
                implicitHeight: 60
                implicitWidth: 60
                radius: width / 2
                color: backgroundColor

                Rectangle {

                    implicitHeight: 54
                    implicitWidth: 54
                    radius: width / 2
                    anchors.centerIn: parent
                    color: foregroundColor
                }

                Text {
                    text: "\u2713";
                    anchors.centerIn: parent;
                    color: Qt.lighter("white");
                    font.pointSize: 16
                }
            }

            Text {
                id: dateText
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: ""
                color: foregroundColor
            }
        }

        Repeater {
            model: modelDatas.slice(1)

            RowLayout {
                spacing: -4

                ProgressBar {
                    id: control
                    z: 2
                    value: 0.0

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 6
                        color:backgroundColor
                    }

                    contentItem: Item {
                        implicitWidth: 100
                        implicitHeight: 4

                        Rectangle {
                            width: control.visualPosition * parent.width
                            height: parent.height
                            color: foregroundColor
                        }
                    }
                }

                Column {
                    spacing: 2

                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: backgroundColor
                    }

                    Rectangle {
                        implicitHeight: 60
                        implicitWidth: 60
                        radius: width / 2
                        color: backgroundColor

                        Rectangle {
                            implicitHeight: 54
                            implicitWidth: 54
                            radius: width / 2
                            color: (__currentProgressIndex > index) ?  foregroundColor : backgroundColor
                            anchors.centerIn: parent
                        }

                        Text {
                            text: (__currentProgressIndex > index) ? "\u2713" : index + 2;
                            anchors.centerIn: parent;
                            color: Qt.lighter("white");
                            font.pointSize: 16
                        }
                    }

                    Text {
                        id: dateTimeText
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: ""
                        color: (__currentProgressIndex > index) ?  foregroundColor : backgroundColor
                    }
                }
            }
        }

        Component.onCompleted: {

            __dateTextControls[0] = children[0].children[2];

            var date = new Date();
            __dateTextControls[0].text = date.toLocaleDateString();

            for(var i = 1; i < data.length - 1; ++i) {
                __progressBars[i - 1] = children[i].children[0];
                __dateTextControls[i] = children[i].children[1].children[2];
            }
        }
    }


    function setSectionDateTime(i, dateString) {
        __dateTextControls[i].text = dateString;
    }

    function setSectionValue(section, value) {
        __progressBars[section].value = value;
        __currentProgressIndex = section;

        for(var i = 0; i < section; ++i)
            __progressBars[i].value = 1.0;

        if(value === 1.0) __currentProgressIndex += 1;
    }

    function reset() {

        for(var i = 0; i < __dateTextControls.length; ++i)
            __dateTextControls[i].text = "";
        for(var j = 0; j < __progressBars.length; ++j)
            __progressBars[j].value = 0;
        __currentProgressIndex = 0;

        var date = new Date();
        __dateTextControls[0].text = date.toLocaleDateString();
    }
}
