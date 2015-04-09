import QtQuick 2.0

PathView {
    id: path_view
    width: itemWidth * 2
    height: itemHeight
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    pathItemCount: 3

    property int itemWidth: 938 / 2
    property int itemHeight: 365 / 2

    delegate: Image {
        z: parent.z + PathView.itemX == 0 ? 10 : 0
        width: path_view.itemWidth
        height: path_view.itemHeight
        scale: PathView.itemScale
        source: pic
        transform: Rotation { origin.x: rotationOriginX; axis { x: 0; y: 1; z: 0 } angle: rotationAngle }

        Component.onCompleted: print(pic)

        property real rotationOriginX: PathView.itemX < 0 ? 0 : path_view.itemWidth
        property real rotationAngle: PathView.itemX < 0 ? 10 : PathView.itemX > 0 ? -10 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: PathView.isCurrentItem ? Qt.openUrlExternally(url) : path_view.currentIndex = index
        }
    }
    model: ListModel {}
    path: Path {
        startX: 0
        startY: path_view.height / 2
        PathAttribute { name: "itemScale"; value: 0.8 }
        PathAttribute { name: "itemX"; value: -100 }
        PathLine { x: path_view.width / 2; y: path_view.height / 2 }
        PathAttribute { name: "itemScale"; value: 1 }
        PathAttribute { name: "itemX"; value: 0 }
        PathLine { x: path_view.width; y: path_view.height / 2 }
        PathAttribute { name: "itemScale"; value: 0.8 }
        PathAttribute { name: "itemX"; value: 100 }
    }

    function setData(data) {
        model.clear()

        var banners = JSON.parse(data)
        banners.forEach(function(banner){
            model.append(banner)
        })
    }
}

