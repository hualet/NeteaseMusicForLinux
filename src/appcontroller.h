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
    void playlistDetailGot(QString detail);

public slots:
    void getTopPlaylists();
    void getPlaylistDetail(QString);

private:
    NeteaseAPI* m_api;
};

#endif // APPCONTROLLER_H
