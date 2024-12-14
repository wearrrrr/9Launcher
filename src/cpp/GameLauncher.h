#ifndef GAMELAUNCHER_H
#define GAMELAUNCHER_H

#include <QObject>


class GameLauncher : public QObject {
    Q_OBJECT
public:
    explicit GameLauncher(QObject *parent = nullptr);

    Q_INVOKABLE bool launchGame(const QString &gamePath, const QString &gameCWD);

    bool LaunchThread(const QString &gamePath, const QString &gameCWD);

private:
    bool LaunchLinux(const QString &gamePath, const QString &gameCWD);
    bool LaunchWindows(const QString &gamePath, const QString &gameCWD);
};

#endif // GAMELAUNCHER_H