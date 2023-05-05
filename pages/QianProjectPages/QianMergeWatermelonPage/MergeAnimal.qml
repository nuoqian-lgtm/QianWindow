/****************************************************************************
**  小球合并时,产生的动画控件
** Author   : 诺谦 https://blog.csdn.net/qq_37997682/article/details/126640154
** Create   : 2021-5-24
****************************************************************************/

import QtQuick 2.12
import QtMultimedia 5.10
Item {
    property var mergeSrc: ""
    property var modelSize: 5

    id: merge

    Repeater {
        model: modelSize
        Image {
            fillMode: Image.Stretch
            anchors.fill: parent
            source: mergeSrc
            rotation: Math.random()*90
            opacity: (modelSize - index) / modelSize    // 0 -> 1
            scale:  (modelSize - index) / modelSize     // 0 -> 1

            NumberAnimation on opacity {
                id: mergeAnimation
                running: true
                to: 1.0; duration: 200
                onFinished: merge.animationFinished()
            }
        }
    }




    function animationFinished() {
        this.destroy(100);
    }
    Timer {

        running: true
        interval: 300
        onTriggered: merge.destroy()
    }

}
