#include <QObject>
#include <QSettings>
#include <QVariant>

class AppSettings : public QSettings {
    Q_OBJECT

public:
    AppSettings(const QString &organization, const QString &application)
        : QSettings(organization, application) {}

    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue) const {
        QVariant result = QSettings::value(key, defaultValue);

        // Boolean conversion BS.
        if (result.typeId() == QVariant::String) {
            QString strValue = result.toString().toLower();
            if (strValue == "true") return true;
            if (strValue == "false") return false;
        }

        return result;
    }

    Q_INVOKABLE QVariant value(const QString &key) const {
        return QSettings::value(key);
    }

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value) {
        return QSettings::setValue(key, value);
    }

    Q_INVOKABLE void clear() {
        return QSettings::clear();
    }
};
