#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QLoggingCategory>

int main( int argc, char* argv[] ) {
    QGuiApplication app( argc, argv );

    //    QLoggingCategory::setFilterRules( QStringLiteral( "qt.qml.binding.removal.info=true" ) );

    QQmlApplicationEngine engine;
    const QUrl url( u"qrc:/ColorTools/main.qml"_qs );
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url]( QObject* obj, const QUrl& objUrl ) {
            if ( ( obj == nullptr ) && url == objUrl ) {
                QCoreApplication::exit( -1 );
            }
        },
        Qt::QueuedConnection );
    engine.load( url );

    return QGuiApplication::exec();
}
