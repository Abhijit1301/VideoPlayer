#include <QtDebug>
#include <QFileInfo>

#include "VideoFileHandler.h"

VideoFileHandler::VideoFileHandler(QSharedPointer<WindowsFileSelectionHandler> platformSpecificVideoFileHandler)
    : m_platformSpecificVideoFileHandler(platformSpecificVideoFileHandler)
{
    qDebug() << "This is the constructor of Video File Handler Class.......................";
}

VideoFileHandler::~VideoFileHandler()
{
}

QString VideoFileHandler::getVideoFilePath()
{
    QString filePath = QString(m_platformSpecificVideoFileHandler->getVideoFilePath().c_str());
    qDebug() << "\nfile path received from platform specific handler = " << filePath;
    QFileInfo videoFileInfo(filePath);
    qDebug() << "is existing? " << videoFileInfo.exists() << " is a file? " << videoFileInfo.isFile() << " convert to forward slashed path = " << videoFileInfo.absolutePath()
             << " file name = " << videoFileInfo.fileName();
//    qDebug() << "replacing \\ with /" << filePath.replace("\\", "/");
    return videoFileInfo.absolutePath() + "/" + videoFileInfo.fileName();
}
