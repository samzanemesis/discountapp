#ifndef DISCOUNT_H
#define DISCOUNT_H

#include <QObject>
#include <QDiscord>
#include <QFile>
#include <QCoreApplication>
#include <QDebug>

#include "discountguild.h"

class Discount : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString  token MEMBER m_token)
    Q_PROPERTY(QDiscord* qdiscord READ discordAPI())
    Q_PROPERTY(QList<QObject*> guilds MEMBER m_guildList NOTIFY guildsChanged )

    Q_SIGNALS:
        void loginStarted();
        void loginSucceeded();
        void loginFailed();
        void guildsChanged();
public:
    explicit Discount(QObject *parent = nullptr);
    QDiscord *discordAPI() {return _discord;}

    Q_INVOKABLE void doLogin(QString tokenText);
    //Q_INVOKABLE QVariantList getGuilds();


    QList<QObject *> getGuildList() const;

    Q_INVOKABLE void updateGuildList();
private:

    void messageReceived(QDiscordMessage message);
    void loginSuccess();
    void loginFail();

    QString m_sDiscordCDNUrl;

    QString Discount::getUserAvatar( QDiscordUser* user );

    QDiscord *_discord;

    QList<QObject *> m_guildList;

    QString m_token;

signals:


public slots:
};

#endif // DISCOUNT_H
