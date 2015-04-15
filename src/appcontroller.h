#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include "netease_api/neteaseapi.h"
#include "playlist_model.h"
#include "song.h"

class AppController : public QObject
{
    Q_OBJECT
public:
    explicit AppController(QObject *parent = 0);

    Q_PROPERTY(PlaylistModel* playlistModel READ playlistModel WRITE setPlaylistModel NOTIFY playlistModelChanged)

    PlaylistModel *playlistModel() const;
    void setPlaylistModel(PlaylistModel *playlistModel);

signals:
    void playlistModelChanged();

    void topPlaylistsGot(QString playlists);
    void playlistDetailGot(QString detail);
    void rankingListsGot(QString lists);
    void lyricGot(QString lyric);
    void hotspotGot(QString hotspot);
    void bannersGot(QString banners);

public slots:
    void getTopPlaylists();
    void getPlaylistDetail(QString);
    void getRankingLists();
    void getLyric(QString);
    void getHotspot();
    void getBanners();

    void addPlaylistItem(QString id, QString name, QUrl mp3Url,
                         QUrl picUrl, QString artist, QString album, int duration);
    Song* getNextPlaylistItem(QString id);
    Song* getPlaylistItemById(QString id);

private:
    NeteaseAPI* m_api;
    PlaylistModel* m_playlistModel;
};

#endif // APPCONTROLLER_H
