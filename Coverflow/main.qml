import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 960
    height: 640
    title: qsTr("Coverflow")


    Coverflow { anchors.fill: parent }
}
