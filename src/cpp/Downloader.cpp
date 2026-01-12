#include "Downloader.h"

#include <QProcess>
#include <QUrl>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QDebug>
#include <zip.h>

Downloader::Downloader(QObject *parent) : QObject(parent), manager(new QNetworkAccessManager(this)) {}

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

        if (extractTGZ && extractZip) {
            emit downloadFailed("Cannot extract both TGZ and ZIP");
            return;
        }

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
            file.close();
            file.remove();
        }

        if (extractZip) {
            file.close();
            qDebug() << "Beginning ZIP extraction";
            
            int err = 0;
            zip_t *archive = zip_open(localPath.toUtf8().constData(), ZIP_RDONLY, &err);
            
            if (!archive) {
                zip_error_t error;
                zip_error_init_with_code(&error, err);
                QString errorMsg = QString("Failed to open ZIP file: %1").arg(zip_error_strerror(&error));
                zip_error_fini(&error);
                emit downloadFailed(errorMsg);
                reply->deleteLater();
                return;
            }
            
            zip_int64_t numEntries = zip_get_num_entries(archive, 0);
            if (numEntries < 0) {
                zip_close(archive);
                emit downloadFailed("Failed to get number of entries in ZIP");
                reply->deleteLater();
                return;
            }
            
            for (zip_int64_t i = 0; i < numEntries; i++) {
                const char *name = zip_get_name(archive, i, 0);
                if (!name) {
                    zip_close(archive);
                    emit downloadFailed("Failed to get entry name from ZIP");
                    reply->deleteLater();
                    return;
                }
                
                QString entryName = QString::fromUtf8(name);
                
                // Skip entries with path traversal
                if (entryName.contains("..") || QDir::isAbsolutePath(entryName)) {
                    qWarning() << "Skipping unsafe ZIP entry:" << entryName;
                    continue;
                }
                
                QString targetPath = QDir::cleanPath(dirPath + "/" + entryName);
                
                // Check if it's a directory
                if (entryName.endsWith('/')) {
                    if (!QDir().mkpath(targetPath)) {
                        zip_close(archive);
                        emit downloadFailed("Failed to create directory: " + targetPath);
                        reply->deleteLater();
                        return;
                    }
                    continue;
                }
                
                // Create parent directory
                QString parentDir = QFileInfo(targetPath).absolutePath();
                if (!QDir().mkpath(parentDir)) {
                    zip_close(archive);
                    emit downloadFailed("Failed to create directory: " + parentDir);
                    reply->deleteLater();
                    return;
                }
                
                // Open file in archive
                zip_file_t *zf = zip_fopen_index(archive, i, 0);
                if (!zf) {
                    zip_close(archive);
                    emit downloadFailed("Failed to open file in ZIP: " + entryName);
                    reply->deleteLater();
                    return;
                }
                
                // Create output file
                QFile outFile(targetPath);
                if (!outFile.open(QIODevice::WriteOnly)) {
                    zip_fclose(zf);
                    zip_close(archive);
                    emit downloadFailed("Failed to create file: " + targetPath);
                    reply->deleteLater();
                    return;
                }
                
                // Read and write data
                char buffer[8192];
                zip_int64_t bytesRead;
                while ((bytesRead = zip_fread(zf, buffer, sizeof(buffer))) > 0) {
                    if (outFile.write(buffer, bytesRead) != bytesRead) {
                        outFile.close();
                        zip_fclose(zf);
                        zip_close(archive);
                        emit downloadFailed("Failed to write to file: " + targetPath);
                        reply->deleteLater();
                        return;
                    }
                }
                
                outFile.close();
                zip_fclose(zf);
                
                if (bytesRead < 0) {
                    zip_close(archive);
                    emit downloadFailed("Error reading file from ZIP: " + entryName);
                    reply->deleteLater();
                    return;
                }
            }
            
            zip_close(archive);
            qDebug() << "ZIP extraction complete!";
            
            // Remove the ZIP file
            QFile::remove(localPath);
        } else {
            file.close();
        }

        emit downloadFinished();
        reply->deleteLater();
    });
}

void Downloader::CancelDownloads() {
    if (currentlyDownloading.size() == 0) return;
    for (QNetworkReply *reply : currentlyDownloading) {
        disconnect(reply, nullptr, this, nullptr);
        reply->abort();
        reply->deleteLater();
    }
    currentlyDownloading.clear();
}

void Downloader::fetchContent(const QString &url) {
    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(url)));

    currentlyDownloading.push_back(reply);

    connect(reply, &QNetworkReply::finished, [=, this]() {
        auto it = std::find(currentlyDownloading.begin(), currentlyDownloading.end(), reply);
        if (it != currentlyDownloading.end()) {
            currentlyDownloading.erase(it);
        }

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
