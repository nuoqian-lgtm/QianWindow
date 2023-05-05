/****************************************************************************
**  游戏界面-负责刷新小球运动轨迹等
** Author   : 诺谦 https://blog.csdn.net/qq_37997682/article/details/126640154
** Create   : 2021-5-24
****************************************************************************/

import QtQuick 2.12
import "BallRun.js" as BallRes
import QtMultimedia 5.10
Canvas {
    id: canvas

    visible: true
    property int score: 0
    property int lineDashY: 100
    property int finish: 0          // 0 : 未结束  1: 结束动画  2: 结束界面
    property var preBallLeaveDate: new Date
    onPaint: {
        var context = getContext('2d')
        var preDate = new Date;

        function draw() {
          BallRes.process();
          requestAnimationFrame(draw);
       }

        drawLineDash();
        draw();
    }

    MouseArea {
        id : area
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            if (!finish )  BallRes.currentBallMove(mouseX)
        }
        onClicked: {
            if (!finish && BallRes.currentBallStartDown()) {
                BallRes.newBall(area.mouseX)
            }
            else if (finish == 2) {
               finish = 0
               score = 0
               BallRes.newBall(area.mouseX)
            }
        }
    }

    function drawLineDash() {
        context.setLineDash( [ 6, 6, 3] );
        context.lineWidth = 4;
        context.clearRect(0, lineDashY - 4, canvas.width, lineDashY + 4);
        context.strokeStyle = "#91431E"
        context.lineCap = "round"
        context.moveTo(0, lineDashY);
        context.lineTo(canvas.width, lineDashY);
        context.stroke();
    }



    SoundEffect {
        id: downSound
        source: "audio/down.wav"
    }

    SoundEffect {
        id: mergeSound1
        volume: 0.6
        source: "audio/merge1.wav"
    }

    SoundEffect {
        id: mergeSound2
        source: "audio/merge2.wav"
    }

    SoundEffect {
        id: finishSound
        source: "audio/finish.wav"
    }

    ScoreNumber {
        id: scoreNumber
        x: 10
        y: 20
        value: score
    }

    Component.onCompleted:   BallRes.newBall(area.mouseX);

}
