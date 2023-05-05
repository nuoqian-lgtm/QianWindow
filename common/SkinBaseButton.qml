import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
Button {
    id: container
    property color bckcolor: accentContrlColor
    property string bckHoverColor: Qt.lighter(bckcolor, 0.8)
    property color textcolor: skin.light ? "#fff" : "#eee"
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
        color: textcolor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        anchors.fill: parent
        radius: backRadius
        color: bckcolor
        gradient: container.hovered ? skin.gradient : undefined
        Rectangle {
            anchors.fill: parent
            color: "#11000000"
            visible: container.hovered
        }
        layer.enabled: true
        layer.effect: DropShadow {
           color: bckcolor
        }
    }
}
