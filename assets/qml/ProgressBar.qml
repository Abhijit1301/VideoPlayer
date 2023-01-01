import QtQuick

Item {
    id: root

    property int totalTime: 0
    property int currentTime: 0
    property bool interactive: true
    property string formattedTotalTime: "00:00"

    height: 20

    signal dragStarted()
    signal dragEnded(int playbackTime)
    signal fullScreenIconClicked()

    function padTo2Digits(num) {
        return num.toString().padStart(2, '0');
    }

    function convertMsToTime(milliseconds) {
        let seconds = Math.floor(milliseconds / 1000);
        let minutes = Math.floor(seconds / 60);
        let hours = Math.floor(minutes / 60);

        seconds = seconds % 60;
        minutes = minutes % 60;

        if (hours === 0) {
            return `${padTo2Digits(minutes)}:${padTo2Digits(seconds)}`;
        }

        return `${padTo2Digits(hours)}:${padTo2Digits(minutes)}:${padTo2Digits(seconds)}`;
    }

    function getSliderGripPosition() {
        var initialPosition = sliderGrip.width/2
        if (currentTime === 0 || totalTime === 0) {
            return 0 - initialPosition;
        }
        return Math.round((Math.min(currentTime, totalTime) / totalTime) * sliderBar.width - initialPosition);
    }

    function getCursorPositionTime(cursorPosition) {
        const timeAtCursor = (cursorPosition/ sliderBar.width) * totalTime;
        console.info("cursor position = ", cursorPosition, "  Calculating time at cursor pointer", timeAtCursor)
        return convertMsToTime(timeAtCursor)
    }

    Item {
        id: sliderBar

        anchors.centerIn: parent
        width: root.width
        height: 5

        BorderImage {
            id: baseImage

            source: "qrc:///assets/icons/white-bar.png"
            width: sliderBar.width
            anchors.right: sliderBar.right
            height: sliderBar.height
            border.left: 1; border.top: 2
            border.right: 1; border.bottom: 2
        }


        BorderImage {
            id: overlayImage

            source: "qrc:///assets/icons/red-bar.png"
            width: sliderGrip.x + sliderGrip.width / 2
            height: sliderBar.height
            border.left: 1; border.top: 2
            border.right: 1; border.bottom: 2
        }

        Image {
            id: sliderGrip

            width: 15
            height: 15
            property int gripPosition: x + width/2
            x: getSliderGripPosition()
            y: parent.y - 12
            source: "qrc:///assets/icons/slider-grip.png"
            onGripPositionChanged: {
                console.info("slider grip position changed: ", gripPosition)
            }
        }

        Text {
            id: playTime

            height: 14
            text: convertMsToTime(currentTime) + "/" + formattedTotalTime
            font.pointSize: 10
            color: "#ffffff"

            anchors {
                top: parent.bottom
                topMargin: 5
            }
        }

        Rectangle {
            id: cursorTimerWrapper

//            color: "#ffffff"
            color: "transparent"
            visible: false

            height: cursorPositionTime.height
            width: cursorPositionTime.width

            anchors.bottom: parent.top
            anchors.bottomMargin: 7
            x: sliderGrip.x

            Text {
                id: cursorPositionTime

                height: 11
                text: visible ? getCursorPositionTime(parent.x + sliderGrip.width/2) : "00:00"
                font.pointSize: 10
                color: "#ffffff"

                anchors.centerIn: parent
            }
        }

        Image {
            id: fullScreenIcon

            source: "qrc:///assets/icons/expand-to-full-screen.png"
            height: 30
            width: 30
            anchors {
                left: playTime.right
                leftMargin: 20
                top: playTime.top
            }

            MouseArea {
                anchors.fill: parent

                cursorShape: Qt.PointingHandCursor

                onPressed: {
                    fullScreenIcon.width = 25
                    fullScreenIcon.height = 25
                    console.info("expand button pressed.........")
                }

                onReleased: {
                    console.info("expand button released.........")
                    fullScreenIcon.width = 30
                    fullScreenIcon.height = 30
                    fullScreenIconClicked()
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.interactive

            drag {
                target: sliderGrip
                axis: Drag.XAxis
                minimumX: -(sliderGrip.width / 2)
                maximumX: sliderBar.width - (sliderGrip.width / 2)
            }

            function dragToPosition(position) {
                var playbackTime = position * totalTime / sliderBar.width
                console.log("dragging to position: ", position, " playback time = ", playbackTime)
                dragEnded(playbackTime)
            }

            onClicked: dragToPosition(mouseX)

            property bool dragActive: drag.active

            onDragActiveChanged: {
                if (!dragActive) {
                    dragToPosition(sliderGrip.gripPosition)
                    cursorTimerWrapper.visible = false
                } else {
                    cursorTimerWrapper.visible = true
                    dragStarted()
                }
            }

            cursorShape: Qt.PointingHandCursor
        }
    }

    onTotalTimeChanged:  {
        formattedTotalTime = convertMsToTime(totalTime)
    }
}
