#include "appcontroller.h"
#include <QDebug>

AppController::AppController(QObject *parent) :
    QObject(parent)
{
    m_api = new NeteaseAPI(this);
    m_database = new Database(this);
    m_playlistModel = new PlaylistModel(m_database, this);

    connect(m_api, &NeteaseAPI::loginSucceed, this, &AppController::loginSucceed);
    connect(m_api, &NeteaseAPI::loginFailed, this, &AppController::loginFailed);
    connect(m_api, &NeteaseAPI::userPlaylistGot, this, &AppController::userPlaylistsGot);
    connect(m_api, &NeteaseAPI::topPlaylistGot, this, &AppController::topPlaylistsGot);
    connect(m_api, &NeteaseAPI::playlistDetailGot, this, &AppController::playlistDetailGot);
    connect(m_api, &NeteaseAPI::rankingListsGot, this, &AppController::rankingListsGot);
    connect(m_api, &NeteaseAPI::lyricGot, this, &AppController::lyricGot);
    connect(m_api, &NeteaseAPI::hotspotGot, this, &AppController::hotspotGot);
    connect(m_api, &NeteaseAPI::bannersGot, this, &AppController::bannersGot);
}

void AppController::login(QString account, QString password)
{
    m_api->login(account, password);
}

void AppController::getUserPlaylists(QString uid) {
    m_api->userPlaylist(uid);
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


void AppController::addPlaylistItem(QString id, QString name, QString mp3Url,
                                    QString picUrl, QString artist, QString album, int duration)
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



