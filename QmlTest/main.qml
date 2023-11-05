import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    StackView {
        id: stackView
        initialItem: "album.qml"
        anchors.fill: parent
        onDepthChanged: {
            console.log("Pages list:")
            for(let i = 0; i < depth; i++) {
                let item = get(i, StackView.ForceLoad)
                console.log(i, item.title)
            }
        }
    }
}
