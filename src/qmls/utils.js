function formatTime(millseconds) {
    if (millseconds <= 0) return "00:00";
    var secs = Math.ceil(millseconds / 1000)
    var hr = Math.floor(secs / 3600);
    var min = Math.floor((secs - (hr * 3600))/60);
    var sec = secs - (hr * 3600) - (min * 60);

    if (min < 10) {min = "0" + min;}
    if (sec < 10) {sec = "0" + sec;}
    if (!hr) {hr = "00";}
    return min + ':' + sec;
}

function parseLyric(lyric) {
    var result = {}
    var lines = lyric.split("\n")
    var pattern = /^\[(\d*):(\d*).(\d.*)\](.*)/i
    for (var i=0; i<lines.length; i++) {
        if (lines[i].search(pattern)>=0 ) {
            var match = lines[i].match(pattern);
            // minutes: match[1], seconds: match[2], milliseconds: match[3], lyric: match[4]
            var milliseconds = parseInt(match[1]) * 60 * 1000 + parseInt(match[2]) * 1000 + parseInt(match[3])
            result[milliseconds] = match[4]
        }
    }

    return result
}
