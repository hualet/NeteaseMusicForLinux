import QtQuick 2.0

Rectangle {
    id: root
    width: 200
    height: 430
    color: Qt.rgba(1, 1, 1, 0.3)
    clip: true

    signal playlistClicked(string playlistId)

    function setCreatedPlaylists(playlists) {
        created_playlists.setData(playlists)
    }

    function setMarkedPlaylists(playlists) {
        marked_playlists.setData(playlists)
    }

    Flickable {
        width: user_playlists_column.width
        height: user_playlists_column.height
        contentWidth: user_playlists_column.childrenRect.width
        contentHeight: user_playlists_column.childrenRect.height
        clip: true

        Column {
            id: user_playlists_column
//            clip: true
            width: root.width - 20
            height: 400
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10

            Text {
                width: parent.width
                height: implicitHeight
                text: "创建的歌单"
                color: "grey"
            }

            SideBarPlaylists {
                id: created_playlists
                width: parent.width - 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                onPlaylistClicked: root.playlistClicked(playlistId)
            }

            Text {
                width: parent.width
                height: implicitHeight
                text: "收藏的歌单"
                color: "grey"
            }

            SideBarPlaylists {
                id: marked_playlists
                width: parent.width - 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                onPlaylistClicked: root.playlistClicked(playlistId)
            }
        }
    }
}

