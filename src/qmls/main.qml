import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.0

Window {
    visible: true
    width: 1000
    height: 640
    color: "transparent"

    Item {
        id: window_content
        anchors.fill: parent

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
                }
            }

            Footer {
                id: footer
                width: parent.width
            }
        }
    }
}
