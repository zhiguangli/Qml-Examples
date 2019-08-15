#ifndef RADARSCANNER_Hvoid
#define RADARSCANNER_H

#include <QQuickPaintedItem>
#include <QQuickItem>

class RadarScannerPrivate;

class RadarScanner : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(qreal scanAngle READ scanAngle WRITE setScanAngle)

public:
    RadarScanner(QQuickItem *parent = nullptr);
    ~RadarScanner() override;

    void paint(QPainter *painter) override;

    Q_INVOKABLE qreal scanAngle() const;
    Q_INVOKABLE void  setScanAngle(qreal angle = 90);

    Q_INVOKABLE void start(int msec = 500);
    Q_INVOKABLE void stop();

private:
    RadarScannerPrivate *d;
};

#endif // RADARSCANNER_H
