import QtQuick 2.0
import QtGraphicalEffects 1.0

import "../qmls/utils.js" as Utils

Item {
    id: root
    width: 560
    height: 480

    property alias model: list_view.model
    property string currentSong: ""

    signal songClicked(var song)

    Rectangle {
        radius: 4
        color: Qt.rgba(1, 1, 1, 0.8)
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.3)
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10

        Rectangle {
            anchors.fill: list_view
            anchors.margins: 1
            HSep { width: parent.width }
        }

        ListView {
            id: list_view
            width: parent.width - 2
            height: parent.height - 40
            clip: true
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            delegate: Rectangle {
                width: list_view.width
                height: 36
                color: index % 2 ? Qt.rgba(1, 1, 1, 1) : Qt.rgba(0.5, 0.5, 0.5, 0.1)

                Rectangle {
                    width: 5
                    height: parent.height - 10
                    color: "red"
                    visible: root.currentSong == id
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: name
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: artist
                    anchors.left: parent.left
                    anchors.leftMargin: 300
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: Utils.formatTime(duration)
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.songClicked(list_view.model.getSongAtIndex(index))
                }
            }
        }
    }
}

