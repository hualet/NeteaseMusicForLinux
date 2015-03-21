import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    default property alias contents: item.children

    Item {
        id: place_holder
        width: parent.width
        height: 30
    }

    Item {
        id: item
        clip: true
        width: parent.width
        anchors.top: place_holder.bottom
        anchors.bottom: parent.bottom
    }
}
