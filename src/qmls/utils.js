function formatTime(millseconds) {
    if (millseconds <= 0) return "00:00:00";
    var secs = Math.ceil(millseconds / 1000)
    var hr = Math.floor(secs / 3600);
    var min = Math.floor((secs - (hr * 3600))/60);
    var sec = secs - (hr * 3600) - (min * 60);

    if (hr < 10) {hr = "0" + hr; }
    if (min < 10) {min = "0" + min;}
    if (sec < 10) {sec = "0" + sec;}
    if (!hr) {hr = "00";}
    return hr + ':' + min + ':' + sec;
}

