#ifndef RPC_H
#define RPC_H

#include <QObject>


class RPC : public QObject {
    Q_OBJECT
public:
    explicit RPC(QObject *parent = nullptr);

    Q_INVOKABLE void setRPC();
};

#endif // RPC_H