import QtQuick 2.0

FocusScope {
    id: root
    width: 200
    height: 28

    property alias text: text_input.text
    property alias hint: hint_text.text
    property alias echoMode: text_input.echoMode

    Rectangle {
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.6)
        anchors.fill: parent

        TextInput {
            id: text_input
            focus: true
            font.pixelSize: 16
            selectByMouse: true
            anchors.fill: parent
            anchors.margins: (parent.height - contentHeight) / 2
        }

        Text {
            id: hint_text
            visible: !(root.focus || text_input.text)
            color: Qt.lighter(text_input.color)
            font.pixelSize: text_input.font.pixelSize
            anchors.fill: text_input
        }
    }
}

