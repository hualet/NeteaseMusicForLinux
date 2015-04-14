#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>

#include "appcontroller.h"
#include "song.h"
#include "playlist_model.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    AppController controller;

    qRegisterMetaType<PlaylistModel*>("PlaylistModel*");
    qmlRegisterType<Song>("Org.Hualet.Widgets", 1, 0, "Song");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_controller", &controller);
    engine.load(QUrl(QStringLiteral("qrc:/src/qmls/main.qml")));

    return app.exec();
}
