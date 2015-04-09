import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtMultimedia 5.0

import Org.Hualet.Widgets 1.0

import "../qmls/widgets"
import "qrc:/src/qmls/utils.js" as Utils

Window {
    visible: true
    width: 1000
    height: 640
    color: "transparent"
    title: " "

    Item {
        id: window_content
        anchors.fill: parent

        Audio { id: player; autoPlay: true; volume: 0.8; source: current_song.mp3Url }

        Song { id: current_song }

        MainController { id: main_controller }

        Connections {
            target: _controller
            onLyricGot: {
                current_song.lyric = lyric
            }
        }

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
                clip: true
                width: parent.width
                height: parent.height - header.height - footer.height

                SideBar {
                    id: side_bar
                    width: 200
                    height: parent.height
                }

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

                                HTBannersView {
                                    id: banners_view

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Connections {
                                        target: _controller
                                        onBannersGot: banners_view.setData(banners)
                                    }

                                    Component.onCompleted: _controller.getBanners()
                                }

                                PlaylistIconView {
                                    id: hotspot_icon_view
                                    width: cellWidth * 4
                                    height: parent.height

                                    anchors.top: banners_view.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Connections {
                                        target: _controller
                                        onHotspotGot: hotspot_icon_view.setData(hotspot)
                                    }

                                    Component.onCompleted: _controller.getHotspot()

                                    onPlaylistClicked: {
                                        _controller.getPlaylistDetail(playlistId)
                                    }
                                }
                            }
                        }
                        Tab {
                            title: "排行榜"

                            HTTabContent {
                                width: parent.width
                                height: parent.height

                                PlaylistIconView {
                                    id: toplist_icon_view
                                    width: cellWidth * 4
                                    height: parent.height

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Connections {
                                        target: _controller
                                        onRankingListsGot: toplist_icon_view.setData(lists)
                                    }

                                    Component.onCompleted: _controller.getRankingLists()

                                    onPlaylistClicked: {
                                        _controller.getPlaylistDetail(playlistId)
                                    }
                                }
                            }
                        }
                        Tab {
                            title: "歌单"

                            PlaylistIconView {
                                id: playlists_icon_view
                                width: cellWidth * 4
                                height: parent.height

                                anchors.horizontalCenter: parent.horizontalCenter

                                Connections {
                                    target: _controller
                                    onTopPlaylistsGot: playlists_icon_view.setData(playlists)
                                }

                                Component.onCompleted: _controller.getTopPlaylists()

                                onPlaylistClicked: {
                                    _controller.getPlaylistDetail(playlistId)
                                }
                            }
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

                        onSongClicked: main_controller.playSong(song)
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
                onPlay: player.play()
                onPause: player.pause()
                onVolumeSet: player.volume = volume
                onSeek: player.seek(player.duration * progress)
            }
        }

        Item {
            id: floats
            y: header.height
            width: parent.width
            height: parent.height - header.height - footer.height

            PlayView {
                width: state == "mini" ? side_bar.width : parent.width
                height: state == "mini" ? 80 : parent.height
                picUrl: current_song.picUrl
                artist: current_song.artist
                song: current_song.name
                album: current_song.album
                lyric: current_song.lyric
                position: player.position
                playing: player.playbackState == Audio.PlayingState

                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
        }
    }
}
