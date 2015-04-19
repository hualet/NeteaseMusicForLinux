import QtQuick 2.0
import QtQuick.Controls 1.2

Flickable {
    id: root
    clip: true
    default property alias contents: item.children

    Item {
        id: place_holder
        width: root.width
        height: 30
    }

    Item {
        id: item
        clip: true
        width: root.width
        height: root.contentHeight - place_holder.height
        anchors.top: place_holder.bottom
    }
}
