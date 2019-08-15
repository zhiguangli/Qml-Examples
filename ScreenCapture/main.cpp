#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QScopedPointer>
#include <QQmlContext>
#include <QQuickPaintedItem>
#include <QQuickView>
#include <QQuickImageProvider>
#include <QScreen>
#include <QPixmap>
#include "screencapture.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    qmlRegisterType<ScreenCapture>("com.zgl.qmlcomponents", 1, 0, "ScreenCapture");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QScopedPointer<ScreenCapture> screenCaptrue(new ScreenCapture(QGuiApplication::primaryScreen()));
    engine.rootContext()->setContextProperty("screenCapture", screenCaptrue.data());
    engine.addImageProvider(QLatin1String("ImageSource"), screenCaptrue->imageProvider());

    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
