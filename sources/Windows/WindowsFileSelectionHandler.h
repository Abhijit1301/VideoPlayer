#ifndef FILE_PICKER_AND_VIDEO_PLAYBACK_WINDOWS_FILE_SELECTION_HANDLER_H
#define FILE_PICKER_AND_VIDEO_PLAYBACK_WINDOWS_FILE_SELECTION_HANDLER_H
#include <string>

class WindowsFileSelectionHandler {
public:
    WindowsFileSelectionHandler();
    ~WindowsFileSelectionHandler();
    void openDialog();
    std::string getVideoFilePath();
};

#endif // FILE_PICKER_AND_VIDEO_PLAYBACK_WINDOWS_FILE_SELECTION_HANDLER_H
