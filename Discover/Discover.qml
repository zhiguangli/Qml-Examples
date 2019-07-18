import QtQuick 2.0
import QtQuick.Controls 2.3

Item {
    id: root
    clip: true

    Canvas
    {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        property bool drawable: false;
        property bool first: true;
        property real r: Math.sqrt(Math.pow(width / 2, 2) + Math.pow(height / 2, 2));
        property real r1: 0;
        property real r2: r / 2;
        property var positions: [Qt.point(80, 190), Qt.point(180, 90),
                                 Qt.point(280, 390), Qt.point(480, 90),
                                 Qt.point(80, 590)]

        function clear() {
            first = true;
            r1 = 0;
            r2 = r / 2;
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
        }

        function drawLine(ctx, color, width, startX, startY, endX, endY) {
            ctx.strokeStyle = color;
            ctx.lineWidth = width;
            ctx.beginPath();
            ctx.moveTo(startX, startY);
            ctx.lineTo(endX, endY);
            ctx.closePath();
            ctx.stroke();
        }


        Timer {
            id: timer
            interval: 16
            running: false
            repeat: true
            onTriggered: canvas.requestPaint();
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = "#10FFFFFF";
            ctx.fillRect(0, 0, width, height);

            //绘制网格竖线
            for(var i = 0; i < width; i += 20)
                drawLine(ctx, "#7266fc", 0.5,i + 0.5, 0, i + 0.5, height);
            //绘制网格横线
            for(var j = 0; j < height; j += 20)
                drawLine(ctx, "#7266fc", 0.5, 0, j + 0.5, width, j + 0.5);

            //绘制地图标记
            positions.forEach(function(point, i) {
                ctx.drawImage("qrc:/images/map_marker.ico", point.x, point.y);
            });

            if (drawable) {

                var halfWidth = width / 2;
                var halfHeight = height / 2;

                ctx.lineWidth = 2;
                ctx.strokeStyle = "#72d6fc";

                //绘制扫描圆
                for(var k = 0; k < 5; k += 0.5) {
                    ctx.beginPath();
                    ctx.arc(halfWidth, halfHeight, r1 + k, 0, Math.PI * 2);
                    ctx.closePath();
                    ctx.stroke();

                    ctx.beginPath();
                    if(!first) ctx.arc(halfWidth, halfHeight, r2 + k, 0, Math.PI * 2);
                    ctx.closePath();
                    ctx.stroke();
                }

                if(r1 > r) r1 = 0;

                if(r2 > r) {
                    r2 = 0;
                    if(first) first = false;
                }

                r1 += 3;
                r2 += 3;
            }
        }
    }

    RoundButton {
        text: qsTr("scan")
        anchors.centerIn: parent
        onClicked: {
            canvas.clear();
            canvas.drawable = true;
            timer.restart();
        }
    }
}
