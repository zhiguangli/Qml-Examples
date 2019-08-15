#ifndef QMLLISTENER_P_H
#define QMLLISTENER_P_H

#include <QQmlApplicationEngine>
#include <QFileSystemWatcher>


class QmlListener;
class QQmlApplicationEngine;

class QmlListenerPrivate
{
    Q_DECLARE_PUBLIC(QmlListener)

public:

    QmlListenerPrivate(QmlListener *parent);

    void clear();
    void onFileChanged(QString file);

    void setUrl(const QString &url);
    QString url() const;

    QFileSystemWatcher fileSystemWatcher;
    QQmlApplicationEngine *engine;

private:
    QString urlPath;
    QStringList monitorFiles;
    QmlListener *q_ptr;
};

#endif // QMLLISTENER_P_H
