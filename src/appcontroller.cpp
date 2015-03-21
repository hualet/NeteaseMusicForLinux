#include "appcontroller.h"

AppController::AppController(QObject *parent) :
    QObject(parent)
{
    m_api = new NeteaseAPI(this);
    connect(m_api, &NeteaseAPI::topPlaylistGot, this, &AppController::topPlaylistsGot);
}

void AppController::getTopPlaylists()
{
    m_api->topPlaylist();
}
