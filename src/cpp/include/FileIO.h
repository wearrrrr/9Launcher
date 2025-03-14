#pragma once

#include <QObject>
#include <QString>

class FileIO : public QObject {
    Q_OBJECT
public:
    explicit FileIO(QObject *parent = nullptr);

    Q_INVOKABLE bool write(const QString &filePath, const QString &data);

    Q_INVOKABLE QString read(const QString &filePath);

    Q_INVOKABLE bool exists(const QString &filePath);
};