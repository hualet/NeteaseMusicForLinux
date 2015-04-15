#include "htsettings.h"

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
