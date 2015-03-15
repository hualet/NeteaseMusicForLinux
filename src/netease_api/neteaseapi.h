#ifndef NETEASEAPI_H
#define NETEASEAPI_H

#include <QObject>
#include <QMap>

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

    QJsonObject& login(QString &, QString &);

private:
    QNetworkAccessManager *m_networkManager;
    QMap<QString, QString> m_headerMap;

    void setHeaderForRequest(QNetworkRequest request);

    QNetworkReply* get(const QUrl&);
    QNetworkReply* post(const QUrl&, const QByteArray& data);
};

#endif // NETEASEAPI_H
