#include "Downloader.h"

#include <QProcess>
#include <QUrl>
#include <QFile>
#include <QDir>
#include <QDebug>

Downloader::Downloader(QObject *parent) : QObject(parent) {}

void Downloader::download(const QString &url, const QString &filePath, const bool extractTGZ = false, const bool extractZip = false) {
    QString localPath;
    if (filePath.startsWith("file://")) {
        localPath = QUrl(filePath).toLocalFile();
    } else {
        localPath = filePath;
    }

    QString dirPath = QFileInfo(localPath).absolutePath();

    QDir dir;
    if (!dir.exists(dirPath)) {
        if (!dir.mkpath(dirPath)) {
            emit downloadFailed("Failed to create directory: " + dirPath);
            return;
        }
    }

    // qDebug() << "Directory to save to: " << dirPath;

    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(url)));

    currentlyDownloading.push_back(reply);

    connect(reply, &QNetworkReply::downloadProgress, [=, this](qint64 bytesReceived, qint64 bytesTotal) {
        // qDebug() << "Downloaded" << bytesReceived << "of" << bytesTotal << "bytes";
        emit downloadProgress(bytesReceived, bytesTotal);
    });

    connect(reply, &QNetworkReply::finished, [=, this]() {

        currentlyDownloading.erase(
            currentlyDownloading.begin(),
            currentlyDownloading.end()
        );

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

        if (extractTGZ) {
            qDebug() << "Beginning Extraction";
            QProcess proc;
            proc.setProgram("tar");
            proc.setArguments({"-xvzf", localPath});
            proc.setWorkingDirectory(dirPath);
            proc.start();
            if (!proc.waitForStarted()) {
                qCritical() << "Failed to start tar!";
                emit downloadFailed("Failed to start tar! Please check to make sure it's installed!");
                reply->deleteLater();
                file.close();
                return;
            }
            proc.waitForFinished(-1);

            qDebug() << "Extraction complete!";
            file.remove();
        }

        if (extractZip) {
            qDebug() << "Beginning Extraction";
            QProcess proc;
#ifdef _WIN32
        proc.setProgram("powershell");
        proc.setArguments({"-Command", "Expand-Archive", "-Path", localPath});
#else
        proc.setProgram("unzip");
        proc.setArguments({"-o", localPath});
#endif
            proc.setWorkingDirectory(dirPath);
            proc.start();
            if (!proc.waitForStarted()) {
                qCritical() << "Failed to start unzip!";
                emit downloadFailed("Failed to start unzip! Please check to make sure it's installed!");
                reply->deleteLater();
                file.close();
                return;
            }
            proc.waitForFinished(-1);

            qDebug() << "Extraction complete!";
            file.remove();
        }

        file.close();

        emit downloadFinished();
        reply->deleteLater();
    });
}

void Downloader::CancelDownloads() {
    if (currentlyDownloading.size() == 0) return;
    for (QNetworkReply *reply : currentlyDownloading) {
        reply->abort();
        reply->deleteLater();
    }
    currentlyDownloading.clear();
}

void Downloader::fetchContent(const QString &url) {
    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(url)));

    currentlyDownloading.push_back(reply);

    connect(reply, &QNetworkReply::finished, [=, this]() {
        currentlyDownloading.erase(
            currentlyDownloading.begin(),
            currentlyDownloading.end()
        );

        if (reply->error()) {
            emit downloadFailed(reply->errorString());
            reply->deleteLater();
            return;
        }

        QString content = QString::fromUtf8(reply->readAll());
        emit contentFetched(content);
        reply->deleteLater();
    });
}
