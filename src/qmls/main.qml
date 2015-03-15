import QtQuick 2.2
import QtQuick.Window 2.1

Window {
    visible: true
    width: 680
    height: 460
    color: "transparent"

    Item {
        id: window_content
        anchors.fill: parent

        Rectangle {
            id: background
            color: Qt.rgba(1, 1, 1, 0.8)
            anchors.fill: parent
        }

        Header {
            id: header
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
