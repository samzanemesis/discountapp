#ifndef DISCOUNTGUILD_H
#define DISCOUNTGUILD_H

#include <QObject>
#include <QDiscord>

class DiscountGuild : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(QString icon READ getIcon WRITE setIcon)
    Q_PROPERTY(QString id   READ getID WRITE setID)

public:
    explicit DiscountGuild(QDiscordGuild *guild, QObject *parent = nullptr);

    QString getName() const;
    void setName(const QString &Name);

    QString getIcon() const;
    void setIcon(const QString &Icon);

    QString getID() const;
    void setID(const QString &ID);

private:
    QDiscordGuild * m_hGuild;

    QString m_Name;
    QString m_Icon;
    QString m_ID;

    //Helper functions
    QString getGuildIcon( QDiscordGuild *guild ) {
        return "http://cdn.discordapp.com/icons/" + guild->id().toString() + "/" + guild->icon() + ".png";}

};

#endif // DISCOUNTGUILD_H
