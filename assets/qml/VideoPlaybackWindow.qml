import QtQuick
import QtMultimedia

Rectangle {
    property alias videoFileSource: videoPlayer.source
    property alias player: videoPlayer
    property bool dragEndShouldResumePlayback: false

    signal fullScreenRequested()
    signal exitPlayback()

    function pausePlayback() {
        videoPlayer.pause()
        playButton.iconSource = "qrc:///assets/icons/play.png"
    }

    function resumePlayback() {
        videoPlayer.play()
        playButton.iconSource = "qrc:///assets/icons/pause.png"
    }

    visible: true
    color: "#1A3A29"
    anchors.fill: parent

    Video {
        id: videoPlayer

        width: parent.width - 50
        height: parent.height - 100
        anchors.centerIn: parent
//        anchors.topMargin: -50
        source: ""

        focus: true
        Keys.onSpacePressed: videoPlayer.playbackState === MediaPlayer.PlayingState ? videoPlayer.pause() : videoPlayer.play()
        Keys.onLeftPressed: videoPlayer.seek(videoPlayer.position - 5000)
        Keys.onRightPressed: videoPlayer.seek(videoPlayer.position + 5000)

        MouseArea {
            id: videoPlaybackWindowMouseArea

            anchors.fill: parent
            hoverEnabled: true
        }

        onStopped: {
            console.info("video playback has stopped")
            playButton.visible = false
            replayButton.visible = true
        }
    }

    IconButton {
        id: playButton

        isExpanded: false
        iconSource: "qrc:///assets/icons/pause.png"
        anchors.centerIn: parent
        visible: videoPlaybackWindowMouseArea.containsMouse ? true : false

        onButtonClicked: {
            if (videoPlayer.playbackState === MediaPlayer.PlayingState) {
                pausePlayback()
            } else {
                resumePlayback()
            }
        }
    }

    IconButton {
        id: replayButton

        isExpanded: false
        iconSource: "qrc:///assets/icons/re-play.png"
        anchors.centerIn: parent
        visible: false

        onButtonClicked: {
            replayButton.visible = false
            playButton.visible = true
            resumePlayback()
        }
    }

    IconButton {
        id: exitButton

        isExpanded: false
        iconSource: "qrc:///assets/icons/white-cross.png"
        visible: videoPlaybackWindowMouseArea.containsMouse ? true : false
        height: 30
        width: 25

        anchors {
            right: videoPlayer.right
            rightMargin: 10
            top: videoPlayer.top
            topMargin: 20
        }

        onButtonClicked: {
            videoPlayer.stop()
            exitPlayback()
        }
    }

    ProgressBar {
        id: playerProgressBar

        anchors {
            top: videoPlayer.bottom
            topMargin: 0
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }

        totalTime: videoPlayer.duration
        currentTime: videoPlayer.position
        onDragStarted: {
            if (videoPlayer.playbackState === MediaPlayer.PlayingState) {
                dragEndShouldResumePlayback = true
            }

            pausePlayback();
        }

        onDragEnded: function(playbackTime) {
            videoPlayer.seek(playbackTime)
            if (dragEndShouldResumePlayback) {
                resumePlayback()
                dragEndShouldResumePlayback = false
            }
        }

        onFullScreenIconClicked: {
            console.info("signal chaining of expand button released.........")
            fullScreenRequested()
        }
    }
}
