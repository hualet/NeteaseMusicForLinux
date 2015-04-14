import QtQuick 2.0

Item {
    function playPrev() {
    }

    function playNext() {
        var song = _controller.getNextPlaylistItem(current_song.id)
        playSong(song, false)
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

