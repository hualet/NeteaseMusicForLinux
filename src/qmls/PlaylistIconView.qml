import QtQuick 2.0
import QtGraphicalEffects 1.0

GridView {
    id: grid_view
    cellWidth: 190
    cellHeight: 190
    cacheBuffer: 8
    clip: true

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

            LinearGradient {
                width: parent.width
                height: 20
                visible: play_count_text.text
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)
                anchors.top: parent.top

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0) }
                    GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.5) }
                }

                Row {
                    height: parent.height
                    spacing: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5

                    Image {
                        source: "qrc:/images/headphone.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        id: play_count_text
                        color: "white"
                        text: playCount || ""
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            LinearGradient {
                width: parent.width
                height: 20
                visible: creator_text.text
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)
                anchors.bottom: parent.bottom

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0.5) }
                    GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0) }
                }

                Row {
                    height: parent.height
                    spacing: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    Image {
                        source: "qrc:/images/user_icon.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        id: creator_text
                        color: "white"
                        text: (creator && creator["nickname"]) || ""
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
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
            if (!playlist["coverImgUrl"]) playlist["coverImgUrl"] = playlist["picUrl"]
            if (!playlist["playCount"]) playlist["playCount"] = ""
            if (!playlist["creator"]) playlist["creator"] = {}
            model.append(playlist)
        })
    }
}
