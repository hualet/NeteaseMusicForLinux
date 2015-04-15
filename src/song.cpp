#include "song.h"

Song::Song(QObject *parent) :
    QObject(parent)
{
}

Song::Song(QString& id, QString& name, QString& mp3Url, QString& picUrl,
           QString& artist, QString& album, int duration, QObject *parent) :
    QObject(parent),
    m_id(id), m_name(name), m_mp3Url(mp3Url),
    m_picUrl(picUrl), m_artist(artist), m_album(album),
    m_duration(duration)
{

}

QString Song::mp3Url() const
{
    return m_mp3Url;
}

void Song::setMp3Url(const QString &mp3Url)
{
    if (m_mp3Url != mp3Url) {
        m_mp3Url = mp3Url;
        emit mp3UrlChanged();
    }
}
QString Song::picUrl() const
{
    return m_picUrl;
}

void Song::setPicUrl(const QString &picUrl)
{
    if (m_picUrl != picUrl) {
        m_picUrl = picUrl;
        emit picUrlChanged();
    }
}
QString Song::artist() const
{
    return m_artist;
}

void Song::setArtist(const QString &artist)
{
    if (m_artist != artist) {
        m_artist = artist;
        emit artistChanged();
    }
}
QString Song::name() const
{
    return m_name;
}

void Song::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

QString Song::album() const
{
    return m_album;
}

void Song::setAlbum(const QString &album)
{
    if (m_album != album) {
        m_album = album;
        emit albumChanged();
    }
}
QString Song::id() const
{
    return m_id;
}

void Song::setId(const QString &id)
{
    if (m_id != id) {
        m_id = id;
        emit idChanged();
    }
}
QString Song::lyric() const
{
    return m_lyric;
}

void Song::setLyric(const QString &lyric)
{
    if (m_lyric != lyric) {
        m_lyric = lyric;
        emit lyricChanged();
    }
}
int Song::duration() const
{
    return m_duration;
}

void Song::setDuration(const int duration)
{
    if (m_duration != duration) {
        m_duration = duration;
        emit durationChanged();
    }
}


