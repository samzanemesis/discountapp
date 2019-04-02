#include "discountguild.h"

DiscountGuild::DiscountGuild(QDiscordGuild *guild, QObject *parent) : QObject(parent)
{
    m_hGuild = guild;
    m_Icon = getGuildIcon(guild);
    m_ID = guild->id();
    m_Name = guild->name();
}


QString DiscountGuild::getIcon() const
{
    return m_Icon;
}

void DiscountGuild::setIcon(const QString &Icon)
{
    m_Icon = Icon;
}

QString DiscountGuild::getID() const
{
    return m_ID;
}

void DiscountGuild::setID(const QString &ID)
{
    m_ID = ID;
}

QString DiscountGuild::getName() const
{
    return m_Name;
}

void DiscountGuild::setName(const QString &Name)
{
    m_Name = Name;
}
