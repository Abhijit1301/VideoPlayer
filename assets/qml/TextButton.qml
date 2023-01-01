import QtQuick

Rectangle {
    id: textButtonWrapper

    property bool isExpanded: false
    property alias buttonText: welcomeText.text

    signal buttonClicked

    width: welcomeText.width + 20
    height: welcomeText.height + 10
    color: "#299F9B"

    border {
        width: 1
        color: "red"
    }

    Text {
        id: welcomeText

        anchors.centerIn: parent
        font.pointSize: 15
        font.letterSpacing: 1
        text: "Hello World!"
    }

    MouseArea {
        id: wrapperMouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            console.error("Getting clicked in the button")

        }
        onPressed: {
            console.error("Getting pressed in the button")
            textButtonWrapper.color = "#BFF1EF"
            welcomeText.font.pointSize = 13
            welcomeText.font.letterSpacing = 0
        }
        onReleased: {
            console.error("Getting released in the button")
            textButtonWrapper.color = "#299F9B"
            welcomeText.font.pointSize = 15
            welcomeText.font.letterSpacing = 1
            buttonClicked()
        }
    }
}
