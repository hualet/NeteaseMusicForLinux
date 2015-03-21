import QtQuick 2.0

Item {
    id: root
    width: volume_icon.width + volume_bar.width
    height: Math.max(volume_icon.height, volume_bar.height)

    property bool muted: false
    property alias volume: volume_bar.progress

    signal mutedSet(bool muted)

    HTImageButton {
        id: volume_icon
        normalImage: root.muted ? "qrc:/images/muted_normal.png" : "qrc:/images/volume_normal.png"
        hoverPressedImage: root.muted? "qrc:/images/muted_hover_pressed.png" : "qrc:/images/volume_hover_pressed.png"
        anchors.verticalCenter: parent.verticalCenter

        onClicked: root.mutedSet(!root.muted)
    }

    HTProgressBar {
        id: volume_bar
        visible: !root.muted
        width: 100
        anchors.left: volume_icon.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }
}
