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
    Q_PROPERTY(QString userId READ userId WRITE setUserId NOTIFY userIdChanged)

    double volume();
    void setVolume(double volume);

    QString lastSong() const;
    void setLastSong(QString& lastSong);

    QString userId() const;
    void setUserId(QString& userId);

signals:
    void userIdChanged();
};

#endif // HTSETTINGS_H
