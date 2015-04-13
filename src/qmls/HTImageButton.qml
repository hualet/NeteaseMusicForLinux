import QtQuick 2.0

MouseArea {
    width: img.implicitWidth
    height: img.implicitHeight
    hoverEnabled: true
    state: "normal"

    property url normalImage
    property url hoverPressedImage
    property url inactiveImage

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: img
                source: enabled ? normalImage : inactiveImage
            }
        },
        State {
            name: "hover_pressed"
            PropertyChanges {
                target: img
                source: enabled ? hoverPressedImage : inactiveImage
            }
        }
    ]

    Image { id: img; anchors.fill: parent }

    onEntered: state = "hover_pressed"
    onExited: state = "normal"
}
