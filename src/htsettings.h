#ifndef HTSETTINGS_H
#define HTSETTINGS_H

#include <QSettings>
#include <QDebug>

class HTSettings : public QSettings
{
    Q_OBJECT
public:
    explicit HTSettings(QObject *parent = 0);

    Q_PROPERTY(double volume READ volume WRITE setVolume NOTIFY volumeChanged)

signals:
    void volumeChanged();

public slots:
    double volume();
    void setVolume(double volume);
};

#endif // HTSETTINGS_H
