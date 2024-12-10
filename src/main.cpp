#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QLoggingCategory>
#include <QQuickStyle>
#include "FileIO.h"
#include "GameLauncher.h"

int main(int argc, char *argv[])
{
    // For some reason, the stock file picker is partially broken :D, so it's GTK time until that gets fixed, or maybe forever.
    qputenv("QT_QPA_PLATFORMTHEME", "gtk3");
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");
    QGuiApplication app(argc, argv);
    app.setOrganizationName("wearr");
    app.setOrganizationDomain("wearr.dev");
    app.setApplicationName("NineLauncher");

    QQmlApplicationEngine engine;

    engine.addImportPath(":/MMaterial");
    engine.addImportPath("qrc:/");
    QQuickStyle::setStyle("Material");

    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    qmlRegisterType<GameLauncher>("GameLauncher", 1, 0, "GameLauncher");


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("nineLauncher", "Main");

    int ret = app.exec();

    return ret;
}
