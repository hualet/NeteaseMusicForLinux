#ifndef PLAYLIST_MODEL_H
#define PLAYLIST_MODEL_H

#include <QAbstractListModel>
#include <QList>

#include "song.h"

class PlaylistModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PlaylistRoles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        Mp3UrlRole,
        PicUrlRole,
        ArtistRole,
        AlbumRole,
        DurationRole,
    };

    explicit PlaylistModel(QObject *parent = 0);

    void addSong(QString id, QString name, QUrl mp3Url,
                 QUrl picUrl, QString artist, QString album, int duration);
    Song* getNextSong(QString id);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QHash<int,QByteArray> roleNames() const;

public slots:
    Song* getSongAtIndex(int index);

private:
    QList<Song*> m_songs;
};

#endif // PLAYLIST_MODEL_H
