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
    NeteaseAPI();
    ~NeteaseAPI();

    void login(QString &, QString &);
    void topPlaylist(QString category="全部", QString order="hot", quint8 offset=0, quint8 limit=50);

private slots:
    void handleLoginFinished();
    void handleTopPlaylistFinished();

private:
    QNetworkAccessManager *m_networkManager;
    QMap<QString, QString> m_headerMap;

    void setHeaderForRequest(QNetworkRequest& request);

    QNetworkReply* get(const QUrl&);
    QNetworkReply* post(const QUrl&, const QByteArray& data);
};

#endif // NETEASEAPI_H
