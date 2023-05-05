import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import Qt.Singleton 1.0
Button {
    id: container
    property color bckcolor:  skin.light ? accentContrlColor : "#eee"
    property int backRadius: 3

    font.family: "Microsoft Yahei"
    font.pixelSize: 20
    implicitWidth: text.contentWidth + 24
    implicitHeight: text.contentHeight + 8
    contentItem: Text {
        id: text
        anchors.centerIn: parent
        text: container.text
        font: container.font
        color: bckcolor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        anchors.fill: parent
        radius: backRadius
        color:  skin.light ? "#33FFFFFF" : "transparent"
        border.width: container.checked ? 3 : container.hovered ? 2 : 1
        border.color: container.checked ? Qt.lighter(bckcolor, 0.80) : container.hovered ? Qt.lighter(bckcolor, 0.88) : bckcolor

        layer.enabled: true
        layer.effect: DropShadow {
           color: bckcolor
        }

    }
}
