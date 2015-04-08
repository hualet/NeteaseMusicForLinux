import QtQuick 2.0

import "qrc:/src/qmls/utils.js" as Utils

ListView {
    id: list_view
    width: 100
    height: 100
    currentIndex: -1

    Component {
        id: row_component

        Row {
            id: row
            property string title
            property string artist
            property string album
            property string duration

            property bool header: false
            property color columnNameColor: header ? Qt.rgba(0.5, 0.5, 0.5, 0.7) : "black"

            height: parent.height
            spacing: 10
            Item { width: 1; height: parent.height }
            Text {
                width: 280
                text: row.title
                elide: Text.ElideRight
                color: columnNameColor
                anchors.verticalCenter: parent.verticalCenter
            }
            VSep { height: parent.height; visible: header }
            Text {
                width: 200
                text: row.artist
                elide: Text.ElideRight
                color: columnNameColor
                anchors.verticalCenter: parent.verticalCenter
            }
            VSep { height: parent.height; visible: header }
            Text {
                width: 150
                text: row.album
                elide: Text.ElideRight
                color: columnNameColor
                anchors.verticalCenter: parent.verticalCenter
            }
            VSep { height: parent.height; visible: header }
            Text {
                text: row.duration
                elide: Text.ElideRight
                color: columnNameColor
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    model: ListModel {}
    delegate: Rectangle {
        width: list_view.width
        height: 36
        color: list_view.currentIndex == index ? Qt.rgba(0, 0, 0, 0.2) : "transparent"

        Loader {
            sourceComponent: row_component
            onLoaded: {
                item.height = parent.height

                item.title = name
                item.artist = artists.get(0).name
                item.album = album["name"]
                item.duration = Utils.formatTime(duration)
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: list_view.currentIndex = index
            onDoubleClicked: {
                var song = {}
                song.id = id
                song.name = name
                song.album = album["name"]
                song.artist = artists.get(0).name
                song.mp3Url = mp3Url
                song.picUrl = album.picUrl
                list_view.songClicked(song)
            }
        }
    }

    header: Item {
        width: list_view.width
        height: 24

        Loader {
            sourceComponent: row_component
            onLoaded: {
                item.height = parent.height
                item.header = true

                item.title = "音乐标题"
                item.artist = "歌手"
                item.album = "专辑"
                item.duration = "时长"
            }
        }

        HSep { width: parent.width; anchors.bottom: parent.bottom }
    }

    signal songClicked(var song)

    function setData(data) {
        model.clear()

        var tracks = JSON.parse(data)
        for (var i = 0; i < tracks.length; i++) {
            model.append(tracks[i])
        }
    }
}
