#include <QThread>

#include "Util.h"

Util::Util(QObject *parent) : QObject(parent) {}

Q_INVOKABLE void Util::Sleep(int ms)
{
    QThread::msleep(ms);
};