import QtQuick 2.0
import QtGraphicalEffects 1.0

import "../qmls/widgets"

Item {
    id: root
    width: 100
    height: 80
    state: "mini"

    property url picUrl
    property string artist
    property string song

    states: [
        State {
            name: "mini"
            PropertyChanges {
                target: mini_mode
                visible: true
            }
            PropertyChanges {
                target: fullscreen_mode
                visible: false
            }
        },
        State {
            name: "fullscreen"
            PropertyChanges {
                target: mini_mode
                visible: false
            }
            PropertyChanges {
                target: fullscreen_mode
                visible: true
            }
        }
    ]

    HSep { width: parent.width }

    Item {
        id: mini_mode
        anchors.fill: parent

        Row {
            height: parent.height
            spacing: 20

            Item { width: 1; height: parent.height }

            Item {
                id: mini_cover
                width: 60
                height: 60

                anchors.verticalCenter: parent.verticalCenter

                Image {
                    source: root.picUrl
                    anchors.fill: parent

                    Rectangle {
                        id: image_cover
                        color: fullscreen_mouse_area.containsMouse ? Qt.rgba(0, 0, 0, 0.3) : "transparent"
                        border.width: 1
                        border.color: Qt.rgba(0, 0, 0, 0.3)
                        anchors.fill: parent
                    }

                    MouseArea {
                        id: fullscreen_mouse_area
                        hoverEnabled: true
                        anchors.fill: parent

                        onClicked: root.state = "fullscreen"
                    }
                }
            }

            Column {
                spacing: 10
                width: mini_mode.width - mini_cover.width
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: root.song
                }
                Text {
                    text: root.artist
                }
            }
        }
    }

    Item {
        id: fullscreen_mode
        anchors.fill: parent

        Image {
            id: background_image
            opacity: 0.6
            source: root.picUrl
            anchors.fill: parent
        }

        FastBlur {
            anchors.fill: background_image
            source: background_image
            radius: 64
        }

        Rectangle {
            anchors.fill: background_image
            color: Qt.rgba(1, 1, 1, 0.8)
        }

        Row {
            height: parent.height

            RunningDisc { picUrl: root.picUrl }
        }
    }
}

