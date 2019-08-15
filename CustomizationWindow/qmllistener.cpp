#include "qmllistener.h"
#include "qmllistener_p.h"
#include <QFileInfo>

QmlListener::QmlListener(QObject *parent) : QObject(parent), d_ptr(new QmlListenerPrivate(this))
{

}

void QmlListener::clear()
{
    Q_D(QmlListener);
    d->clear();
}

QString QmlListener::url() const
{
    return d_ptr->url();
}

void QmlListener::setUrl(const QString &url)
{
    Q_D(QmlListener);
    d->setUrl(url);
}

void QmlListener::setQQmlApplicationEngine(QQmlApplicationEngine *engine)
{
    Q_D(QmlListener);

    d->engine = engine;
}

QmlListenerPrivate::QmlListenerPrivate(QmlListener *parent) : q_ptr(parent)
{
    QObject::connect(&fileSystemWatcher, &QFileSystemWatcher::fileChanged, this, &QmlListenerPrivate::onFileChanged);
}

void QmlListenerPrivate::clear()
{
    this->engine->trimComponentCache();
    this->engine->clearComponentCache();
}

void QmlListenerPrivate::onFileChanged(QString file)
{
    Q_UNUSED(file);
    Q_Q(QmlListener);

    for (const auto &file : monitorFiles)
        fileSystemWatcher.addPath(file);

    q->urlChanged();
}

void QmlListenerPrivate::setUrl(const QString &url)
{
    QString file = url;
#ifdef Q_OS_WIN
    QFileInfo fileInfo(file.remove("file:///"));
#elif Q_OS_UNIX
    QFileInfo fileInfo(file.remove("file://"));
#endif

    Q_Q(QmlListener);

    if(fileInfo.isFile()) {
        fileSystemWatcher.addPath(file);
        if(!monitorFiles.contains(file))
            monitorFiles.append(file);
        this->urlPath = url;
        emit q->urlChanged();
    }
}

QString QmlListenerPrivate::url() const
{
    return this->urlPath;
}
