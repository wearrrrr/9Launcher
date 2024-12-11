#include <QObject>
#include <QSettings>
#include <QVariant>

class AppSettings : public QSettings {
    Q_OBJECT

public:
    AppSettings(const QString &organization, const QString &application)
        : QSettings(organization, application) {}

    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const {
        return QSettings::value(key, defaultValue);
    }

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value) {
        QSettings::setValue(key, value);
    }
};
