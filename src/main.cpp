#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QLoggingCategory>
#include "FileIO.h"

int main(int argc, char *argv[])
{
    // For some reason, the stock file picker is partially broken :D, so it's GTK time until that gets fixed, or maybe forever.
    qputenv("QT_QPA_PLATFORMTHEME", "gtk3");
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");
    qputenv("QML_XHR_ALLOW_FILE_WRITE", "1");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("nineLauncher-v2", "Main");

    return app.exec();
}
