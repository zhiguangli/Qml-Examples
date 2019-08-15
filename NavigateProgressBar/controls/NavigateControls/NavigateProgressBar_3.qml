import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3


Item {

    id: root
    property var modelDatas: ["已发货", "运输中" , "派件中" , "已签收" , "已评价"]
    property color foregroundColor: Qt.lighter("#00B2EE")
    property color backgroundColor: Qt.lighter("#8B7E66")

    property string originAddress: qsTr("深圳市")
    property string endAddress: qsTr("上海市")

    property real pointRadius: 15

    implicitWidth:  row.childrenRect.width
    implicitHeight: row.childrenRect.height

    property var __addressTextControls: []
    property int __currentProgressIndex: 0

    Row {
        id: row
        spacing: 0
        leftPadding: 20


        Column {
            id: column
            spacing: 10

            height: modelDataText.height + rect.height + originIndicator.height + addressText.height

            Text {
                id: modelDataText
                width: parent.width
                height: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: modelDatas[0]
                color: (__currentProgressIndex != 0) ? backgroundColor : "#ffffff"
            }

            Rectangle {
                id: rect

                implicitHeight: pointRadius * 2
                implicitWidth: pointRadius * 2
                radius: pointRadius
                color: backgroundColor

                Rectangle {

                    implicitHeight: pointRadius * 2
                    implicitWidth: pointRadius * 2
                    radius: pointRadius
                    anchors.centerIn: parent
                    color: __currentProgressIndex == 0 ? foregroundColor : backgroundColor
                }

                HighlightTextIndicator {
                    id: originIndicator
                    anchors.fill: parent

                    foregroundColor: root.foregroundColor
                    textItem {
                        width: column.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelDatas[0]
                        color: indicatorVisible ? "white" : backgroundColor
                        font.pointSize: 10
                    }

                    indicatorVisible: (__currentProgressIndex === 0)
                }
            }

            Text {
                id: addressText
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: originAddress
                color: backgroundColor
            }
        }

        Repeater {
            model: modelDatas.slice(1)

            RowLayout {

                spacing: 0

                Rectangle {

                    implicitWidth: 120
                    implicitHeight: 4
                    color:backgroundColor
                    Layout.alignment: Qt.AlignBottom
                    Layout.bottomMargin: text.height + pointRadius + column2.spacing
                }

                Column {
                    id: column2
                    spacing: 10

                    Text {
                        height: 30
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: (__currentProgressIndex != index + 1) ? backgroundColor : "#ffffff"
                    }

                    Rectangle {

                        implicitHeight: pointRadius * 2
                        implicitWidth: pointRadius * 2
                        radius: pointRadius
                        color: backgroundColor

                        Rectangle {
                            implicitHeight: pointRadius * 2
                            implicitWidth: pointRadius * 2
                            radius: pointRadius
                            color: (__currentProgressIndex === index + 1) ?  foregroundColor : backgroundColor
                            anchors.centerIn: parent
                        }

                        HighlightTextIndicator {
                            id: otherIndicator

                            anchors.fill: parent

                            foregroundColor: root.foregroundColor
                            textItem {
                                width: column2.width
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: modelData
                                color: indicatorVisible ? "white" : backgroundColor
                                font.pointSize: 10
                            }

                            indicatorVisible: (__currentProgressIndex === index + 1)
                        }
                    }

                    Text {
                        id: text
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "    "
                        color:  backgroundColor
                    }
                }
            }
        }

        Component.onCompleted: {

            __addressTextControls[0] = children[0].children[2];


            for(var i = 1; i < data.length - 1; ++i)
                __addressTextControls[i] = children[i].children[1].children[2];

            __addressTextControls[0].text = originAddress;
            __addressTextControls[__addressTextControls.length - 1].text = endAddress;
        }
    }



    function setCurrentProgressIndex(index) {

        __currentProgressIndex = index + 1;
    }

    function reset() {

        for(var i = 0; i < __addressTextControls.length; ++i)
            __addressTextControls[i].text = "";
        __currentProgressIndex = 0;

        __addressTextControls[0].text = originAddress;
        __addressTextControls[__addressTextControls.length - 1].text = endAddress;
    }
}
