#pragma once

#include <QObject>
#include <QVariantMap>
#include <qqmlintegration.h>

class AlertController : public QObject
{
	Q_OBJECT
	QML_ELEMENT
	QML_SINGLETON
public:
	AlertController(QObject* parent = nullptr);

	Q_INVOKABLE void subscribe(const QString& objectName);

signals:
	void alert(const QString &message, const QVariantMap &details = {}, int duration = 3500, const QString& objectName = "");

private:
	QList<QString> m_subscriptionObjectNames;
};

