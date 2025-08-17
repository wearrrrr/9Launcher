#pragma once

#include <QtNetwork>
#include <vector>

class Downloader : public QObject {
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

    Q_INVOKABLE void download(const QString &url, const QString &filePath, const bool extractTGZ);
    Q_INVOKABLE void CancelDownloads();

private:
    QNetworkAccessManager *manager = new QNetworkAccessManager();
    QNetworkRequest request;

    std::vector<QNetworkReply *> currentlyDownloading;

signals:
    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void downloadFinished();
    void downloadFailed(const QString &errorString);
};
