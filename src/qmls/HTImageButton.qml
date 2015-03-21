import QtQuick 2.0

MouseArea {
    width: img.implicitWidth
    height: img.implicitHeight
    hoverEnabled: true
    state: "normal"

    property url normalImage
    property url hoverPressedImage

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: img
                source: normalImage
            }
        },
        State {
            name: "hover_pressed"
            PropertyChanges {
                target: img
                source: hoverPressedImage
            }
        }
    ]

    Image { id: img }

    onEntered: state = "hover_pressed"
    onExited: state = "normal"
}
