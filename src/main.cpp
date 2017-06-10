/*
 *  main.cpp
 *
 *  Main entry point into the Matrix app
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <signal.h>
#include <unistd.h>

void signal_callback(int signum)
{
    if (signum == SIGHUP) {
        printf("Terminating matrix through SIGHUP\n");
        _exit(1);
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    signal(SIGHUP, signal_callback);

    engine.addImportPath("qrc:///Matrix");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
