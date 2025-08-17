#include "AppSettings.h"
#include <qsettings.h>

Q_INVOKABLE QVariant AppSettings::value(const QString &key, const QVariant &defaultValue) const {
    QVariant result = QSettings::value(key, defaultValue);

    // Boolean conversion BS.
    if (result.typeId() == QMetaType::QString) {
        QString strValue = result.toString().toLower();
        if (strValue == "true") return true;
        if (strValue == "false") return false;
    }

    return result;
}

Q_INVOKABLE QVariant AppSettings::value(const QString &key) const {
    return QSettings::value(key);
}

Q_INVOKABLE void AppSettings::setValue(const QString &key, const QVariant &value) {
    return QSettings::setValue(key, value);
}

Q_INVOKABLE void AppSettings::clear() {
    return QSettings::clear();
}
