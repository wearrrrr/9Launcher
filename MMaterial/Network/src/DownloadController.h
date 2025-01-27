#pragma once

#include <QObject>
#include <QList>
#include <QString>
#include <QUrl>

#include <QNetworkReply>
#include <QAbstractListModel>
#include <QNetworkAccessManager>
#include <QtQmlIntegration>

class Download : public QObject
{
	Q_OBJECT
	QML_ELEMENT
	QML_UNCREATABLE("Cannot create a Download object directly. Use the DownloadController instead.");

public:
	explicit Download(const QUrl &url, QObject *parent = nullptr, const QString &location = QStandardPaths::writableLocation(QStandardPaths::DownloadLocation));
	~Download();

	enum Status {
		Downloading = 0,
		Paused,
		Finished,
		Error,
		Retrying,
		Idle
	};
	Q_ENUM(Status);

	QString folderName() const;
	QString fileName() const;
	QString fileFullName() const;
	QUrl url() const;
	qint64 bytesDownloaded() const;
	qint64 totalBytes() const;
	int progress() const;

	void start();
	void pause();

	QString bytesToHumanReadable(qint64 bytes);

	Status status() const;
	void setStatus(Status newStatus);

	QString totalSize();
	QString downloadedSize();

signals:
	void progressMade(qint64 bytesReceived, qint64 bytesTotal);
	void finished();
	void error(QNetworkReply::NetworkError error, const QString& errorString);

	void statusChanged();

private slots:
	void onProgressMade(qint64 bytesReceived, qint64 bytesTotal);
	void onReadyRead();
	void onFinished();
	void onError(QNetworkReply::NetworkError error);
	void onErrorFinished(QNetworkReply::NetworkError error, const QString& errorString);

private:
	QUrl m_url;
	QString m_location;
	QString m_fileName;
	QString m_fileFullName;
	qint64 m_bytesDownloaded = 0;
	qint64 m_bytesDownloadedInitial = 0;
	qint64 m_totalBytes = 0;
	Status m_status = Idle;

	QNetworkAccessManager m_networkManager;
	QFile *m_file = nullptr;
	QNetworkReply *m_reply = nullptr;
};

class DownloadModel : public QAbstractListModel
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(bool isRunning READ isRunning NOTIFY isRunningChanged FINAL)
public:
	explicit DownloadModel(QObject *parent = nullptr);

	enum Roles {
		UrlRole = Qt::UserRole + 1,
		FileNameRole,
		FileFullNameRole,
		ProgressRole,
		StatusRole,
		TotalSizeRole,
		DownloadedSizeRole
	};

	int rowCount(const QModelIndex &parent = QModelIndex()) const override;
	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
	bool setData(const QModelIndex& index, const QVariant& value, int role) override;
	QHash<int, QByteArray> roleNames() const override;

	bool isRunning() const;

	Q_INVOKABLE void addDownload(const QUrl &url);
	Q_INVOKABLE void startDownload(int index);
	Q_INVOKABLE void pauseDownload(int index);
	Q_INVOKABLE void removeDownload(int index);
	Q_INVOKABLE void pauseRunning();

private slots:
	void onDownloadUpdated();
	void onDownloadError(QNetworkReply::NetworkError error, const QString& errorString);

private:
	QList<Download*> m_downloads;

signals:
	void error(const QString& errorString);
	void isRunningChanged();
};
