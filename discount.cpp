#include "discount.h"

Discount::Discount(QObject *parent) : QObject(parent)
{
    _discord = new QDiscord();
    connect(_discord, &QDiscord::loggedIn, this, &Discount::loginSuccess);
    connect(_discord, &QDiscord::loginFailed, this, &Discount::loginFail);

    qRegisterMetaType< QList<DiscountGuild*> >("QList<DiscountGuild*>");

    m_sDiscordCDNUrl = "https://cdn.discordapp.com/";
}

void Discount::doLogin(QString tokenText){
    emit loginStarted();
    m_token = tokenText;

    _discord->login(QDiscordToken(m_token, QDiscordToken::Type::None));
}

void Discount::loginSuccess()
{
    qDebug() << "Login successful.";
    emit loginSucceeded();
}

void Discount::updateGuildList(){
    m_guildList.clear();

    for (int i = 0; i < _discord->state()->guilds().count(); ++i) {
        QDiscordGuild *guild = _discord->state()->guilds().at(i).data();
        m_guildList.append( new DiscountGuild(guild) );
    }
    emit guildsChanged();
}


QString Discount::getUserAvatar( QDiscordUser *user)
{
    return m_sDiscordCDNUrl + "avatars/" + user->id().toString() + "/" + user->avatar() + ".png";
}

QList<QObject *> Discount::getGuildList() const
{
    return m_guildList;
}

void Discount::loginFail()
{
    qDebug() << "Login failed.";
    emit loginFailed();
}
