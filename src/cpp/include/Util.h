#include <QObject>

class Util : public QObject
{
    Q_OBJECT
    public:
        explicit Util(QObject *parent = nullptr);

        Q_INVOKABLE void Sleep(int ms);
};