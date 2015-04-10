import QtQuick 2.0

import "../qmls/utils.js" as Utils
import "../qmls/widgets"

Item {
    id: root
    width: 500
    height: 500

    property url coverImgUrl
    property string name
    property string creator
    property string createTime
    property string description

    signal songClicked(var song)
    signal playAllClicked()

    function setData(data) { songs_list_view.setData(data) }

    Column {
        id: col
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        Row {
            id: info_area
            width: col.width
            height: 250

            Image {
                id: cover_img
                width: 180
                height: 180
                source: root.coverImgUrl
            }

            Item { width: 20; height: parent.height }

            Column {
                width: info_area.width - 200

                Text {
                    text: root.name
                    font.pixelSize: 20
                }

                Item { width: parent.width; height: 10 }

                Row {
                    width: parent.width
                    spacing: 40

                    Text {
                        text: root.creator
                    }

                    Text {
                        text: Utils.unixTimeToReadable(root.createTime)
                    }
                }

                Item { width: parent.width; height: 10 }

                HTTextButton { text: "播放全部"; onClicked: root.playAllClicked() }

                Item { width: parent.width; height: 10 }

                Text {
                    width: parent.width
                    text: "简介: " + root.description
                    wrapMode: Text.Wrap
                }
            }
        }

        HSep { width: col.width }


        SongsListView {
            id: songs_list_view
            width: col.width
            height: col.height - info_area.height

            onSongClicked: root.songClicked(song)
        }
    }
}
