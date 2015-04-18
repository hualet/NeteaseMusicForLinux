#ifndef NETEASEAPI_H
#define NETEASEAPI_H

#include <QObject>
#include <QMap>
#include <QJsonObject>

class QNetworkAccessManager;
class QNetworkRequest;
class QNetworkReply;
class QUrl;
class NeteaseAPI: public QObject
{
    Q_OBJECT
public:
    NeteaseAPI(QObject *parent=0);
    ~NeteaseAPI();

    void login(QString, QString);
    void topPlaylist(QString category="全部", QString order="hot", quint8 offset=0, quint8 limit=50);
    void playlistDetail(QString);
    void rankingLists();
    void getLyric(QString);
    void hotspot();
    void getBanners();

signals:
    void loginSucceed(QString info);
    void loginFailed();
    void topPlaylistGot(QString playlists);
    void playlistDetailGot(QString detail);
    void rankingListsGot(QString lists);
    void lyricGot(QString lyric);
    void hotspotGot(QString hotspot);
    void bannersGot(QString banners);

private slots:
    void handleLoginFinished();
    void handleTopPlaylistFinished();
    void handlePlaylistDetailFinished();
    void handleRankingListsFinished();
    void handleGetLyricFinished();
    void handleHotspotFinished();
    void handleGetBannersFinished();

private:
    QNetworkAccessManager *m_networkManager;
    QMap<QString, QString> m_headerMap;

    void setHeaderForRequest(QNetworkRequest& request);

    QNetworkReply* get(const QUrl&);
    QNetworkReply* post(const QUrl&, const QByteArray& data);
};

#endif // NETEASEAPI_H
