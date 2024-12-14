#include <QGuiApplication>
#include "Clipboard.h"

Q_INVOKABLE void Clipboard::set(const QString &text)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text);
}

Q_INVOKABLE QString Clipboard::get()
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    return clipboard->text();
}