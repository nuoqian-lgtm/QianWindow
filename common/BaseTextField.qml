import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
TextField {
    id: textfield
    selectByMouse: true
    font.family: "Microsoft Yahei"
    font.pixelSize: 16
    property color backColor: skin.light ?  "#77FFFFFF" : "11000000"
    property color focusColor: Material.accent
    property color normalColor: Material.foreground

    topPadding: 3
    bottomPadding: 3
    leftPadding: 2
    rightPadding: 2

    background: Rectangle {
         implicitWidth: 200
         implicitHeight: 30
         color: backColor

         Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: (textfield.hovered||textfield.focus) ? 2 :1
            color: textfield.focus ? focusColor : normalColor
         }
    }
}
