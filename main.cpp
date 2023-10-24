#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "txtreader.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    TxtReader txt_reader;
    QQmlContext* root_context = engine.rootContext();
    root_context->setContextProperty("TxtReader", &txt_reader);

    const QUrl url(u"qrc:/TypeTrainer/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
