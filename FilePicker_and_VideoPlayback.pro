QT += quick

SOURCES += \
        sources/VideoFileHandler/VideoFileHandler.cpp \
        sources/Windows/WindowsFileSelectionHandler.cpp \
        sources/main.cpp

RESOURCES += \
    projectResources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

INCLUDEPATH += ../FilePicker_and_VideoPlayback/source/

HEADERS += \
    sources/VideoFileHandler/VideoFileHandler.h \
    sources/Windows/WindowsFileSelectionHandler.h

LIBS += -luser32 -lole32

#-lComdlg32
