#include "neteaseapi.h"

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>
#include <QTextCodec>

NeteaseAPI::NeteaseAPI(QObject *parent):
    QObject(parent),
    m_networkManager(new QNetworkAccessManager(this))
{
    m_headerMap["Accept"] = "*/*";
//    FixMe: I don't know how to deal with gzipped data with QNetworkReply.
//    m_headerMap["Accept-Encoding"] = "gzip,deflate,sdch";
    m_headerMap["Accept-Language"] = "zh-CN,zh;q=0.8,gl;q=0.6,zh-TW;q=0.4";
    m_headerMap["Connection"] = "keep-alive";
    m_headerMap["Content-Type"] = "application/x-www-form-urlencoded";
    m_headerMap["Host"] = "music.163.com";
    m_headerMap["Referer"] = "http://music.163.com/search/";
    m_headerMap["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36";
}

NeteaseAPI::~NeteaseAPI()
{
}

void NeteaseAPI::login(QString username, QString password)
{
    QUrl url("http://music.163.com/api/login/");
    QUrlQuery params;
    params.addQueryItem("username", username);
    params.addQueryItem("password", QCryptographicHash::hash(password.toUtf8(), QCryptographicHash::Md5).toHex());
    params.addQueryItem("rememberLogin", "true");

    QNetworkReply* reply = post(url, params.query(QUrl::FullyEncoded).toUtf8());
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleLoginFinished);
}

void NeteaseAPI::userPlaylist(QString uid)
{
    QUrl url = QString("http://music.163.com/api/user/playlist");
    QUrlQuery query;
    query.addQueryItem("offset", QString::number(0));
    query.addQueryItem("limit", QString::number(100));
    query.addQueryItem("uid", uid);
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleUserPlaylistFinished);
}

void NeteaseAPI::topPlaylist(QString category, QString order, quint8 offset, quint8 limit)
{
    QUrl url = QString("http://music.163.com/api/playlist/list");
    QUrlQuery query;
    query.addQueryItem("cat", category);
    query.addQueryItem("order", order);
    query.addQueryItem("offset", QString::number(offset));
    query.addQueryItem("total", offset ? "false" : "true");
    query.addQueryItem("limit", QString::number(limit));
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleTopPlaylistFinished);
}

void NeteaseAPI::playlistDetail(QString playlistId)
{
    QUrl url = QString("http://music.163.com/api/playlist/detail");
    QUrlQuery query;
    query.addQueryItem("id", playlistId);
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handlePlaylistDetailFinished);
}

void NeteaseAPI::rankingLists()
{
    QUrl url = QString("http://music.163.com/api/toplist");
    QUrlQuery query;
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleRankingListsFinished);
}

void NeteaseAPI::getLyric(QString songId)
{
    QUrl url = QString("http://music.163.com/api/song/lyric");
    QUrlQuery query;
    query.addQueryItem("os", "osx");
    query.addQueryItem("id", songId);
    query.addQueryItem("lv", "-1");
    query.addQueryItem("kv", "-1");
    query.addQueryItem("tv", "-1");
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleGetLyricFinished);
}

void NeteaseAPI::hotspot()
{
    QUrl url = QString("http://music.163.com/api/discovery/hotspot");
    QUrlQuery query;
    query.addQueryItem("limit", "12");
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleHotspotFinished);
}

void NeteaseAPI::getBanners()
{
    QUrl url = QString("http://music.163.com/api/banner/get");
    QUrlQuery query;
    query.addQueryItem("limit", "8");
    url.setQuery(query.toString(QUrl::FullyEncoded));

    QNetworkReply* reply = get(url);
    connect(reply, &QNetworkReply::finished, this, &NeteaseAPI::handleGetBannersFinished);
}

// slots
void NeteaseAPI::handleLoginFinished()
{
     QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
     if (!reply->error()) {
         QByteArray array = reply->readAll();

         QJsonDocument document = QJsonDocument::fromJson(array);
         QJsonObject object = document.object();
         // TODO: save the info or something here
         emit loginSucceed(QString(document.toJson()));
     } else {
         emit loginFailed();
         qDebug() << "handleLoginFinished error" << reply->errorString();
     }
}

void NeteaseAPI::handleUserPlaylistFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonArray playlist = object["playlist"].toArray();

        if (!playlist.isEmpty()) {
            QJsonDocument document(playlist);
            emit userPlaylistGot(QString(document.toJson()));
        } else {
            qDebug() << "No user playlists found!";
        }
    } else {
        qWarning() << "handleUserPlaylistFinished" << reply->errorString();
    }
}

void NeteaseAPI::handleTopPlaylistFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
//        qDebug() << array;
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonArray playlists = object["playlists"].toArray();

        if (!playlists.isEmpty()) {
            QJsonDocument document(playlists);
            emit topPlaylistGot(QString(document.toJson()));
        } else {
            qDebug() << "No top playlists found!";
        }
    } else {
        qWarning() << "handleTopPlaylistFinished" << reply->errorString();
    }
}

void NeteaseAPI::handlePlaylistDetailFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonObject result = object["result"].toObject();

        if (!result.isEmpty()) {
            QJsonDocument document(result);
            emit playlistDetailGot(QString(document.toJson()));
        } else {
            qDebug() << "No detail found!";
        }
    } else {
        qWarning() << "handlePlaylistDetailFinished" << reply->errorString();
    }
}

void NeteaseAPI::handleRankingListsFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonArray list = object["list"].toArray();

        if (!list.isEmpty()) {
            QJsonDocument document(list);
            emit rankingListsGot(QString(document.toJson()));
        } else {
            qDebug() << "No ranking list found!";
        }
    } else {
        qWarning() << "handleRankingListsFinished" << reply->errorString();
    }
}

void NeteaseAPI::handleGetLyricFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonObject lrc = object["lrc"].toObject();

        if (!lrc.isEmpty()) {
            emit lyricGot(lrc["lyric"].toString());
        } else {
            qDebug() << "No lyric found!";
        }
    } else {
        qWarning() << "handleGetLyricFinished" << reply->errorString();
    }
}

void NeteaseAPI::handleHotspotFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonArray playlists = object["data"].toArray();

        if (!playlists.isEmpty()) {
            QJsonDocument document(playlists);
            emit hotspotGot(QString(document.toJson()));
        } else {
            qDebug() << "No hotspot found!";
        }
    } else {
        qWarning() << "handleHotspotFinished" << reply->errorString();
    }
}

void NeteaseAPI::handleGetBannersFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonObject object = document.object();
        QJsonArray banners = object["banners"].toArray();

        if (!banners.isEmpty()) {
            QJsonDocument document(banners);
            emit bannersGot(QString(document.toJson()));
        } else {
            qDebug() << "No banners found!";
        }
    } else {
        qWarning() << "handleGetBannersFinished" << reply->errorString();
    }
}

// private methods
void NeteaseAPI::setHeaderForRequest(QNetworkRequest &request)
{
    QMapIterator<QString, QString> i(m_headerMap);
    while (i.hasNext()) {
        i.next();
        request.setRawHeader(i.key().toUtf8(), i.value().toUtf8());
    }
}

QNetworkReply* NeteaseAPI::get(const QUrl& url)
{
    QNetworkRequest request(url);
    setHeaderForRequest(request);
    return m_networkManager->get(request);
}

QNetworkReply* NeteaseAPI::post(const QUrl& url, const QByteArray& data)
{
    QNetworkRequest request(url);
    setHeaderForRequest(request);
    return m_networkManager->post(request, data);
}
