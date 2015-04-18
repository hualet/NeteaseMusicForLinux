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

    Column {
        id: user_playlists_column
        spacing: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right

        Text {
            text: "创建的歌单"
            color: "grey"
        }

        SideBarPlaylists {
            id: created_playlists
            width: parent.width - 20
            anchors.left: parent.left
            anchors.leftMargin: 20

            onPlaylistClicked: root.playlistClicked(playlistId)
        }

        Text {
            text: "收藏的歌单"
            color: "grey"
        }

        SideBarPlaylists {
            id: marked_playlists
            width: parent.width - 20
            anchors.left: parent.left
            anchors.leftMargin: 20

            onPlaylistClicked: root.playlistClicked(playlistId)
        }
    }
}

