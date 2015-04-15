#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>

#include "appcontroller.h"
#include "song.h"
#include "playlist_model.h"
#include "htsettings.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Hualet");
    app.setOrganizationDomain("hualet.org");
    app.setApplicationName("NeteaseMusicForLinux");

    AppController controller;
    HTSettings settings;

    qRegisterMetaType<PlaylistModel*>("PlaylistModel*");
    qmlRegisterType<Song>("Org.Hualet.Widgets", 1, 0, "Song");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_controller", &controller);
    engine.rootContext()->setContextProperty("_settings", &settings);
    engine.load(QUrl(QStringLiteral("qrc:/src/qmls/main.qml")));

    return app.exec();
}
