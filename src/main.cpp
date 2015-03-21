#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <src/netease_api/neteaseapi.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/qmls/main.qml")));

    NeteaseAPI api;
    QString username("");
    QString password("");
    api.login(username, password);
    api.topPlaylist();

    return app.exec();
}
