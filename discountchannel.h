#ifndef DISCOUNTCHANNEL_H
#define DISCOUNTCHANNEL_H

#include <QObject>

class DiscountChannel : public QObject
{
    Q_OBJECT
public:
    explicit DiscountChannel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // DISCOUNTCHANNEL_H