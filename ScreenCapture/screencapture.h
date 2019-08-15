#ifndef SCREENCAPTURE_H
#define SCREENCAPTURE_H

#include <QObject>
#include <QImage>
#include "imageprovider.h"

class ScreenCapturePrivate;

class ScreenCapture : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isActive READ isActive)
    Q_PROPERTY(bool isSingleShot READ isSingleShot)
    Q_PROPERTY(int  interval READ interval WRITE setInterval)

public:
    explicit ScreenCapture(QObject *parent = nullptr);
    ~ScreenCapture();

    Q_INVOKABLE void start();
    Q_INVOKABLE void start(int msec);
    Q_INVOKABLE void setInterval(int msec);
    Q_INVOKABLE void setSingleShot(bool singleShot);
    Q_INVOKABLE void stop();
    Q_INVOKABLE void save();

    bool isActive() const;
    bool isSingleShot() const;
    int  interval() const;
    QImage imageSource() const;
    ImageProvider *imageProvider() const;

Q_SIGNALS:
    void imageSourceChange();

private:
   ScreenCapturePrivate *d;
};

#endif // SCREENCAPTURE_H
