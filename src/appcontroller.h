#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include "netease_api/neteaseapi.h"

class AppController : public QObject
{
    Q_OBJECT
public:
    explicit AppController(QObject *parent = 0);

signals:
    void topPlaylistsGot(QString playlists);
    void playlistDetailGot(QString tracks);
    void rankingListsGot(QString lists);
    void lyricGot(QString lyric);
    void hotspotGot(QString hotspot);

public slots:
    void getTopPlaylists();
    void getPlaylistDetail(QString);
    void getRankingLists();
    void getLyric(QString);
    void getHotspot();

private:
    NeteaseAPI* m_api;
};

#endif // APPCONTROLLER_H
