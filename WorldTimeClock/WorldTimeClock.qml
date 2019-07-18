import QtQuick 2.0
import QtQml 2.2
import QtQuick 2.7
import QtQuick 2.10

Canvas {
    id: canvas
    anchors.fill: parent

    property string hourColor:   "#B23AEE"
    property string minuteColor: "#43CD80"
    property string secondColor: "#B8860B"

    Timer {
        id: timer
        property int hour;
        property int minute;
        property int second;

        interval: 500; running: true; repeat: true

        onTriggered: {
            var date = new Date();
            hour = date.getHours();
            minute = date.getMinutes();
            second = date.getSeconds();

            canvas.requestPaint();
        }
    }

    onPaint: {

        var ctx = getContext("2d");

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        drawScaleValue(ctx);                                //绘制刻度
        drawClockHand(ctx, 1);                              //绘制时针
        drawClockHand(ctx, 2);                              //绘制分针
        drawClockHand(ctx, 3);                              //绘制秒针
    }

    function drawClockHand(ctx, handType) {

        ctx.save();

        ctx.globalCompositeOperation = "source-over";
        ctx.translate(centerPoint().x, centerPoint().y);

        var angle = 0;
        var handPoint1 = Qt.point(7, 8);
        var handPoint2 = Qt.point(-7,8);
        var handPoint3 = Qt.point(0, -80);

        switch(handType)
        {
        case 1:
            ctx.fillStyle = hourColor;
            angle = deg2Rad(30.0 * (timer.hour + timer.minute / 60.0));
            break;
        case 2:
            ctx.fillStyle = minuteColor;
            angle = deg2Rad(6.0 * timer.minute);
            handPoint3.x = 0; handPoint3.y = -130;
            break;
        case 3:
            ctx.fillStyle = secondColor;
            angle = deg2Rad(6.0 * timer.second);
            handPoint3.x = 0; handPoint3.y = -180;
            break;
        }

        ctx.rotate(angle);
        ctx.beginPath();
        ctx.moveTo(handPoint1.x, handPoint1.y);
        ctx.lineTo(handPoint2.x, handPoint2.y);
        ctx.lineTo(handPoint3.x, handPoint3.y);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
        ctx.restore();
    }

    function deg2Rad(deg) {
        return (deg / 180) * Math.PI;
    }

    function centerPoint() {
        return Qt.point(width / 2, height / 2);
    }


    function drawScaleValue(ctx) {

        for(var i = 0; i < 360; i += 6) {
            ctx.save();

            ctx.lineWidth = 3;

            var margin = 30;

            var centerX = centerPoint().x;
            var centerY = centerPoint().y;
            var isHour = ((i % 30) == 0);
            var radius =  centerX < centerY ? (centerX - margin) : (centerY - margin);
            var point = Qt.point(0, 0);

            ctx.strokeStyle = isHour ? canvas.hourColor : canvas.minuteColor;
            ctx.translate(centerX, centerY);
            ctx.rotate(deg2Rad(i));
            ctx.beginPath();
            ctx.moveTo(radius, 0);
            if(isHour)
                ctx.lineTo(radius - 20, 0)
            else
                ctx.lineTo(radius - 10, 0)
            ctx.stroke();
            ctx.restore();
        }
    }
}
