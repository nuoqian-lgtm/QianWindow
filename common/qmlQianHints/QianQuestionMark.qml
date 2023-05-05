import QtQuick 2.12
import QtQuick.Controls 2.5
import "qrc:/common"

Item {
    property string hint: "hint "
    implicitWidth: 22
    implicitHeight: 22

    Image {
        anchors.fill: parent
        anchors.margins: 1
        source: skin.light ? "questionMarkDarker.png" : "questionMark.png"
        mipmap: true
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

    }

    BaseToolTip {
         visible: mouse.containsMouse
         text: hint
         font.pixelSize: 13
         delay: 1
    }
}

