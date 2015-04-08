#include "appcontroller.h"

AppController::AppController(QObject *parent) :
    QObject(parent)
{
    m_api = new NeteaseAPI(this);
    connect(m_api, &NeteaseAPI::topPlaylistGot, this, &AppController::topPlaylistsGot);
    connect(m_api, &NeteaseAPI::playlistDetailGot, this, &AppController::playlistDetailGot);
    connect(m_api, &NeteaseAPI::rankingListsGot, this, &AppController::rankingListsGot);
    connect(m_api, &NeteaseAPI::lyricGot, this, &AppController::lyricGot);
    connect(m_api, &NeteaseAPI::hotspotGot, this, &AppController::hotspotGot);
}

void AppController::getTopPlaylists()
{
    m_api->topPlaylist();
}

void AppController::getPlaylistDetail(QString playlistId)
{
    m_api->playlistDetail(playlistId);
}

void AppController::getRankingLists()
{
    m_api->rankingLists();
}

void AppController::getLyric(QString songId)
{
    m_api->getLyric(songId);
}

void AppController::getHotspot()
{
    m_api->hotspot();
}
