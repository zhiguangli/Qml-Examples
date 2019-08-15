import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as QtQuickControls_1_4
import "qrc:/QmlControls/Components/BaseComponents/"

Rectangle {
    id: titleBar
    property bool isMaxed: false
    property var  target: parnt

    Row {
        z: 2
        id: controlButtons
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 12
        spacing: 10

        ImageButton {
            width: 12
            height: 12
            imageUrl: "qrc:/images/hamburger_48px.ico"
        }



        ImageButton {
            width: 12
            height: 12

            imageUrl: "qrc:/images/settings_48px.ico"

            onClicked: skinBox.show()//menu.open()

            IndicatorPopup {    //自定义的弹窗，带三角尖尖的那个。
                    id: skinBox
                    barColor: globalConfig.reserverColor
                    backgroundWidth: 280
                    backgroundHeight: 180
                    contentItem: GridView {
                        anchors.fill: parent
                        anchors.margins: 10
                        model: globalConfig.themes
                        cellWidth: 80
                        cellHeight: 80
                        delegate: Item {
                            width: 80
                            height: 80
                            Rectangle { //表示主题色的色块
                                anchors.fill: parent
                                anchors.margins: 4
                                height: width
                                color: model.titleBackground
                            }
                            Rectangle { //主题色边框，鼠标悬浮时显示
                                anchors.fill: parent
                                color: "transparent"
                                border.color: model.titleBackground
                                border.width: 2
                                visible: a.containsMouse
                            }
                            Text {  //主题名字
                                anchors {
                                    left: parent.left
                                    bottom: parent.bottom
                                    leftMargin: 8
                                    bottomMargin: 8
                                }
                                color: "white"
                                text: model.name
                            }
                            Rectangle { //右下角圆圈圈，当前选中的主题
                                x: parent.width - width
                                y: parent.height - height
                                width: 20
                                height: width
                                radius: width / 2
                                color: model.titleBackground
                                border.width: 3
                                border.color: globalConfig.reserverColor
                                visible: globalConfig.currentTheme === index
                            }
                            MouseArea { //鼠标状态
                                id: a
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {    //切主题操作
                                    globalConfig.currentTheme = index
                                }
                            }
                        }
                    }

                }
        }


        ImageButton {
            width: 12
            height: 12
            imageUrl: "qrc:/images/minus_48px.ico"
            onClicked: {
                target.showMinimized()
            }

        }
        ImageButton {
            width: 12
            height: 12
            imageUrl: "qrc:/images/maximise_48px.ico"
            visible: !isMaxed
            onClicked: {
                target.showMaximized()
                isMaxed = true
            }
        }
        ImageButton {
            width: 12
            height: 12
            imageUrl: "qrc:/images/cards_48px.ico"
            visible: isMaxed
            onClicked: {
                target.showNormal()
                isMaxed = false
            }
        }
        ImageButton {
            width: 12
            height: 12
            imageUrl: "qrc:/images/close_48px.ico"
            onClicked: {
                target.close()
            }
        }
    }
}
