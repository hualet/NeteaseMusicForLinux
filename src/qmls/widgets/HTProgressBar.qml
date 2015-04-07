import QtQuick 2.0

Item {
    id: root
    width: 100
    height: 62

    property real progress: 0

    signal seek(real progress)

    onProgressChanged: if(!drag_mouse_area.drag.active) handle.x = root.width * progress - handle.width / 2

    Rectangle {
        width: parent.width
        height: 6
        radius: height / 2
        color: Qt.rgba(0, 0, 0, 0.3)
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: root.seek(Math.min(Math.max(handle.width / 2, mouse.x), parent.width - handle.width / 2) / parent.width)
        }

        Rectangle {
            width: parent.width * root.progress
            height: parent.height
            color: "red"
            radius: height / 2

            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: Qt.rgba(1, 1, 1, 0.2)
            }
        }

        Rectangle {
            id: handle
            width: 12
            height: 12
            radius: 5
            color: "white"
            anchors.verticalCenter: parent.verticalCenter

            onXChanged: if(drag_mouse_area.drag.active) root.seek(x / (handle.parent.width - handle.width))

            MouseArea {
                id: drag_mouse_area
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: handle.width / 2
                drag.maximumX: handle.parent.width - handle.width / 2
            }

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
