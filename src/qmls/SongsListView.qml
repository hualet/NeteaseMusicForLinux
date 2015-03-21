import QtQuick 2.0

ListView {
    id: list_view
    width: 100
    height: 100
    currentIndex: -1

    model: ListModel {}
    delegate: Rectangle {
        width: list_view.width
        height: 36
        color: list_view.currentIndex == index ? Qt.rgba(0, 0, 0, 0.2) : "transparent"

        Text {
            text: name
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: list_view.currentIndex = index
            onDoubleClicked: songClicked(mp3Url)
        }
    }

    signal songClicked(string mp3Url)

    function setData(data) {
        model.clear()

        var tracks = JSON.parse(data)
        for (var i = 0; i < tracks.length; i++) {
            model.append(tracks[i])
        }
    }
}
