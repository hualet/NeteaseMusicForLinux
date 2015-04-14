#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QUrl>

class Song : public QObject
{
    Q_OBJECT
public:
    explicit Song(QObject *parent = 0);
    Song(QString& id, QString& name, QUrl& mp3Url, QUrl& picUrl,
         QString& artist, QString& album, int duration, QObject *parent=0);

    Q_PROPERTY(QUrl mp3Url READ mp3Url WRITE setMp3Url NOTIFY mp3UrlChanged)
    Q_PROPERTY(QUrl picUrl READ picUrl WRITE setPicUrl NOTIFY picUrlChanged)
    Q_PROPERTY(QString artist READ artist WRITE setArtist NOTIFY artistChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString album READ album WRITE setAlbum NOTIFY albumChanged)
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString lyric READ lyric WRITE setLyric NOTIFY lyricChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)

    QUrl mp3Url() const;
    void setMp3Url(const QUrl &mp3Url);

    QUrl picUrl() const;
    void setPicUrl(const QUrl &picUrl);

    QString artist() const;
    void setArtist(const QString &artist);

    QString name() const;
    void setName(const QString &name);

    QString album() const;
    void setAlbum(const QString &album);

    QString id() const;
    void setId(const QString &id);

    QString lyric() const;
    void setLyric(const QString &lyric);

    int duration() const;
    void setDuration(const int duration);

signals:
    void idChanged();
    void mp3UrlChanged();
    void picUrlChanged();
    void artistChanged();
    void nameChanged();
    void albumChanged();
    void lyricChanged();
    void durationChanged();

private:
    QString m_id;
    QString m_name;
    QUrl m_mp3Url;
    QUrl m_picUrl;
    QString m_artist;
    QString m_album;
    QString m_lyric;
    int m_duration;
};

#endif // SONG_H
