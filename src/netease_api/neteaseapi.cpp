#include "neteaseapi.h"

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QUrlQuery>
#include <QJsonObject>
#include <QJsonDocument>

NeteaseAPI::NeteaseAPI():
    m_networkManager(new QNetworkAccessManager(this))
{
    m_headerMap["Accept"] = "*/*";
    m_headerMap["Accept-Encoding"] = "gzip,deflate,sdch";
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

QJsonObject& NeteaseAPI::login(QString &username, QString &password)
{
    QUrl url("http://music.163.com/api/login/");
    QUrlQuery params;
    params.addQueryItem("username", username);
    params.addQueryItem("password", password);
    params.addQueryItem("rememberLogin", "true");

    QNetworkReply *reply = post(url, params.query(QUrl::FullyEncoded).toUtf8());
    QJsonObject object;
    if (!reply->error()) {
        QByteArray array = reply->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        object = document.object();

    }
    return object;
}

// private methods
void NeteaseAPI::setHeaderForRequest(QNetworkRequest request)
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
