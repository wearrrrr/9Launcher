#include <QtDebug>
#include <QUrl>
#include <QString>
#include <QThread>
#include <QProcess>
#include <unistd.h>

#include "RPC.h"
#include "GameLauncher.h"

static bool launched = false;

static gameInfo currentGameInfo;

GameLauncher::GameLauncher(QObject *parent) : QObject(parent) {}

bool GameLauncher::LaunchThread(const QString &gamePath, const QString &gameCWD, const QString &gameName, const QString &gameIcon)
{
    RPC rpc = RPC();
    rpc.setRPC("Playing " + gameName.toStdString(), gameIcon.toStdString(), gameName.toStdString());

    currentGameInfo.gamePath = gamePath;
    currentGameInfo.gameCWD = gameCWD;
    currentGameInfo.gameName = gameName;
    currentGameInfo.gameIcon = gameIcon;

    #ifdef Q_OS_LINUX
    bool launch = LaunchLinux(gamePath, gameCWD);
    #endif
    rpc.setRPC("In the main menu");
    return launch;
}

bool GameLauncher::LaunchPC98Thread(const QString &gamePath, const QString &gameName, const QString &gameIcon)
{
    RPC rpc = RPC();
    rpc.setRPC("Playing " + gameName.toStdString(), gameIcon.toStdString(), gameName.toStdString());

    currentGameInfo.gamePath = gamePath;
    currentGameInfo.gameCWD = NULL;
    currentGameInfo.gameName = gameName;
    currentGameInfo.gameIcon = gameIcon;

    #ifdef Q_OS_LINUX
    bool launch = LaunchLinux_PC98(gamePath);
    #endif
    rpc.setRPC("In the main menu");
    return launch;
}

gameInfo GameLauncher::GetCurrentGameInfo()
{
    return currentGameInfo;
}

bool GameLauncher::CheckGameRunning()
{
    return launched;
}

Q_INVOKABLE bool GameLauncher::launchGame(const QString &gamePath, const QString &gameCWD, const QString &gameName, const QString &gameIcon, const bool &isPC98)
{
    const QString localPath = QUrl(gamePath).toLocalFile();
    const QString localCWD = QUrl(gameCWD).toLocalFile();

    // Run LaunchThread in a separate thread
    QThread *thread = new QThread;
    connect(thread, &QThread::started, [=]() {
        if (CheckGameRunning())
        {
            qCritical() << "[9L] Game is already running!";
            thread->quit();
            return;
        }

        if (isPC98) {
            if (!LaunchPC98Thread(localPath, gameName, gameIcon)) {
                qCritical() << "[9L] Failed to launch game!";
            }
        } else {
            if (!LaunchThread(localPath, localCWD, gameName, gameIcon))
            {
                qCritical() << "[9L] Failed to launch game!";
            }
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

    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    env.insert("LANG", "ja_JP.UTF-8");
    process.setProcessEnvironment(env);

    process.start();
    if (!process.waitForStarted()) {
        qCritical() << "Failed to start the game process!";
        return false;
    }

    launched = true;

    process.waitForFinished(-1);

    launched = false;

    return true;

    #endif
}

bool GameLauncher::LaunchLinux_PC98(const QString &gamePath) {
    #ifdef Q_OS_LINUX

    qInfo() << "Launching game on Linux";

    QProcess process;
    process.setProgram("dosbox-x");
    process.setArguments({
        "-machine",
        "pc98",
        "-set",
        "cycles=35620"
        "-nopromptfolder",
        "-c",
        "IMGMOUNT A: " + gamePath,
        "-c",
        "A:",
        "-c",
        "game",
    });

    process.start();    
    if (!process.waitForStarted()) {
        qCritical() << "Failed to start the game process!";
        return false;
    }

    launched = true;

    process.waitForFinished(-1);

    launched = false;

    return true;

    #endif
}
