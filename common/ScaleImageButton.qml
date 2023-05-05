import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: container
    implicitWidth: 38
    implicitHeight: 24
    property bool shrink: true
    property var normalImage: 'qrc:/res/scale1.png'
    property var maxImage: 'qrc:/res/scale0.png'

    property var backHoverColor: '#20334455'
    property var backColor: 'transparent'

    clip: true
    padding: 0
    background: Rectangle {
       anchors.fill: parent
       color: container.hovered ? backHoverColor : backColor
       Image {
           anchors.fill: parent
           anchors.margins: container.padding
           antialiasing: true
           source: shrink ? normalImage : maxImage
           fillMode: Image.PreserveAspectFit
       }
   }

   onClicked: {
       shrink = !shrink
   }
}
