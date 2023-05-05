import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
Slider {
    id: _slider
    anchors.verticalCenter: parent.verticalCenter
    background: Rectangle {
         x: _slider.leftPadding
         y: _slider.topPadding + _slider.availableHeight / 2 - height / 2
         implicitWidth: 120
         implicitHeight: 5
         width: _slider.availableWidth
         height: implicitHeight
         radius: 2
         color: "#bdbebf"
         gradient: Gradient {
             orientation: Gradient.Horizontal;
             GradientStop { position: 0.0; color: accentContrlColor }
             GradientStop { position: 1.0; color: "#FFFFFF" }

         }
     }

     handle: Rectangle {
         x: _slider.leftPadding + _slider.visualPosition * (_slider.availableWidth - width)
         y: _slider.topPadding + _slider.availableHeight / 2 - height / 2
         implicitWidth: 14
         implicitHeight: 14
         radius: 7
         color: "#FFF"
         layer.enabled: true
         layer.effect: DropShadow {
            color: accentContrlColor
         }

     }
}
