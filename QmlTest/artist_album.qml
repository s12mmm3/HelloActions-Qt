import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 2.12

ScrollView {
    id: root
    property var model: getModel(15396)
    anchors.fill: parent
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    function getModel(id) {
        return $api.invoke("artist_album",
                           {
                               "id": id
                           }
                           )["body"]
    }

    Column {
        anchors.top: parent.top
        width: parent.width
        clip: true
        Column {
            width: parent.width
            spacing: 5
            Repeater {
                model: root.model["hotAlbums"]
                RowLayout {
                    spacing: 10
                    width: parent.width
                    Image {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: Layout.preferredWidth
                        source: modelData["picUrl"]
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
                                let ar = modelData["artists"]
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
                            text: modelData["size"] + "歌曲"
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
                text: "15396"
                width: parent.width
            }
        }
    }
}
