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
    emit volumeChanged();
}
