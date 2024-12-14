#include "FileIO.h"
#include <QFile>
#include <QUrl>
#include <QTextStream>
#include <QDir>

FileIO::FileIO(QObject *parent) : QObject(parent) {}

bool FileIO::write(const QString &filePath, const QString &data) {
    QString localPath = QUrl(filePath).toLocalFile();
    QFile file(localPath);

    // Check if directory exists, create it if it doesn't
    QFileInfo fileInfo(file);
    QDir dir = fileInfo.dir();
    if (!dir.exists()) {
        dir.mkpath(".");
    }

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Could not open file for writing:" << filePath;
        return false;
    }

    QTextStream out(&file);
    out << data;
    file.close();
    return true;
}

QString FileIO::read(const QString &filePath) {
    QString localPath = QUrl(filePath).toLocalFile();
    QFile file(localPath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Could not open file for reading:" << filePath;
        return QString();
    }

    QTextStream in(&file);
    QString content = in.readAll();

    file.close();
    return content;
}

bool FileIO::exists(const QString &path) {
    return QFile::exists(QUrl(path).toLocalFile());
}
