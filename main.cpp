#include <QGuiApplication>
#include <QQmlApplicationEngine>

using namespace Qt::Literals;

int main( int argc, char* argv[] ) {

    QGuiApplication app( argc, argv );

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app, []() { QCoreApplication::exit( -1 ); }, Qt::QueuedConnection );
    engine.loadFromModule( "ColorTools"_L1, "Main"_L1 );

    return QGuiApplication::exec();
}
