import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.Singleton 1.0

Button {
    id: container
    property int radius: 3
    property var imageSrc: ''
    implicitWidth: 21
    implicitHeight: 21
    clip: true

    background: Rectangle {
       id: back
       anchors.fill: container
       radius: container.radius
       // gradient: SkinSingleton.skins[setting.skinIndex]
       Image {
           anchors.fill: parent
           anchors.margins: container.radius
           source: imageSrc
       }
       Rectangle {
           anchors.fill: parent
           radius: container.radius
           color: !container.hovered? "#11000000" : "#11ffffff"
       }
   }
}
