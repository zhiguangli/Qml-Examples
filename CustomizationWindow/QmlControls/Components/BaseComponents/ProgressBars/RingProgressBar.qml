import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {

    id: root

    property real percent: 0.0

    Rectangle {
        id: background
        anchors.fill: parent
        color: 'transparent'

        Canvas {
            anchors.fill: parent

            onPaint: {

            }
        }
    }
}
