#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include "frameless.h"
#include <QQuickStyle>
#include <QQmlContext>
#include <QDir>
#include "Backed.h"
#include "./pages/QianProjectPages/QianDragViewPage/qiandrageventcatch.h"



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Some organization");
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");


    QQmlApplicationEngine engine;

    qmlRegisterType<QianDragEventCatch>("Qt.QianDragEventCatch", 1, 0, "QianDragEventCatch");
    qmlRegisterType<FramelessWindow>("Qt.Window", 1, 0, "Frameless");
    qmlRegisterSingletonType(QUrl("qrc:/common/SkinModel.qml"), "Qt.Singleton", 1, 0, "SkinSingleton");
    qmlRegisterSingletonType<Backed>("Qt.Backed", 1, 0, "Backed", Backed_qobject_provider);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
