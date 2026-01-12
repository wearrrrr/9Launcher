#include "Downloader.h"

#include <QProcess>
#include <QUrl>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QDebug>
#include <QByteArray>
#include <array>
#include <vector>
#include <minizip/unzip.h>

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
            qDebug() << "Beginning ZIP extraction";

            const QByteArray zipPathBytes = QFile::encodeName(localPath);
            unzFile zipFile = unzOpen64(zipPathBytes.constData());
            if (!zipFile) {
                emit downloadFailed("Failed to open ZIP file: " + localPath);
                reply->deleteLater();
                file.close();
                return;
            }

            const QString baseDirNormalized = QDir::cleanPath(dirPath);
            QString baseDirWithSlash = baseDirNormalized;
            if (!baseDirWithSlash.endsWith('/')) {
                baseDirWithSlash.append('/');
            }

            auto isPathWithinBase = [&](const QString &path) -> bool {
                return path == baseDirNormalized || path.startsWith(baseDirWithSlash);
            };

            auto closeAndFail = [&](const QString &message) {
                emit downloadFailed(message);
                if (zipFile) {
                    unzClose(zipFile);
                    zipFile = nullptr;
                }
                reply->deleteLater();
                file.close();
            };

            std::vector<char> nameBuffer;
            std::array<char, 8192> ioBuffer{};

            int ret = unzGoToFirstFile(zipFile);
            while (ret == UNZ_OK) {
                unz_file_info64 fileInfo{};
                if (unzGetCurrentFileInfo64(zipFile, &fileInfo, nullptr, 0, nullptr, 0, nullptr, 0) != UNZ_OK) {
                    closeAndFail("Failed to read ZIP entry info");
                    return;
                }

                nameBuffer.resize(static_cast<size_t>(fileInfo.size_filename) + 1);
                if (unzGetCurrentFileInfo64(zipFile, &fileInfo, nameBuffer.data(),
                                            static_cast<unsigned int>(nameBuffer.size()),
                                            nullptr, 0, nullptr, 0) != UNZ_OK) {
                    closeAndFail("Failed to read ZIP entry name");
                    return;
                }
                nameBuffer.back() = '\0';

                const QString rawName = QString::fromUtf8(nameBuffer.data());
                bool entryIsDirectory = rawName.endsWith('/') || rawName.endsWith('\\');

                const quint32 externalAttributes = static_cast<quint32>(fileInfo.external_fa);
                const quint32 posixMode = externalAttributes >> 16;
                if ((posixMode & 0040000u) == 0040000u || (externalAttributes & 0x10u) == 0x10u) {
                    entryIsDirectory = true;
                }

                if (rawName.contains("..")) {
                    qWarning() << "Skipping suspicious ZIP entry" << rawName;
                    ret = unzGoToNextFile(zipFile);
                    continue;
                }

                QString sanitizedName = rawName;
                sanitizedName.replace('\\', '/');
                sanitizedName = QDir::cleanPath(sanitizedName);

                const bool hasDriveSpecifier = sanitizedName.size() > 1 &&
                                               sanitizedName.at(1) == ':' &&
                                               sanitizedName.at(0).isLetter();

                if (sanitizedName.isEmpty() || sanitizedName == "." || sanitizedName.startsWith("..") ||
                    QDir::isAbsolutePath(sanitizedName) || hasDriveSpecifier) {
                    qWarning() << "Skipping unsafe ZIP entry" << rawName;
                    ret = unzGoToNextFile(zipFile);
                    continue;
                }

                const QString targetPath = QDir::cleanPath(baseDirNormalized + QLatin1Char('/') + sanitizedName);
                if (!isPathWithinBase(targetPath)) {
                    qWarning() << "Skipping ZIP entry outside target directory" << rawName;
                    ret = unzGoToNextFile(zipFile);
                    continue;
                }

                entryIsDirectory = entryIsDirectory || sanitizedName.endsWith('/');

                if (entryIsDirectory) {
                    if (!QDir().mkpath(targetPath)) {
                        closeAndFail("Failed to create directory: " + targetPath);
                        return;
                    }
                } else {
                    const QString outputDir = QFileInfo(targetPath).absolutePath();
                    if (!QDir().mkpath(outputDir)) {
                        closeAndFail("Failed to create directory: " + outputDir);
                        return;
                    }

                    if (unzOpenCurrentFile(zipFile) != UNZ_OK) {
                        closeAndFail("Failed to open file in ZIP: " + rawName);
                        return;
                    }

                    QFile outFile(targetPath);
                    if (!outFile.open(QIODevice::WriteOnly)) {
                        unzCloseCurrentFile(zipFile);
                        closeAndFail("Failed to create file: " + targetPath);
                        return;
                    }

                    int bytesRead = 0;
                    while ((bytesRead = unzReadCurrentFile(zipFile, ioBuffer.data(),
                                                           static_cast<unsigned int>(ioBuffer.size()))) > 0) {
                        if (outFile.write(ioBuffer.data(), bytesRead) != bytesRead) {
                            outFile.close();
                            unzCloseCurrentFile(zipFile);
                            closeAndFail("Failed to write extracted data to: " + targetPath);
                            return;
                        }
                    }
                    outFile.close();

                    if (bytesRead < 0) {
                        unzCloseCurrentFile(zipFile);
                        closeAndFail("Error while reading file from ZIP: " + rawName);
                        return;
                    }

                    unzCloseCurrentFile(zipFile);
                }

                ret = unzGoToNextFile(zipFile);
            }

            if (ret != UNZ_END_OF_LIST_OF_FILE) {
                closeAndFail("Error during ZIP extraction");
                return;
            }

            unzClose(zipFile);
            qDebug() << "ZIP extraction complete!";
            file.close();
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
