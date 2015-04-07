import QtQuick 2.0

Item {
    function playSong(song) {
        current_song.mp3Url = song.mp3Url
        current_song.picUrl = song.picUrl
        current_song.artist = song.artist
        current_song.name = song.name

        _controller.getLyric(song.id)
    }
}

