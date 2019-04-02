#ifndef CONSTANTS_H
#define CONSTANTS_H
#include <QObject>
#include <QColor>

class GlobalConsts : public QObject{

    Q_OBJECT

public:
    Q_INVOKABLE const int a(){return 1;}
    Q_INVOKABLE const int b(){return 2;}

    Q_INVOKABLE QColor fuck = QColor("#FFFFFF");
    Q_INVOKABLE QColor fucking = QColor("#FFFFFF");


private:
    const int m_a = 21;
    const int m_b = 42;
};
#endif // CONSTANTS_H
