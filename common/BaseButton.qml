import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
Button {
    id: container
    property string bckcolor: "#1AAD19"
    property string bckHoverColor: Qt.lighter(bckcolor, 0.8)
    property int backRadius: 2

    font.family: "Microsoft Yahei"
    font.pixelSize: 20
    implicitWidth: text.contentWidth + 24
    implicitHeight: text.contentHeight + 8
    contentItem: Text {
        id: text
        text: container.text
        font: container.font
        color: "#fff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        anchors.fill: parent
        radius: backRadius
        color: container.down ? bckcolor :
                 container.hovered ? bckHoverColor : bckcolor

        layer.enabled: true
        layer.effect: DropShadow {
           color: bckcolor
        }
    }
}
