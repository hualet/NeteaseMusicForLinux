#ifndef HTSETTINGS_H
#define HTSETTINGS_H

#include <QSettings>

class HTSettings : public QSettings
{
    Q_OBJECT
public:
    explicit HTSettings(QObject *parent = 0);

    Q_PROPERTY(double volume READ volume WRITE setVolume)
    Q_PROPERTY(QString lastSong READ lastSong WRITE setLastSong)

    double volume();
    void setVolume(double volume);

    QString lastSong() const;
    void setLastSong(QString& lastSong);
};

#endif // HTSETTINGS_H
