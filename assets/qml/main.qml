import QtQuick
import QtQml

Item {
    id: root

    width: 940
    height: 640
    visible: true

    property string videoFilePath: ""

    function setFullScreen() {
        root.width = Screen.width
        root.height = Screen.height
    }

    function resetView() {
        root.width = 940
        root.height = 680
    }

    Loader {
        id: content

        anchors.fill: parent

        sourceComponent: textPrompt
    }

    Component {
        id: textPrompt

        Item {
            id: borderrectangleWrapper

            anchors.fill: parent

            TextButton {
                id: borderRectangle

                anchors.centerIn: parent
                buttonText: "Select A Video File to Play."

                onButtonClicked: {
                    var selectedVideoFile = VideoFileHandler.getVideoFilePath()
                    console.debug("obtained video file: " + selectedVideoFile)
                    if (selectedVideoFile === "/") {
                        console.info("No video file chosen.")
                    } else {
                        //                    borderRectangle.visible = false;
                        //                    videoPlaybackRectangle.visible = true
                        root.videoFilePath = selectedVideoFile
                        content.sourceComponent = undefined
                        content.sourceComponent = playerComponent
//                        videoPlaybackRectangle.videoFileSource = selectedVideoFile
//                        videoPlaybackRectangle.player.play()
                    }
                }
            }
        }
    }

    Component {
        id: playerComponent

        VideoPlaybackWindow {
            id: videoPlaybackRectangle

            videoFileSource: ""
            visible: true

            onFullScreenRequested: {
                console.info("Entering full screen..............")
                setFullScreen()
            }

            onExitPlayback: {
                console.info("exiting playback................")
//                videoPlaybackRectangle.visible = false
//                borderRectangle.visible = true
                content.sourceComponent = undefined
                content.sourceComponent = textPrompt
            }
//        }

        Component.onCompleted: {
            console.info("video file path = ", root.videoFilePath)
            videoPlaybackRectangle.videoFileSource = videoFilePath
            videoPlaybackRectangle.player.play()
        }
    }
    }
}
