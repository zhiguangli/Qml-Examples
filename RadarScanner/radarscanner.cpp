#include "radarscanner.h"
#include <QLinearGradient>
#include <QPen>
#include <QPainter>
#include <QTimer>

class RadarScannerPrivate
{
public:
    qreal currAngle = 0;
    qreal scanAngle = 90;
    QTimer timer;


    void updateAngle()
    {
        currAngle += 10;
    }

    void drawPie(const QRect &r, QPainter *painter)
    {
        painter->drawPie(r, int(currAngle * 16), int(scanAngle * 16));
    }
};

RadarScanner::RadarScanner(QQuickItem *parent) : QQuickPaintedItem (parent), d(new RadarScannerPrivate)
{
    connect(&d->timer, &QTimer::timeout, [&]{ d->updateAngle(); update(); });
}

RadarScanner::~RadarScanner()
{
    delete d;
}


void RadarScanner::paint(QPainter *painter)
{
    painter->setRenderHints(QPainter::Antialiasing | QPainter::SmoothPixmapTransform);
    QLinearGradient linearGradient(0,  height(), width(), height());

    linearGradient.setColorAt(0.1, QColor(239, 239, 239));
    linearGradient.setColorAt(0.2, QColor(140, 146, 154));
    linearGradient.setColorAt(0.4, QColor(211, 213, 215));
    linearGradient.setColorAt(0.5, QColor(135, 141, 149));
    linearGradient.setColorAt(0.6, QColor(211, 213, 215));
    linearGradient.setColorAt(0.8, QColor(140, 146, 154));
    linearGradient.setColorAt(1.0, QColor(239, 239, 239));


    int centerX = int(width() / 2);
    int centerY = int(height() / 2);
    int d = width() < height() ? int(width() - 40) : int(height() - 40);

    painter->drawLine(centerX - d / 2, centerY, centerX + d / 2, centerY);
    painter->drawLine(centerX, centerY - d / 2, centerX, centerY + d / 2 );

    int d2 = d - 40;
    painter->setPen(QPen(QBrush(linearGradient), 35));
    painter->drawEllipse(QPoint(centerX, centerY), d / 2, d / 2);
    painter->setPen(QPen(QBrush(Qt::black), 15));
    painter->drawEllipse(QPoint(centerX, centerY), d2 / 2, d2 / 2);

    QLinearGradient linearGradient2(centerX - d / 2 - 100, 0, centerX - d / 2 -100, height());
    linearGradient2.setColorAt(0.1, QColor(130, 241, 255));
    linearGradient2.setColorAt(0.5, QColor(51, 174, 229));
    linearGradient2.setColorAt(1.0, QColor(23, 142, 206));

    int d3 = d - 120;
    int d4 = d - 260;
    painter->setPen(QPen(QBrush(linearGradient2), 5));
    painter->drawEllipse(QPoint(centerX, centerY), d3 / 2, d3 / 2);
    painter->drawEllipse(QPoint(centerX, centerY), d4 / 2, d4 / 2);


    painter->setCompositionMode(QPainter::CompositionMode_SourceOver);

    QRadialGradient radialGrad(QPointF(centerX, centerY), d);
    radialGrad.setColorAt(0.1, QColor(30, 10, 255, 100));
    radialGrad.setColorAt(0.5, QColor(10, 252, 200, 50));
    radialGrad.setColorAt(1.0, QColor(30, 45, 150, 0));

    painter->setPen(QPen(QColor(0, 0, 0, 100), 0));
    painter->setBrush(QBrush(radialGrad));

    QRect rect(int(width() - d2) / 2, int(height() - d2) / 2, d2, d2);
    this->d->drawPie(rect, painter);
}

qreal RadarScanner::scanAngle() const
{
    return d->scanAngle;
}

void RadarScanner::setScanAngle(qreal angle)
{
    d->scanAngle = angle;
}

void RadarScanner::start(int msec)
{
    d->timer.start(msec);
}

void RadarScanner::stop()
{
    d->timer.stop();
}

