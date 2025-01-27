#include "AlertController.h"
#include <qdebug.h>


AlertController::AlertController(QObject* parent)
	: QObject(parent)
{

}

void AlertController::subscribe(const QString& objectName)
{
	if (!m_subscriptionObjectNames.contains(objectName))
		m_subscriptionObjectNames.append(objectName);
	else
		qWarning() << Q_FUNC_INFO << "Added object name: " << objectName << " already exists";
}
