#ifndef RPC_H
#define RPC_H

#include <QObject>

using std::string;

static void updateDiscordPresence(string state, string smallImageKey, string smallImageText);

class RPC : public QObject {
    Q_OBJECT
public:
    explicit RPC(QObject *parent = nullptr);

    Q_INVOKABLE void initDiscord();

    void setRPC(string state, string smallImageKey, string smallImageText);
};

#endif // RPC_H