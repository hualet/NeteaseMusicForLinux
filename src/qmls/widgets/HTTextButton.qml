import QtQuick 2.0

MouseArea {
    id: root
    width: txt.implicitWidth + 14
    height: txt.implicitHeight + 8
    hoverEnabled: true

    property alias text: txt.text

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(1, 1, 1, 0.8)
        radius: 6
        border.color: Qt.rgba(0, 0, 0, 0.4)
    }

    Text {
        id: txt
        color: root.containsMouse ? Qt.rgba(0.2, 0.2, 0.5, 0.8) : Qt.rgba(0, 0, 0, 0.8)
        anchors.centerIn: parent
    }
}
