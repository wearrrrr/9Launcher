#pragma once

#include <QtNetwork>
#include <vector>

class Downloader : public QObject {
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);
    QNetworkAccessManager *manager = new QNetworkAccessManager();
    QNetworkRequest request;

    Q_INVOKABLE void download(const QString &url, const QString &filePath);
    Q_INVOKABLE void CancelDownloads();

private:
    std::vector<QNetworkReply *> currentlyDownloading;

signals:
    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void downloadFinished();
    void downloadFailed(const QString &errorString);
};