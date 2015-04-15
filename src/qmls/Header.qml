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
            normalImage: "qrc:/images/left_arrow_normal.png"
            hoverPressedImage: "qrc:/images/left_arrow_hover.png"
            inactiveImage: "qrc:/images/left_arrow_inactive.png"

            onClicked: root.goBack()
        }
        HTImageButton {
            id: go_forward_button
            normalImage: "qrc:/images/right_arrow_normal.png"
            hoverPressedImage: "qrc:/images/right_arrow_hover.png"
            inactiveImage: "qrc:/images/right_arrow_inactive.png"

            onClicked: root.goForward()
        }
    }
}

