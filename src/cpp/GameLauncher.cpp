#include <QtDebug>
#include <QUrl>
#include <QString>
#include <QThread>
#include <QProcess>
#include <unistd.h>

#include "RPC.h"
#include "GameLauncher.h"
#include "AppSettings.h"

static AppSettings settings("wearr", "NineLauncher");

static bool launched = false;

static GameInfo currentGameInfo;


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
    rpc.setRPC("In the main menu");
    return launch;
    #endif
    #ifdef Q_OS_WINDOWS
    bool launch = LaunchWindows(gamePath, gameCWD);
    rpc.setRPC("In the main menu");
    return launch;
    #endif
    qCritical() << "Platform not supported! Please make an issue on the Github.";
    return false;
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
    rpc.setRPC("In the main menu");
    return launch;
    #endif
    #ifdef Q_OS_WINDOWS
    // TODO implement this!
    // bool launch = LaunchWindows_PC98(gamePath);
    #endif
    return false;
}

GameInfo GameLauncher::GetCurrentGameInfo()
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
    connect(thread, &QThread::started, [=, this]() {
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

bool GameLauncher::LaunchWindows(const QString &gamePath, const QString &gameCWD) {
    qInfo() << "Launching Game...";

    QProcess process;
    process.setProgram(gamePath);
    process.setWorkingDirectory(gameCWD);

    process.start();

    if (!process.waitForStarted()) {
        qCritical() << "Failed to start the game process!";
        return false;
    }

    launched = true;

    process.waitForFinished(-1);

    launched = false;

    return true;
};

const QString GameLauncher::GetWinePathFromSettings() {
    QString option = settings.value("wine").toString();
    if (option == "system") {
        return "wine";
    }
    /* 
        TODO!!: Make this actually get the path where the proton download is stored. This will be something like
        /home/<USER>/.local/share/wearr/NineLauncher/proton/GE-Proton-<VERSION_FROM_SETTINGS>/files/bin/wine
    */
    return "wine";
}

bool GameLauncher::LaunchLinux(const QString &gamePath, const QString &gameCWD) {
    qInfo() << "Launching Game...";

    QProcess process;
    process.setProgram(GetWinePathFromSettings());
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
}

bool GameLauncher::LaunchLinux_PC98(const QString &gamePath) {
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
}
