import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    width: 300
    height: 300

    property alias picUrl: cover_image.source

    Item {
        id: image_area
        visible: false
        anchors.fill: parent

        Image { id: cover_image; width: 200; height: 200; anchors.centerIn: parent }
    }

    Item {
        id: mask
        anchors.fill: parent

        Rectangle {
            width: cover_image.width
            height: cover_image.height
            radius: 100
            anchors.centerIn: parent
        }
    }

    OpacityMask {
        id: opacity_mask
        source: image_area
        maskSource: mask
        anchors.fill: image_area
    }

    RotationAnimation {
        target: opacity_mask
        from: 0
        to: 360
        duration: 10 * 1000
        running: true
        loops: Animation.Infinite
    }
}

