#include "GameLauncher.h"
#include <QtDebug>
#include <QUrl>
#include <QString>
#include <QThread>
#include <QProcess>
#include <unistd.h>

GameLauncher::GameLauncher(QObject *parent) : QObject(parent) {}

bool GameLauncher::LaunchThread(const QString &gamePath, const QString &gameCWD)
{
    #ifdef Q_OS_LINUX
    return LaunchLinux(gamePath, gameCWD);
    #endif
}

Q_INVOKABLE bool GameLauncher::launchGame(const QString &gamePath, const QString &gameCWD)
{
    const QString localPath = QUrl(gamePath).toLocalFile();
    const QString localCWD = QUrl(gameCWD).toLocalFile();

    // Run LaunchThread in a separate thread
    QThread *thread = new QThread;
    connect(thread, &QThread::started, [=]() {
        if (!LaunchThread(localPath, localCWD))
        {
            qCritical() << "[9L] Failed to launch game!";
        }
        thread->quit();
    });
    connect(thread, &QThread::finished, thread, &QThread::deleteLater);
    thread->start();

    return true;
}

bool GameLauncher::LaunchLinux(const QString &gamePath, const QString &gameCWD) {
    #ifdef Q_OS_LINUX
    qInfo() << "Launching game on Linux";

    QProcess process;
    process.setProgram("wine");
    process.setArguments({gamePath});
    process.setWorkingDirectory(gameCWD);

    // Set environment variables
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    env.insert("LANG", "ja_JP.UTF-8");
    process.setProcessEnvironment(env);

    // Start the process
    process.start();
    if (!process.waitForStarted()) {
        qCritical() << "Failed to start the game process!";
        return false;
    }

    // Wait for the process to finish
    process.waitForFinished(-1); // -1 means wait indefinitely
    qInfo() << "Game process finished with exit code:" << process.exitCode();

    return true;

    #endif
}
