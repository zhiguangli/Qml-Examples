#ifndef QMLLISTENER_H
#define QMLLISTENER_H

#include <QObject>
#include <QScopedPointer>



class QQmlApplicationEngine;
class QmlListenerPrivate;

class QmlListener : public QObject
{
    Q_OBJECT

    Q_DISABLE_COPY(QmlListener)
    Q_DECLARE_PRIVATE(QmlListener)

    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    explicit QmlListener(QObject *parent = nullptr);

    Q_INVOKABLE void clear();

    QString url() const;
    void setUrl(const QString &url);
    void setQQmlApplicationEngine(QQmlApplicationEngine *engine);

signals:
    void urlChanged();

public Q_SLOTS:

private:
   QScopedPointer<QmlListenerPrivate> d_ptr;
};

#endif // QMLLISTENER_H
