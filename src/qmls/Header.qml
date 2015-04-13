import QtQuick 2.0

import "../qmls/widgets"

Item {
    id: root
    width: 100
    height: 70

    property alias canGoBack: go_back_button.enabled
    property alias canGoForward: go_forward_button.enabled

    signal goBack()
    signal goForward()

    Rectangle {
        anchors.fill: parent
        color: "red"
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.1)
    }

    Text {
        id: title_text
        color: "white"
        text: "网易云音乐"
        font.pixelSize: 24

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
    }

    Row {
        anchors.left: title_text.right
        anchors.leftMargin: 80
        anchors.verticalCenter: parent.verticalCenter

        HTImageButton {
            id: go_back_button
            width: 32
            height: 32
            normalImage: "qrc:/images/left-arrow-normal.png"
            hoverPressedImage: "qrc:/images/left-arrow-hover.png"
            inactiveImage: "qrc:/images/left-arrow-inactive.png"

            onClicked: root.goBack()
        }
        HTImageButton {
            id: go_forward_button
            width: 32
            height: 32
            normalImage: "qrc:/images/right-arrow-normal.png"
            hoverPressedImage: "qrc:/images/right-arrow-hover.png"
            inactiveImage: "qrc:/images/right-arrow-inactive.png"

            onClicked: root.goForward()
        }
    }
}

