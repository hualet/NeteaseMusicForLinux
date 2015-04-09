import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 335
    height: 400
    clip: true

    property bool playing: false
    property alias picUrl: cover_image.source

    Image {
        id: disc_image
        source: "qrc:/images/disc_disc.png"
        anchors.centerIn: image_area
    }

    Item {
        id: image_area
        width: disc_image.implicitWidth
        height: disc_image.implicitHeight
        visible: false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Image { id: cover_image; width: 200; height: 200; anchors.centerIn: parent }
    }

    Item {
        id: mask
        anchors.fill: image_area

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

    Image {
        source: "qrc:/images/disc_mask.png"
        anchors.centerIn: image_area
    }

    Image {
        x: 250
        y: -5
        transformOrigin: Item.topLeft
//        rotation: root.playing ? 0 : 30
        source: "qrc:/images/disc_needle.png"
    }

    PropertyAnimation {
        property: "rotation"
        target: opacity_mask
        from: 0
        to: 360
        duration: 30 * 1000
        running: root.playing
        loops: Animation.Infinite
    }
}

