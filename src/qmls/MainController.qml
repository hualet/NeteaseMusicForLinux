import QtQuick 2.0
import QtMultimedia 5.0

import QtQuick.Controls 1.1

Item {
    Action { shortcut: "Space"; onTriggered: togglePlay() }
    Action { shortcut: "Ctrl+PgDown"; onTriggered: playNext() }
    Action { shortcut: "Ctrl+PgUp"; onTriggered: playPrev() }
    Action { shortcut: "Right"; onTriggered: forward() }
    Action { shortcut: "Left"; onTriggered: rewind() }
    Action { shortcut: "Up"; onTriggered: volumeUp() }
    Action { shortcut: "Down"; onTriggered: volumeDown() }

    function playPrev() {
    }

    function playNext() {
        var song = _controller.getNextPlaylistItem(current_song.id)
        playSong(song, false)
    }

    function togglePlay() {
        if (player.source) {
            if (player.playbackState == Audio.PlayingState) {
                player.pause()
            } else {
                player.play()
            }
        }
    }

    function forward() {
        if (player.source) {
            var position = Math.min(player.position + 3000, player.duration)
            player.seek(position)
        }
    }

    function rewind() {
        if (player.source) {
            var position = Math.max(player.position - 3000, 0)
            player.seek(position)
        }
    }

    function volumeUp() {
        player.volume += 0.1
    }

    function volumeDown() {
        player.volume -= 0.1
    }

    function togglePlaylist() {
        playlist_view.visible = !playlist_view.visible
    }

    function playSong(song, addToPlaylist) {
        win.title = song.name

        current_song.id = song.id
        current_song.mp3Url = song.mp3Url
        current_song.picUrl = song.picUrl
        current_song.artist = song.artist
        current_song.name = song.name
        current_song.album = song.album
        current_song.duration = song.duration
        current_song.lyric = ""

        _controller.getLyric(song.id)

        player.play()
        _settings.lastSong = song.id
        if (addToPlaylist) {
            _controller.addPlaylistItem(song.id, song.name, song.mp3Url, song.picUrl,
                                        song.name, song.album, song.duration)
        }
    }

    function playPlaylist(playlistId) {
        _controller.playlistDetailGot.connect(playlistDetailGot)
        _controller.playlistDetailGot.disconnect(playlist_detail_view.playlistDetailGot)
        _controller.getPlaylistDetail(playlistId)
    }

    function playlistDetailGot(detail) {
        var result = JSON.parse(detail)
        var tracks = result.tracks

        var track = tracks[0]
        var song = {}
        song.id = track.id
        song.name = track.name
        song.album = track.album.name
        song.artist = track.artists[0].name
        song.mp3Url = track.mp3Url
        song.picUrl = track.album.picUrl
        song.duration = track.duration
        playSong(song, false)

        for (var i = 0; i < tracks.length; i ++) {
            var track = tracks[i]
            _controller.addPlaylistItem(track.id, track.name, track.mp3Url, track.album.picUrl,
                                        track.artists[0].name, track.album.name, track.duration)
        }
    }
}

