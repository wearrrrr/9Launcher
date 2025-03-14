#pragma once

#include <QObject>
#include <QString>

class Extractor {
public:
    Extractor() = default;
    static void ExtractArchive(const QString& path);
};