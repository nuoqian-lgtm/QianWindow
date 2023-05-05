
import QtQuick 2.10

Rectangle {
    id: msgBox
    property alias text: msg.text
    property var type: "info"

    clip: true
    width: msg.contentWidth + 105
    height: 44
    color:  type=== "info" ? "#fdf6ec" : type=== "success" ? "#f0f9eb" : "#fef0f0"
    border.color:type=== "info" ? "#faecd8" : type=== "success" ? "#e1f3d8" : "#fde2e2"
    radius: 5
    anchors.horizontalCenter: parent.horizontalCenter
    visible: false;

    function open(_type, _text) {
        type =_type
        text = _text

        animation.restart();
    }

    Image {
        id: img
        source: type
                === "info" ? "remind.png" : type
                             === "success" ? "true.png" : "error.png"
        width: 24
        height: 24
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 30
        }
    }
    Text {
        id: msg
        color: type=== "info" ? "#e6a23c" : type=== "success" ? "#67c23a" : "#f56c6c"
        font.pixelSize: 17
        font.family: "Microsoft Yahei"
        anchors {
            verticalCenter: img.verticalCenter
            left: img.right
            leftMargin: 10
        }
    }


    SequentialAnimation{
        id: animation
        running: false
        ParallelAnimation {
            ScriptAction {
                script: msgBox.visible = true
            }
            NumberAnimation  {
              target: msgBox
              property: "y"
              from: 0
              to: 40
              duration: 300
              easing.type : Easing.InOutQuad
            }
            NumberAnimation  {
              target: msgBox
              property: "opacity"
              from: 0.3
              to: 1.0
              duration: 300
              easing.type : Easing.InOutQuad
            }
        }


        PauseAnimation {
            duration:  2000
        }

        ParallelAnimation {
            NumberAnimation  {
              target: msgBox
              property: "y"
              from: 40
              to: 0
              duration: 300
              easing.type : Easing.InOutQuad
            }
            NumberAnimation  {
              target: msgBox
              property: "opacity"
              from: 1.0
              to: 0.3
              duration: 300
              easing.type : Easing.InOutQuad
            }
        }

        ScriptAction {
            script: msgBox.visible = false
        }

    }
}

