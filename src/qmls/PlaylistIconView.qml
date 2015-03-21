import QtQuick 2.0

GridView {
    id: grid_view
    cellWidth: 190
    cellHeight: 190
    cacheBuffer: 8

    model: ListModel {}
    delegate: Item {
        id: delegate_root
        clip: true
        width: grid_view.cellWidth
        height: grid_view.cellHeight

        Image {
            clip: true
            asynchronous: true
            source: coverImgUrl
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            anchors.margins: 20

            Rectangle {
                width: parent.width
                height: 20
                color: Qt.rgba(0, 0, 0, 0.5)
                anchors.top: parent.top
            }
            Rectangle {
                width: parent.width
                height: 20
                color: Qt.rgba(0, 0, 0, 0.5)
                anchors.bottom: parent.bottom
            }

            MouseArea {
                anchors.fill: parent
                onClicked: grid_view.playlistClicked(id)
            }
        }
    }

    signal playlistClicked(string playlistId)

    function setData(data) {
        model.clear()

        var playlists = JSON.parse(data)
        playlists.forEach(function(playlist){
            model.append(playlist)
        })
    }
}
