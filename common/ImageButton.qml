import QtQuick 2.12
import QtQuick.Controls 2.5

Button {
    id: container
    implicitWidth: 38
    implicitHeight: 24
    property var imageSrc: ''
    property var hoverimageSrc: null
    property var backHoverColor: 'transparent'
    property var backColor: 'transparent'
    property alias radius: back.radius

    clip: true
    padding: 0
    background: Rectangle {
       id: back
       anchors.fill: parent
       color: container.hovered ? backHoverColor : backColor
       Image {
           anchors.centerIn: parent
           antialiasing: true
           source: container.hovered ? (hoverimageSrc == null? imageSrc : hoverimageSrc)
                                  : imageSrc
           fillMode: Image.PreserveAspectFit

       }
   }
}
