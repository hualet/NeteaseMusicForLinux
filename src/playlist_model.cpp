#include "playlist_model.h"

#include <QDebug>

PlaylistModel::PlaylistModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void PlaylistModel::addSong(QString id, QString name, QUrl mp3Url,
                       QUrl picUrl, QString artist, QString album, int duration)
{
    Song *song = new Song(id, name, mp3Url, picUrl, artist, album, duration, this);

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_songs << song;
    endInsertRows();
}

Song* PlaylistModel::getNextSong(QString id)
{
    int index = -1;
    for (int i = 0; i < m_songs.size(); ++i) {
        if (m_songs.at(i)->id() == id) {
            index = i;
            break;
        }
    }

    if (0 <= index && index <= m_songs.size() - 2) {
        return m_songs.at(index + 1);
    } else {
        return NULL;
    }
}

Song* PlaylistModel::getSongAtIndex(int index)
{
    return m_songs.at(index);
}


int PlaylistModel::rowCount(const QModelIndex &) const {
    return m_songs.count();
}

QVariant PlaylistModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() > m_songs.count())
        return QVariant();

    Song *song = m_songs[index.row()];

    switch (role) {
    case IdRole:
        return song->id();
    case NameRole:
        return song->name();
    case Mp3UrlRole:
        return song->mp3Url();
    case PicUrlRole:
        return song->picUrl();
    case ArtistRole:
        return song->artist();
    case AlbumRole:
        return song->album();
    case DurationRole:
        return song->duration();
    }

    return QVariant();
}

QHash<int, QByteArray> PlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[Mp3UrlRole] = "mp3Url";
    roles[PicUrlRole] = "picUrl";
    roles[ArtistRole] = "artist";
    roles[AlbumRole] = "album";
    roles[DurationRole] = "duration";
    return roles;
}
