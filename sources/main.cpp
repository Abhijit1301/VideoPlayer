#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>

#include "Windows/WindowsFileSelectionHandler.h"
#include "VideoFileHandler/VideoFileHandler.h"

int main(int argc, char *argv[])
{
    WindowsFileSelectionHandler windowsHandler;
    VideoFileHandler* videoFileHandler = new VideoFileHandler(QSharedPointer<WindowsFileSelectionHandler>(&windowsHandler));
//    qDebug() << "let's request the video file path, shall we?";
////    qDebug() << "Well, what did we get?" << videoFileHandler->getVideoFilePath();
    QGuiApplication app(argc, argv);

    QQuickView view;
    view.rootContext()->setContextProperty("VideoFileHandler", videoFileHandler);
    view.setSource(QUrl("qrc:///assets/qml/main.qml"));
    view.show();
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    return app.exec();
}
