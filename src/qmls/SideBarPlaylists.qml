import QtQuick 2.0

ListView {
    id: list_view
    width: 300
    height: childrenRect.height

    signal playlistClicked(string playlistId)

    model: ListModel{}
    delegate: Item {
        width: list_view.width
        height: txt.implicitHeight + 10
        Text {
            id: txt
            width: parent.width
            text: name
            elide: Text.ElideRight
            color: Qt.rgba(0, 0, 0, 0.9)
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: list_view.playlistClicked(id)
        }
    }

    function setData(playlists) {
        list_view.model.clear()

        for (var i = 0; i < playlists.length; i++) {
            list_view.model.append(playlists[i])
        }
    }
}

