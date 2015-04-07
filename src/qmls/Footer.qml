import QtQuick 2.0

import "../qmls/widgets"

Item {
    id: root
    width: 100
    height: 50

    property alias playing: play_pause_button.playing
    property alias progress: progress_bar.progress
    property alias timeInfo: time_info.text
    property alias volume: volume_button.volume
    property alias muted: volume_button.muted

    signal mutedSet(bool muted)
    signal play()
    signal pause()
    signal seek(real progress)
    signal volumeSet(real volume)

    Rectangle {
        anchors.fill: parent
        color: "red"
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.1)
    }

    Row {
        id: button_row
        height: parent.height
        spacing: 15
        anchors.left: parent.left
        anchors.leftMargin: 20

        HTImageButton {
            normalImage: "qrc:/images/prev_normal.png"
            hoverPressedImage: "qrc:/images/prev_hover_pressed.png"

            anchors.verticalCenter: parent.verticalCenter
        }

        HTImageButton {
            id: play_pause_button
            normalImage: playing ? "qrc:/images/pause_normal.png" : "qrc:/images/play_normal.png"
            hoverPressedImage: playing ? "qrc:/images/pause_hover_pressed.png" : "qrc:/images/play_hover_pressed.png"

            property bool playing: false

            anchors.verticalCenter: parent.verticalCenter

            onClicked: playing ? root.pause() : root.play()
        }

        HTImageButton {
            normalImage: "qrc:/images/next_normal.png"
            hoverPressedImage: "qrc:/images/next_hover_pressed.png"

            anchors.verticalCenter: parent.verticalCenter
        }
    }

    HTProgressBar {
        id: progress_bar
        width: 300
        anchors.left: button_row.right
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter

        onSeek: root.seek(progress)
    }

    Text {
        id: time_info
        color: "white"
        anchors.left: progress_bar.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    HTVolumeButton {
        id: volume_button
        anchors.left: time_info.right
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        onMutedSet: root.mutedSet(muted)
        onVolumeSet: root.volumeSet(volume)
    }
}
