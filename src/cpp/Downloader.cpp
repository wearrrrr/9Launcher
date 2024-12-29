#include "Downloader.h"

#include <QUrl>
#include <QFile>
#include <QDebug>

Downloader::Downloader(QObject *parent) : QObject(parent) {}

void Downloader::download(const QString &url, const QString &filePath) {
    QString localPath = QUrl(filePath).toLocalFile();

    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(url)));

    currentlyDownloading.push_back(reply);

    // Emit progress signal
    connect(reply, &QNetworkReply::downloadProgress, this, [=](qint64 bytesReceived, qint64 bytesTotal) {
        qDebug() << "Downloaded" << bytesReceived << "of" << bytesTotal << "bytes";
        emit downloadProgress(bytesReceived, bytesTotal);
    });

    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error()) {
            emit downloadFailed(reply->errorString());
            reply->deleteLater();
            return;
        }

        QFile file(localPath);

        if (!file.open(QIODevice::WriteOnly)) {
            emit downloadFailed("Failed to open file for writing: " + localPath);
            reply->deleteLater();
            return;
        }

        file.write(reply->readAll());
        file.close();

        emit downloadFinished();
        reply->deleteLater();
    });
}

void Downloader::CancelDownloads() {
    qDebug() << "Cancelling downloads";
    for (QNetworkReply *reply : currentlyDownloading) {
        reply->abort();
        reply->deleteLater();
    }
    currentlyDownloading.clear();
}