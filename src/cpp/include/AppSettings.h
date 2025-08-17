#include <QObject>
#include <QSettings>
#include <QVariant>
#include <QMetaType>
#include <qobject.h>

class AppSettings : public QSettings {
    Q_OBJECT

public:
    AppSettings(const QString &organization, const QString &application) : QSettings(organization, application) {}

    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue) const;

    Q_INVOKABLE QVariant value(const QString &key) const;

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);

    Q_INVOKABLE void clear();
};
