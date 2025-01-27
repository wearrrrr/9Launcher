#ifndef CLIPBOARD_H
#define CLIPBOARD_H

#include <QObject>
#include <QString>
#include <QClipboard>

class Clipboard : public QObject {
    Q_OBJECT
public:
    Clipboard(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void set(const QString &text);

    Q_INVOKABLE QString get();
};

#endif // CLIPBOARD_H
