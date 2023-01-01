#ifndef FILE_PICKER_AND_VIDEO_PLAYBACK_VIDEO_FILE_HANDLER_H
#define FILE_PICKER_AND_VIDEO_PLAYBACK_VIDEO_FILE_HANDLER_H

#include <QObject>
#include <QSharedPointer>
#include "../Windows/WindowsFileSelectionHandler.h"

class VideoFileHandler: public QObject {
    Q_OBJECT

public:
    VideoFileHandler(QSharedPointer<WindowsFileSelectionHandler> platformSpecificVideoFileHandler);
    ~VideoFileHandler();
    Q_INVOKABLE QString getVideoFilePath();

private:
    QSharedPointer<WindowsFileSelectionHandler> m_platformSpecificVideoFileHandler;
};

#endif // FILE_PICKER_AND_VIDEO_PLAYBACK_VIDEO_FILE_HANDLER_H
