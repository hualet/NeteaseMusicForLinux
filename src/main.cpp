#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "appcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    AppController controller;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_controller", &controller);
    engine.load(QUrl(QStringLiteral("qrc:/src/qmls/main.qml")));

    return app.exec();
}
