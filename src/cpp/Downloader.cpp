#include "Downloader.h"

#include <QProcess>
#include <QUrl>
#include <QFile>
#include <QDir>
#include <QDebug>
#include <quazip.h>
#include <quazipfile.h>
// Using QuaZip (Qt wrapper for minizip) for cross-platform ZIP extraction



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
            QuaZip zip(localPath);
            if (!zip.open(QuaZip::mdUnzip)) {
                emit downloadFailed("Failed to open ZIP file: " + localPath);
                reply->deleteLater();
                file.close();
                return;
            }

            for (bool more = zip.goToFirstFile(); more; more = zip.goToNextFile()) {
                QuaZipFile zipFile(&zip);
                if (!zipFile.open(QIODevice::ReadOnly)) {
                    emit downloadFailed("Failed to open file in ZIP: " + zipFile.getActualFileName());
                    zip.close();
                    reply->deleteLater();
                    file.close();
                    return;
                }

                QString fileName = zipFile.getActualFileName();
                QString fullPath = dirPath + "/" + fileName;

                if (fileName.endsWith('/')) {
                    // directory
                    QDir().mkpath(fullPath);
                } else {
                    // file
                    QString dir = QFileInfo(fullPath).absolutePath();
                    QDir().mkpath(dir);

                    QFile outFile(fullPath);
                    if (!outFile.open(QIODevice::WriteOnly)) {
                        emit downloadFailed("Failed to create file: " + fullPath);
                        zipFile.close();
                        zip.close();
                        reply->deleteLater();
                        file.close();
                        return;
                    }

                    outFile.write(zipFile.readAll());
                    outFile.close();
                }

                zipFile.close();
            }

            zip.close();
            qDebug() << "ZIP extraction complete!";
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
