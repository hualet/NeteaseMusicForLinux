import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtMultimedia 5.0

import "qrc:/src/qmls/utils.js" as Utils

Window {
    visible: true
    width: 1000
    height: 640
    color: "transparent"

    Item {
        id: window_content
        anchors.fill: parent

        Audio { id: player; autoPlay: true; volume: 0.8 }

        Rectangle {
            id: background
            color: Qt.rgba(1, 1, 1, 0.8)
            anchors.fill: parent
        }

        Column {
            width: parent.width
            height: parent.height

            Header {
                id: header
                width: parent.width
            }

            Row {
                width: parent.width
                height: parent.height - header.height - footer.height

                Item { id: side_bar; width: 200; height: parent.height }

                VSep { height: parent.height }

                Rectangle {
                    width: parent.width - side_bar.width - 1
                    height: parent.height

                    HTTabView {
                        anchors.fill: parent
                        visible: !songs_list_view.visible

                        Tab {
                            title: "推荐"

                            HTTabContent {
                                width: parent.width
                                height: parent.height

                                PlaylistIconView {
                                    id: icon_view
                                    width: cellWidth * 4
                                    height: parent.height

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Connections {
                                        target: _controller
                                        onTopPlaylistsGot: icon_view.setData(playlists)
                                    }

                                    Component.onCompleted: _controller.getTopPlaylists()

                                    onPlaylistClicked: {
                                        print(playlistId)
                                        _controller.getPlaylistDetail(playlistId)
                                    }
                                }
                            }
                        }
                        Tab {
                            title: "排行榜"
                        }
                        Tab {
                            title: "歌单"
                        }
                        Tab {
                            title: "最新音乐"
                        }
                    }

                    SongsListView {
                        id: songs_list_view
                        visible: false
                        anchors.fill: parent

                        Connections {
                            target: _controller
                            onPlaylistDetailGot: {
                                songs_list_view.setData(tracks)
                                songs_list_view.visible = true
                            }
                        }

                        onSongClicked: player.source = mp3Url
                    }
                }
            }

            Footer {
                id: footer
                width: parent.width

                playing: player.playbackState == Audio.PlayingState
                progress: player.position / player.duration
                timeInfo: "%1/%2".arg(Utils.formatTime(player.position)).arg(Utils.formatTime(player.duration))
                volume: player.volume
                muted: player.muted

                onMutedSet: player.muted = muted
            }
        }
    }
}
