import QtQuick 2.0

Item {
    width: 100
    height: 70

    Rectangle {
        anchors.fill: parent
        color: "red"
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.1)
    }

    Text {
        color: "white"
        text: "网易云音乐"
        font.pixelSize: 24

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
    }
}

