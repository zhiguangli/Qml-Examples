#include "screencapture.h"
#include <QDebug>
#include <QQuickView>
#include <QQuickItemGrabResult>
#include <QSharedPointer>
#include <QTimer>
#include <QImage>
#include <QScreen>
#include <QDir>

class ScreenCapturePrivate
{
public:
    QTimer timer;
    QObject *m_currentView;
    ImageProvider *imageProvider;
    ScreenCapture *q;
    QImage image;
    static int sn;


    ScreenCapturePrivate(QObject *view, ScreenCapture *parent)
        : m_currentView(view),
          imageProvider(new ImageProvider(QQuickImageProvider::Image)),
          q(parent)
    {
        QDir dir;
        dir.mkpath("./capture");

        QObject::connect(&timer, &QTimer::timeout, [&] {
            image = qobject_cast<QScreen *>(m_currentView)->grabWindow(0).toImage();
            imageProvider->setImage(image);
            q->imageSourceChange();
        });
    }
};

int ScreenCapturePrivate::sn = 0;

ScreenCapture::ScreenCapture(QObject *parent) : QObject(nullptr), d(new ScreenCapturePrivate(parent, this))
{

}

ScreenCapture::~ScreenCapture()
{
    if(d && d->timer.isActive()) {
        d->timer.stop();
        delete d;
        d = nullptr;
    }
}

bool ScreenCapture::isActive() const
{
    return d->timer.isActive();
}

bool ScreenCapture::isSingleShot() const
{
    return d->timer.isSingleShot();
}

int ScreenCapture::interval() const
{
    return d->timer.interval();
}

QImage ScreenCapture::imageSource() const
{
    return d->image;
}

void ScreenCapture::start()
{
    d->timer.start();
}

void ScreenCapture::start(int msec)
{
    d->timer.start(msec);
}

void ScreenCapture::setSingleShot(bool singleShot)
{
    d->timer.setSingleShot(singleShot);
}

void ScreenCapture::stop()
{
    d->timer.stop();
}

void ScreenCapture::setInterval(int msec)
{
    d->timer.setInterval(msec);
}

void ScreenCapture::save()
{
    d->image.save(QString("./capture/%1.png").arg(d->sn++), "PNG");
}

ImageProvider *ScreenCapture::imageProvider() const
{
    return d->imageProvider;
}

