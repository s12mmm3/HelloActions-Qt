import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 2.12

ScrollView {
    id: root
    property var model: getModel(129194941)
    anchors.fill: parent
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    function getModel(id) {
        return $api.invoke("album",
                           {
                               "id": id
                           }
                           )["body"]
    }

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true
        Image {
            width: parent.width
            height: width
            source: root.model["album"]["blurPicUrl"]
            Text {
                text: root.model["album"]["name"]
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: 40
                color: "white"
            }
        }

        Column {
            width: parent.width
            spacing: 5
            Repeater {
                model: root.model["songs"]
                RowLayout {
                    spacing: 10
                    width: parent.width
                    Image {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: Layout.preferredWidth
                        source: modelData["al"]["picUrl"]
                    }
                    Column {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        Text {
                            text: modelData["name"]
                            width: parent.width
                            elide: Text.ElideRight
                        }
                        Text {
                            text: {
                                let result = ""
                                let ar = modelData["ar"]
                                for(let i = 0; i < ar.length; i++) {
                                    result = result + ar[i]["name"]
                                    if(i < ar.length - 1) {
                                        result = result + "/"
                                    }
                                }
                                return result
                            }
                            width: parent.width
                            elide: Text.ElideRight
                            color: "#708090"
                        }
                        Text {
                            text: modelData["al"]["name"]
                            color: "#708090"
                            width: parent.width
                            elide: Text.ElideRight
                        }
                    }
                    ToolButton {
                        text: "⋮"
                        font.pixelSize: 28
                    }
                }
            }
            Button {
                text: "getModel"
                onClicked: {
                    console.log(JSON.stringify(model))
                }
            }
            Button {
                text: "setModel"
                onClicked: {
                    model = getModel(textEdit.text)
                    console.log(JSON.stringify(model))
                }
            }
            TextEdit {
                id: textEdit
                text: "129194941"
                width: parent.width
            }
        }
    }
}
