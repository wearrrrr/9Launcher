#pragma once

#include <QObject>

struct gameInfo {
    QString gamePath;
    QString gameCWD;
    QString gameName;
    QString gameIcon;
};

class GameLauncher : public QObject {
    Q_OBJECT
public:
    explicit GameLauncher(QObject *parent = nullptr);

    Q_INVOKABLE bool launchGame(const QString &gamePath, const QString &gameCWD, const QString &gameName, const QString &gameIcon, const bool &isPC98);

    bool LaunchThread(const QString &gamePath, const QString &gameCWD, const QString &gameName, const QString &gameIcon);
    bool LaunchPC98Thread(const QString &gamePath, const QString &gameName, const QString &gameIcon);

    bool CheckGameRunning();

    gameInfo GetCurrentGameInfo();

private:
    bool LaunchLinux(const QString &gamePath, const QString &gameCWD);
    bool LaunchLinux_PC98(const QString &gamePath);
    bool LaunchWindows(const QString &gamePath, const QString &gameCWD);
};