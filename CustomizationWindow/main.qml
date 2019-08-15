import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import "qrc:/QmlControls/Components/Pages/"
import "qrc:/QmlControls/Components/BaseComponents/ProgressBars/"


ApplicationWindow {
    id: root
    visible: true
    width: 960
    height: 640
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "#00000000" //主窗口透明

    Column {
        anchors.centerIn: parent

        RadioButton { text: qsTr("Small") }
        RadioButton { text: qsTr("Medium");  checked: true }
        RadioButton { text: qsTr("Large") }
    }

    DropShadow {
        anchors.fill: windowProxy
        horizontalOffset: -5
        verticalOffset: -5
        radius: 20
        samples: 25
        color: "#20000000"
        spread: 0.0
        source: windowProxy
    }

    DropShadow {
        anchors.fill: windowProxy
        horizontalOffset: 5
        verticalOffset: 5
        radius: 20
        samples: 25
        color: "#20000000"
        spread: 0.0
        source: windowProxy
    }

    GlobalConfig {
        id: globalConfig
    }

    WindowProxyArea {
        id: windowProxy
        window: root
        anchors.fill: parent
        anchors.margins: isFullScreen ? 0 : 5
        radius: 5

        titleBarItem.color: globalConfig.titleBackground


        Material.theme: Material.Dark
        Material.accent: Material.Purple

        Column {
            anchors.centerIn: parent

            RadioButton {
                id: smallBtn
                text: qsTr("Small");
                checked: true

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: smallBtn.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: globalConfig.titleBackground

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: globalConfig.titleBackground
                        visible: smallBtn.checked
                    }
                }

                contentItem: Text {
                    text: smallBtn.text
                    font: smallBtn.font
                    opacity: enabled ? 1.0 : 0.3
                    color: globalConfig.titleBackground
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: smallBtn.indicator.width + smallBtn.spacing
                }
            }
            RadioButton {
                id: mediumBtn
                text: qsTr("Medium");
                checked: true

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: mediumBtn.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: globalConfig.titleBackground

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: globalConfig.titleBackground
                        visible: mediumBtn.checked
                    }
                }

                contentItem: Text {
                    text: mediumBtn.text
                    font: mediumBtn.font
                    opacity: enabled ? 1.0 : 0.3
                    color: globalConfig.titleBackground
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: mediumBtn.indicator.width + mediumBtn.spacing
                }
            }
            RadioButton {
                id: largeBtn
                text: qsTr("Large")

                checked: true



                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: largeBtn.leftPadding
                    y: (parent.height - height) / 2
                    radius: 13
                    border.color: globalConfig.titleBackground

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: globalConfig.titleBackground
                        visible: largeBtn.checked
                    }
                }

                contentItem: Text {
                    text: largeBtn.text
                    font: largeBtn.font
                    opacity: enabled ? 1.0 : 0.3
                    color: globalConfig.titleBackground
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: largeBtn.indicator.width + largeBtn.spacing
                }
            }

            RingProgressBar {
                id: rprogressBar
            }
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: rprogressBar.percent += 10

    }
}
