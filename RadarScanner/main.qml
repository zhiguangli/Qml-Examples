import QtQuick 2.9
import QtQuick.Window 2.2
import com.zgl.qmlcomponents 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scanner")

    RadarScanner {
        id: scanner
        anchors.fill: parent
        Component.onCompleted: scanner.start(100)
    }
}
