import QtQuick 2.0

Column {
    width: 100
    height: childrenRect.height

    property alias title: txt.text

    Text {
        id: txt
        color: "black"
        font.pixelSize: 18
    }

    Item { width: parent.width; height: 5 }

    Rectangle {
        width: 100
        height: 6
        color: sep.color
    }

    HSep { id: sep; width: parent.width }
}
