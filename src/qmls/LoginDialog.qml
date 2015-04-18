import QtQuick 2.0
import QtQuick.Dialogs 1.2

import "../qmls/widgets"

Dialog {
    id: root
    width: 300
    height: 200
    title: "登录"
    standardButtons: StandardButton.Close

    signal login(string account, string password)

    onAccepted: {
        if (!(account_input.text && password_input.text)) return

        root.login(account_input.text, password_input.text)
    }

    Rectangle {
        color: "lightgrey"
        anchors.fill: parent

        Column {
            id: col
            width: childrenRect.width
            spacing: -1
            anchors.horizontalCenter: parent.horizontalCenter

            HTTextInput {
                id: account_input
                hint: "账号"
                focus: false

                KeyNavigation.tab: password_input
            }

            HTTextInput {
                id: password_input
                hint: "密码"
                focus: false
                echoMode: TextInput.Password
            }
        }

        HTTextButton {
            width: col.width
            text: "登录"
            anchors.top: col.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                if (!(account_input.text && password_input.text)) return

                root.login(account_input.text, password_input.text)
            }
        }
    }
}

