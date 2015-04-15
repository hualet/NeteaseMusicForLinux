#include "appcontroller.h"

AppController::AppController(QObject *parent) :
    QObject(parent)
{
    m_api = new NeteaseAPI(this);
    m_playlistModel = new PlaylistModel(this);

    connect(m_api, &NeteaseAPI::topPlaylistGot, this, &AppController::topPlaylistsGot);
    connect(m_api, &NeteaseAPI::playlistDetailGot, this, &AppController::playlistDetailGot);
    connect(m_api, &NeteaseAPI::rankingListsGot, this, &AppController::rankingListsGot);
    connect(m_api, &NeteaseAPI::lyricGot, this, &AppController::lyricGot);
    connect(m_api, &NeteaseAPI::hotspotGot, this, &AppController::hotspotGot);
    connect(m_api, &NeteaseAPI::bannersGot, this, &AppController::bannersGot);
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

void AppController::getBanners()
{
    m_api->getBanners();
}


void AppController::addPlaylistItem(QString id, QString name, QUrl mp3Url,
                                    QUrl picUrl, QString artist, QString album, int duration)
{
    m_playlistModel->addSong(id, name, mp3Url, picUrl, artist, album, duration);
}

Song* AppController::getNextPlaylistItem(QString id)
{
    return m_playlistModel->getNextSong(id);
}

Song* AppController::getPlaylistItemById(QString id)
{
    return m_playlistModel->getSongById(id);
}


PlaylistModel *AppController::playlistModel() const
{
    return m_playlistModel;
}

void AppController::setPlaylistModel(PlaylistModel *playlistModel)
{
    if (m_playlistModel != playlistModel) {
        m_playlistModel = playlistModel;
        emit playlistModelChanged();
    }
}



