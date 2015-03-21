import QtQuick 2.0

Item {
    id: root
    width: 100
    height: 62

    property real progress: 0

    onProgressChanged: handle.x = root.width * progress - handle.width / 2

    Rectangle {
        width: parent.width
        height: 6
        radius: height / 2
        color: Qt.rgba(0, 0, 0, 0.3)
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            width: parent.width * root.progress
            height: parent.height
            color: "red"
            radius: height / 2
        }

        Rectangle {
            id: handle
            width: 12
            height: 12
            radius: 5
            color: "white"
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                width: 4
                height: 4
                radius: 2
                color: "red"
                anchors.centerIn: parent
            }
        }
    }
}
