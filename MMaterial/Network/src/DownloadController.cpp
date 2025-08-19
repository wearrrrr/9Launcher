#include "DownloadController.h"

#include <QNetworkAccessManager>
#include <QNetworkRequest>

Download::Download(const QUrl &url, QObject *parent, const QString &location)
	: QObject(parent), m_url(url), m_location(location)
{
#if defined(__wasm__)
	m_location = "";
#endif

	start();
}

Download::~Download()
{
	if (m_reply)
	{
		m_reply->abort();
	}
}

QString Download::folderName() const
{
	return {};
}

QString Download::fileName() const
{
	return m_fileName;
}

QString Download::fileFullName() const
{
	return m_fileFullName;
}

QUrl Download::url() const
{
	return m_url;
}

qint64 Download::bytesDownloaded() const
{
	return m_bytesDownloaded;
}

qint64 Download::totalBytes() const
{
	return m_totalBytes;
}

int Download::progress() const
{
	if (m_totalBytes <= 0) {
		return 0;
	}

	auto percentage = static_cast<double>(m_bytesDownloaded) / static_cast<double>(m_totalBytes) * 100;
	return std::min(100, static_cast<int>(std::round(percentage)));
}

void Download::start()
{
	QNetworkRequest request(m_url);

	// Check if resuming is possible
	if (m_bytesDownloaded > 0 && (m_status == Status::Paused || m_status == Status::Error))
	{
		if (m_file) {
			m_file->flush();
			m_bytesDownloadedInitial = m_file->size();
		}
		QByteArray rangeHeaderValue = "bytes=" + QByteArray::number(m_bytesDownloadedInitial) + "-";
		request.setRawHeader("Range",rangeHeaderValue);
	}

	// Open the file for appending (if not already opened)
	if (!m_file) {
		QFileInfo fileInfo(m_url.fileName());
		QString baseName = fileInfo.baseName();
		QString extension = fileInfo.completeSuffix();

		// Construct the initial full file name
		m_fileFullName = QString("%1/%2.%3").arg(m_location, baseName, extension);
		m_fileName = m_url.fileName();

		if (QFile::exists(m_fileFullName)) {
			int i = 1;

			// Iterate until a unique name is found
			while (QFile::exists(m_fileFullName)) {
				m_fileFullName = QString("%1/%2(%3).%4").arg(m_location, baseName, QString::number(i), extension);
				m_fileName = QString("%1(%2).%3").arg(baseName, QString::number(i), extension);
				i++;
			}
		}

		m_file = new QFile(m_fileFullName, this);

		if (!m_file->open(QIODevice::WriteOnly | QIODevice::Append)) {
			qWarning() << "Failed to open file:" << m_fileFullName;
			setStatus(Status::Error);
			return;
		}

		m_bytesDownloaded = m_file->size();
	}

	m_reply = m_networkManager.get(request);
	setStatus(m_status == Status::Error ? Status::Retrying : Status::Downloading);

	connect(m_reply, &QNetworkReply::downloadProgress, this, &Download::onProgressMade);
	connect(m_reply, &QNetworkReply::finished, this, &Download::onFinished);
	connect(m_reply, &QNetworkReply::errorOccurred, this, &Download::onError);
	connect(m_reply, &QNetworkReply::readyRead, this, &Download::onReadyRead);
}

void Download::onReadyRead()
{
	if (m_file && m_reply) {
		QByteArray data = m_reply->readAll();
		m_file->write(data);
	}
}

void Download::pause()
{
	setStatus(Status::Paused);
	if (m_reply)
	{
		m_reply->abort(); // Cancel the current download
		m_reply = nullptr;
	}
}


QString Download::bytesToHumanReadable(qint64 bytes)
{
	const char* units[] = {"B", "KB", "MB", "GB", "TB", "PB", "EB"};
	const int unitCount = sizeof(units) / sizeof(units[0]);
	double size = static_cast<double>(bytes);
	int unitIndex = 0;

	// Determine the appropriate unit
	while (size >= 1024.0 && unitIndex < unitCount - 1) {
		size /= 1024.0;
		++unitIndex;
	}

	// Format the result with locale-aware number formatting
	QLocale locale;
	QString formattedSize = locale.toString(size, 'f', 2); // Two decimal places
	return QString("%1 %2").arg(formattedSize, units[unitIndex]);

}

void Download::onProgressMade(qint64 bytesReceived, qint64 bytesTotal)
{
	if (m_status == Status::Paused || bytesReceived == 0)
		return;

	if (m_totalBytes == 0)
		m_totalBytes = bytesTotal;

	m_bytesDownloaded = bytesReceived + m_bytesDownloadedInitial;
	setStatus(Status::Downloading);

	emit progressMade(m_bytesDownloaded, m_totalBytes);
}

void Download::onFinished()
{
	if (m_reply->error() == QNetworkReply::NoError) {
		setStatus(Status::Finished);
	} else if (m_status != Status::Paused) {
		qDebug() << "Download finished with errors:" << m_reply->errorString();
		onErrorFinished(m_reply->error(), m_reply->errorString());
	}
	if (m_status != Status::Paused && m_status != Status::Error) {
		if (m_file) {
			m_file->close();
			delete m_file;
			m_file = nullptr;
		}
	}

	m_reply->deleteLater();
	m_reply = nullptr;
}

