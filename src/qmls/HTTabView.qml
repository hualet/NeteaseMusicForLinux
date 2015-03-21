import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TabView {
    id: frame
    width: 300
    height: 300

    style: TabViewStyle {
        tabsAlignment: Qt.AlignHCenter
        tab: Item {
            implicitWidth: Math.max(text.width + 4, 80)
            implicitHeight: 40
            Text {
                id: text
                anchors.centerIn: parent
                text: styleData.title
                color: styleData.selected ? "red" : "black"
            }
        }
        frame: Item {
            HSep { width: parent.width }
        }
    }
}
