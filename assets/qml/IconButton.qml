import QtQuick

Rectangle {
    id: iconWrapper

    property bool isExpanded: false
    property alias iconSource: iconImage.source

    signal buttonClicked

    width: isExpanded ? 90 : 70
    height: isExpanded ? 90: 70
    color: "transparent"
//    color: wrapperMouseArea.containsMouse ? "#FAEEEB" : "transparent"
//    color: "transparent"
//    border.color: wrapperMouseArea.containsMouse ? "#EFEFEF" : "#ABABAB"
//    border.width: 5

    Image {
        id: iconImage

        width: iconWrapper.width - 10
        height: iconWrapper.height - 15
        anchors.centerIn: parent
        source: ""
    }

    MouseArea {
        id: wrapperMouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            buttonClicked()
        }
        onPressed: {
            iconWrapper.color = "#BFF1EF"
            iconImage.height = iconWrapper.height - 25
            iconImage.width = iconWrapper.width - 20
        }
        onReleased: {
            iconWrapper.color = "transparent"
            iconImage.height = iconWrapper.height - 15
            iconImage.width = iconWrapper.width - 10
        }
    }
}