void Download::onError(QNetworkReply::NetworkError errorCode)
{
	Q_UNUSED(errorCode);
	if (m_status != Status::Paused)
		setStatus(Status::Error);
}

void Download::onErrorFinished(QNetworkReply::NetworkError errorCode, const QString& errorString)
{
	onError(errorCode);
	emit error(errorCode, errorString);
}

Download::Status Download::status() const
{
	return m_status;
}

void Download::setStatus(Status newStatus)
{
	if (m_status == newStatus)
		return;
	m_status = newStatus;
	emit statusChanged();
}

QString Download::totalSize()
{
	if (m_totalBytes == 0)
		return tr("N/A");
	return bytesToHumanReadable(m_totalBytes);
}

QString Download::downloadedSize()
{
	return bytesToHumanReadable(m_bytesDownloaded);
}

DownloadModel::DownloadModel(QObject *parent)
	: QAbstractListModel(parent)
{
}

int DownloadModel::rowCount(const QModelIndex &parent) const
{
	if (parent.isValid())
		return 0;
	return m_downloads.size();
}

QVariant DownloadModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid() || index.row() >= m_downloads.size())
		return QVariant();

	Download *download = m_downloads.at(index.row());

	switch (role)
	{
		case UrlRole:
			return download->url().toString();
		case FileNameRole:
			return download->fileName();
		case FileFullNameRole:
			return download->fileFullName();
		case ProgressRole:
			return download->progress();
		case StatusRole:
			return download->status();
		case TotalSizeRole:
			return download->totalSize();
		case DownloadedSizeRole:
			return download->downloadedSize();
		default:
			return QVariant();
	}
}

bool DownloadModel::setData(const QModelIndex& index, const QVariant& value, int role)
{
	if (!index.isValid() || index.row() >= m_downloads.size())
		return false;

	Download *download = m_downloads.at(index.row());

	switch (role){
		case StatusRole:
			download->setStatus(static_cast<Download::Status>(value.toInt()));
			break;
		default:
			return false;
	}

	emit dataChanged(index, index, { role });
	return true;
}

QHash<int, QByteArray> DownloadModel::roleNames() const
{
	return {
		{ UrlRole, "url" },
		{ FileNameRole, "fileName" },
		{ FileFullNameRole, "fileFullName" },
		{ ProgressRole, "progress" },
		{ StatusRole, "status" },
		{ TotalSizeRole, "fileSize" },
		{ DownloadedSizeRole, "fileDownloadedSize"}
	};
}

bool DownloadModel::isRunning() const
{
	for (auto* download : m_downloads)
		if (download->status() == Download::Downloading)
			return true;
	return false;
}

void DownloadModel::addDownload(const QUrl& url)
{
	auto* download = new Download(url);
	beginInsertRows(QModelIndex(), m_downloads.size(), m_downloads.size());
	m_downloads.append(download);
	endInsertRows();

	connect(download, &Download::progressMade, this, &DownloadModel::onDownloadUpdated);
	connect(download, &Download::finished, this, &DownloadModel::onDownloadUpdated);
	connect(download, &Download::statusChanged, this, &DownloadModel::onDownloadUpdated);
	connect(download, &Download::statusChanged, this, &DownloadModel::isRunningChanged);
	connect(download, SIGNAL(error(QNetworkReply::NetworkError,QString)), this, SLOT(onDownloadUpdated()));

	connect(download, &Download::error, this, &DownloadModel::onDownloadError);

	emit isRunningChanged();
}

void DownloadModel::startDownload(int index)
{
	if (index < 0 || index >= m_downloads.size())
		return;

	m_downloads.at(index)->start();
}

void DownloadModel::pauseDownload(int index)
{
	if (index < 0 || index >= m_downloads.size())
		return;

	m_downloads.at(index)->pause();
}

void DownloadModel::removeDownload(int index)
{
	if (index < 0 || index >= m_downloads.size())
		return;

	beginRemoveRows(QModelIndex(), index, index);

	auto* download = m_downloads.takeAt(index);
	download->deleteLater();
	endRemoveRows();
}

void DownloadModel::pauseRunning()
{
	for (auto* download : m_downloads) {
		if (download->status() == Download::Downloading || download->status() == Download::Retrying)
			download->pause();
	}
}

void DownloadModel::onDownloadUpdated()
{
	// Update the corresponding row in the view
	Download *download = dynamic_cast<Download *>(sender());
	if (!download)
		return;

	int row = m_downloads.indexOf(download);
	if (row >= 0)
	{
		emit dataChanged(index(row), index(row));
	}
}

void DownloadModel::onDownloadError(QNetworkReply::NetworkError errorCode, const QString& errorString)
{
	Q_UNUSED(errorCode);

	Download *download = dynamic_cast<Download *>(sender());
	if (!download)
		return;

	emit error(download->fileName() + tr(" failed. Reason: ") + errorString);
}
