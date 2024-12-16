#include <QtLogging>
#include <QDebug>
#include <QString>
#include <stdint.h>
#include <time.h>

#include "AppSettings.h"
#include "GameLauncher.h"
#include "RPC.h"
#include "discord_rpc.h"

using std::string;

RPC::RPC(QObject *parent) : QObject(parent) {}

static const char* APPLICATION_ID = "1113926701735493664";

static AppSettings settings("wearr", "NineLauncher");

int64_t StartTime;

static void updateDiscordPresence(string state, string smallImageKey = "", string smallImageText = "")
{

    if (settings.value("rpc") == false) {
        return;
    }

    DiscordRichPresence discordPresence;
    memset(&discordPresence, 0, sizeof(discordPresence));
    discordPresence.state = state.c_str();
    // TODO: This will eventually be replaced with information like lives, score, bombs, etc.
    discordPresence.details = "9Launcher";
    discordPresence.startTimestamp = StartTime;
    discordPresence.largeImageKey = "icon";
    discordPresence.largeImageText = "9Launcher";
    discordPresence.smallImageKey = smallImageKey.c_str();
    discordPresence.smallImageText = smallImageText.c_str();

    Discord_UpdatePresence(&discordPresence);

    return;
}

void RPC::initDiscord() {

    if (settings.value("rpc") == false) {
        return;
    }

    qInfo() << "Initializing Discord RPC";
    
    DiscordEventHandlers handlers;
    memset(&handlers, 0, sizeof(handlers));
    Discord_Initialize(APPLICATION_ID, &handlers, 1, NULL);

    StartTime = time(0);

    // Check if a game is currently running and set the RPC accordingly
    GameLauncher gameLauncher = GameLauncher();
    if (gameLauncher.CheckGameRunning()) {
        gameInfo currentGameInfo = gameLauncher.GetCurrentGameInfo();
        updateDiscordPresence("Playing " + currentGameInfo.gameName.toStdString(), currentGameInfo.gameIcon.toStdString(), currentGameInfo.gameName.toStdString());
    } else {
        updateDiscordPresence("In the main menu");
    }
}

void RPC::setRPC(string state) {
    updateDiscordPresence(state, "", "");
}

void RPC::setRPC(string state, string smallImageKey, string smallImageText) {
    updateDiscordPresence(state, smallImageKey, smallImageText);
}

Q_INVOKABLE void RPC::stopRPC() {
    qInfo() << "Shutting down Discord RPC";
    Discord_ClearPresence();
    Discord_Shutdown();
}