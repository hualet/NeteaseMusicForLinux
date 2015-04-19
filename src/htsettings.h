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
    Q_PROPERTY(QString userNickname READ userNickname WRITE setUserNickname NOTIFY userNicknameChanged)
    Q_PROPERTY(QString userAvatarUrl READ userAvatarUrl WRITE setUserAvatarUrl NOTIFY userAvatarUrlChanged)

    double volume();
    void setVolume(double volume);

    QString lastSong() const;
    void setLastSong(QString& lastSong);

    QString userId() const;
    void setUserId(QString& userId);

    QString userNickname() const;
    void setUserNickname(QString& nickname);

    QString userAvatarUrl() const;
    void setUserAvatarUrl(QString& avatarUrl);

signals:
    void userIdChanged();
    void userNicknameChanged();
    void userAvatarUrlChanged();
};

#endif // HTSETTINGS_H
