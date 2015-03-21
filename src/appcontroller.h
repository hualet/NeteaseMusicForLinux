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

public slots:
    void getTopPlaylists();

private:
    NeteaseAPI* m_api;
};

#endif // APPCONTROLLER_H
