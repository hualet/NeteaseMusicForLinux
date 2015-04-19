#include "htsettings.h"
#include <QDebug>

HTSettings::HTSettings(QObject *parent) :
    QSettings(parent)
{
}

double HTSettings::volume()
{
    return value("General/volume").toDouble();
}

void HTSettings::setVolume(double volume)
{
    setValue("General/volume", QVariant(volume));
}

QString HTSettings::lastSong() const
{
    return value("General/last_song").toString();
}

void HTSettings::setLastSong(QString& lastSong)
{
    setValue("General/last_song", QVariant(lastSong));
}

QString HTSettings::userId() const
{
    return value("General/user_id").toString();
}

void HTSettings::setUserId(QString& userId)
{
    setValue("General/user_id", QVariant(userId));
    emit userIdChanged();
}

QString HTSettings::userNickname() const
{
    return value("General/user_nickname").toString();
}

void HTSettings::setUserNickname(QString& nickname)
{
    setValue("General/user_nickname", QVariant(nickname));
    emit userNicknameChanged();
}

QString HTSettings::userAvatarUrl() const
{
    return value("General/user_avatar_url").toString();
}

void HTSettings::setUserAvatarUrl(QString& avatarUrl)
{
    setValue("General/user_avatar_url", QVariant(avatarUrl));
    emit userAvatarUrlChanged();
}
