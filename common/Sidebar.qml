import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import QtQml 2.14
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.12
Item {
    id: container

    enum HorizontalPosBase {
        PosToLeft,
        PosToRight
    }


    property int horizontalPosBase: Sidebar.PosToLeft


    property int tailHeight: container.height*0.25
    property int tailSlopeHeight: container.height*0.008

    property bool enbale: true

    property bool isOpen: true


    property alias backOpacity : content.opacity
    property color bckColor: "#fff"
    property color btnColor : "#666"
    property var contentObj : content

    property real layoutPreferredWidth: 0

    property int tailWidth:  layoutPreferredWidth ? layoutPreferredWidth*0.083 : container.width*0.083

    x: horizontalPosBase === Sidebar.PosToLeft ?  isOpen ?  0 : -content.width
                                               :  isOpen ?  parent.width-width : parent.width-tailWidth
    Layout.preferredWidth:  isOpen ?  layoutPreferredWidth : tailWidth

    Behavior on x {
        NumberAnimation { duration:100  }
    }

    Behavior on  Layout.preferredWidth {
        NumberAnimation { duration:100  }
    }

    MouseArea {
        id: bottomMouse
        anchors.fill: parent
        hoverEnabled: container.enbale

    }

    Rectangle {
        id: content
        width: parent.width-tailWidth
        height: parent.height
        x: horizontalPosBase === Sidebar.PosToLeft ? 0 : tailWidth
        color: bckColor
        visible: horizontalPosBase === Sidebar.PosToLeft ? (container.x  == -content.width ? false : true ) :
                                        (container.x  == parent.width-tailWidth ? false : true)
        radius: skin.gradSupport || skin.imageSupport ? 14 : 8
        clip: true
        onVisibleChanged: {
            canvas.requestPaint()
        }

        layer.enabled: skin.shadow
        layer.effect: DropShadow {
            color: !skin.gradSupport && !skin.imageSupport ? "#36000000" : "#36FFFFFF"
            radius: 8
            samples: 17

        }

        onColorChanged:  canvas.requestPaint()
    }

    Canvas {
        id: canvas
        width: tailWidth
        height: tailHeight
        y: container.height/2 -height/2
        x: horizontalPosBase === Sidebar.PosToLeft ? parent.width-tailWidth : 0
        antialiasing: true
        smooth: true
        rotation: horizontalPosBase === Sidebar.PosToLeft ? 0 : 180
        opacity: !isOpen ? 1.0 : (isOpen && !(bottomMouse.containsMouse || mouse.containsMouse)) ? 0.0 : 1.0
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0,0, canvas.width, canvas.height);


            ctx.shadowBlur = skin.shadow
            ctx.shadowColor  = !skin.gradSupport && !skin.imageSupport ? "#36000000" : "#36FFFFFF"

            ctx.fillStyle = bckColor;
            ctx.strokeStyle = mouse.containsMouse ? skin.accentColor : !skin.gradSupport && !skin.imageSupport ? "#36000000" : "#36FFFFFF"
            ctx.beginPath()

            ctx.moveTo(0,0)
            ctx.lineTo(canvas.width-2, tailSlopeHeight)
            ctx.lineTo(canvas.width-2, canvas.height - tailSlopeHeight)
            ctx.lineTo(0, canvas.height)
            ctx.closePath()
            ctx.stroke()
            ctx.fill()

            ctx.shadowBlur = 0

            ctx.fillStyle = skin.stretchColor

            ctx.beginPath()
            var arrowMargin = tailWidth*0.35
            var arrowHalfHeight = tailHeight*0.04

            if (isOpen) {
                context.moveTo(tailWidth-arrowMargin*1.2, height/2-arrowHalfHeight);
                context.lineTo(tailWidth-arrowMargin*1.2, height/2+arrowHalfHeight);
                context.lineTo(arrowMargin*0.7, height/2);
            } else {
                context.moveTo(arrowMargin*0.7, height/2-arrowHalfHeight);
                context.lineTo(arrowMargin*0.7, height/2+arrowHalfHeight);
                context.lineTo(tailWidth-arrowMargin*1.1, height/2);

            }
            context.closePath();
            context.fill();
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: container.enbale
            onContainsMouseChanged: canvas.requestPaint()
            onClicked: {
                isOpen = !isOpen
                canvas.requestPaint()
            }
        }

        Behavior on opacity {
             NumberAnimation { duration: 300 }
        }
    }



}

