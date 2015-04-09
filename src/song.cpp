#include "song.h"

Song::Song(QObject *parent) :
    QObject(parent)
{
}

QUrl Song::mp3Url() const
{
    return _mp3Url;
}

void Song::setMp3Url(const QUrl &mp3Url)
{
    if (_mp3Url != mp3Url) {
        _mp3Url = mp3Url;
        emit mp3UrlChanged();
    }
}
QUrl Song::picUrl() const
{
    return _picUrl;
}

void Song::setPicUrl(const QUrl &picUrl)
{
    if (_picUrl != picUrl) {
        _picUrl = picUrl;
        emit picUrlChanged();
    }
}
QString Song::artist() const
{
    return _artist;
}

void Song::setArtist(const QString &artist)
{
    if (_artist != artist) {
        _artist = artist;
        emit artistChanged();
    }
}
QString Song::name() const
{
    return _name;
}

void Song::setName(const QString &name)
{
    if (_name != name) {
        _name = name;
        emit nameChanged();
    }
}

QString Song::album() const
{
    return _album;
}

void Song::setAlbum(const QString &album)
{
    if (_album != album) {
        _album = album;
        emit albumChanged();
    }
}
QString Song::id() const
{
    return _id;
}

void Song::setId(const QString &id)
{
    if (_id != id) {
        _id = id;
        emit idChanged();
    }
}
QString Song::lyric() const
{
    return _lyric;
}

void Song::setLyric(const QString &lyric)
{
    if (_lyric != lyric) {
        _lyric = lyric;
        emit lyricChanged();
    }
}

