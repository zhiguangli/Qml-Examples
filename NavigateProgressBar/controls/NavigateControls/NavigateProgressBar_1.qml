import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3


Item {

    property var modelDatas: ["创建订单", "审核订单" , "生产" , "配送" , "签收"]
    property color foregroundColor: Qt.lighter("#00B2EE")
    property color backgroundColor: Qt.lighter("#8B7E66")

    implicitWidth:  rect.width + (row.width * (modelDatas.length - 1))
    implicitHeight: rect.height + text.height

    property var __progressBars: []
    property int __currentProgressIndex: 0

    Row {
        id: row
        spacing: -4


        Column {

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

                Text { text: "1"; anchors.centerIn: parent; color: Qt.lighter("white"); font.pointSize: 16}
            }

            Text {
                id: text
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: modelDatas[0]
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
                    Layout.bottomMargin: text.height

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

                        Text { text: index + 2; anchors.centerIn: parent; color: Qt.lighter("white"); font.pointSize: 16}
                    }

                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: (__currentProgressIndex > index) ?  foregroundColor : backgroundColor
                    }
                }
            }
        }

        Component.onCompleted: {
            for(var i = 1; i < data.length - 1; ++i)
                __progressBars[i - 1] = children[i].children[0];

        }
    }


    function setSectionValue(section, value) {
        __progressBars[section].value = value;
        __currentProgressIndex = section;

        for(var i = 0; i < section; ++i)
            __progressBars[i].value = 1.0;

        if(value === 1.0) __currentProgressIndex += 1;
    }

    function reset() {

        for(var i = 0; i < __progressBars.length; ++i)
            __progressBars[i].value = 0;
        __currentProgressIndex = 0;
    }
}
