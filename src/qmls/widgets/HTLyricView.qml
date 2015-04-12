import QtQuick 2.0

import "../utils.js" as Utils

Item {
    width: 300
    height: 300
    clip: true

    function setLyric(lyric) {
        list_view.model.clear()

        var lyricDict = Utils.parseLyric(lyric)
        for (var timeStamp in lyricDict) {
            list_view.model.append({
                "lyricTimestamp": timeStamp,
                "lyricContent": lyricDict[timeStamp]
            })
        }
    }

    function setPosition(position) {
        var lastMatch = 0
        for (var i = 0; i < list_view.count; i++) {
            if (list_view.model.get(i).lyricTimestamp <= position) {
                lastMatch = i
            } else {
                break
            }
        }
        list_view.currentIndex = lastMatch
    }

    ListView {
        id: list_view
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: list_view.height / 2 - lineHeight / 2
        preferredHighlightEnd: list_view.height / 2 + lineHeight / 2
        anchors.fill: parent

        property int lineHeight: 26

        delegate: Item {
            width: list_view.width
            height: list_view.lineHeight

            Text {
                id: txt
                text: lyricContent
                color: index == list_view.currentIndex ? "white" : "black"
            }
        }
        model: ListModel {}
    }
}

