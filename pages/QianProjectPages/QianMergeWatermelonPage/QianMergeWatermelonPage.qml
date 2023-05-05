/****************************************************************************
**  主界面
** Author   : 诺谦 https://blog.csdn.net/qq_37997682/article/details/126640154
** Create   : 2021-5-24
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.14
Item {
    id: screen


    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "transparent"
        clip: true

        Rectangle {
            id: home
            width: parent.width;
            height: parent.height - 80
            color: skin.light ? "#FFE89D" :  "#AAFFE89D"
            GameCanvas {
                id: gameCanvas
                anchors.fill: parent
            }

        }
        Image {
            id: background
            width: parent.width;
            height: 80
            anchors.top: home.bottom
            source: "icon/bottomBack.png"
            fillMode: Image.PreserveAspectCrop
            opacity: skin.light ? 1.0 : 0.8
        }
        FinishWindow {
            anchors.fill: parent
            visible: gameCanvas.finish == 2
            score: gameCanvas.score
        }
    }




}
