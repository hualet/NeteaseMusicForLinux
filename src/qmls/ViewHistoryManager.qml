import QtQuick 2.0

QtObject {
    property int _currentIndex: 0
    property var _historyList: []

    property bool canGoBack: _historyList.length != 0 && _currentIndex > 0
    property bool canGoForward: _historyList.length != 0 && _currentIndex < _historyList.length - 1

    function append(state) {
        _historyList.push(state)
        _currentIndex = _historyList.length - 1
    }

    function goBack() {
        if (_historyList.length != 0 && _currentIndex != 0) {
            _currentIndex -= 1
            return _historyList[_currentIndex]
        } else {
            return null
        }
    }

    function goForward() {
        if (_historyList.length != 0 && _currentIndex != _historyList.length - 1) {
            _currentIndex += 1
            return _historyList[_currentIndex]
        } else {
            return null
        }
    }
}
