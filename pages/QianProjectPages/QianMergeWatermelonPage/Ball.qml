/****************************************************************************
**  小球控件
** Author   : 诺谦 https://blog.csdn.net/qq_37997682/article/details/126640154
** Create   : 2021-5-24
****************************************************************************/

import QtQuick 2.12
Image {
    id: img

    property var pointX: 0
    property var pointY: 0
    property var preX: 0
    property var preY: 0
    property var vx: 0
    property var vy: 0
    property var r: 0
    property var cor: 0                  // 碰撞后的能量损失值,为 1 表示碰撞后不会损失能量
    property var mass: 0                  // 小球质量,球体越大,质量越大
    property var rotate: 0
    property var ballType: 0             // 小球类型
    property var shapeChange: false      // 形状是否在改变中,创建小球的时候,形状会慢慢变大,此时用户不能立即降落小球
    property var mergeSrc: ""            // 合并时的动画资源
    property var mergeStart: false       // 启动合并动画显示
    property var endPointX: 0            // 合并时的终点x坐标
    property var endPointY: 0            // 启动合的终点y坐标

    Behavior on width {
        NumberAnimation {
            id: widthAnima; duration: 300;


            onRunningChanged:  shapeChange = running;
        }
    }

    Behavior on height { NumberAnimation { duration: 300; } }

    fillMode: Image.Stretch
    mipmap: true
    x: pointX - width/2
    y: pointY - height/2
    width: 0
    height: 0

    NumberAnimation on pointX {
        id: enPointXAnimation
        running: mergeStart == true
        to: endPointX; duration: 300
    }
    NumberAnimation on pointY {
        id: enPointYAnimation
        running: mergeStart == true
        to: endPointY; duration: 300
    }

    NumberAnimation on rotate {
        id: rotateAnimation
        running: mergeStart == true
        to: calcEndRotate()
        duration: 300
        onFinished: {
            preX = pointX
            preY = pointY
            mergeStart = false
        }
    }

    function calcEndRotate() {

        let distance = Math.sqrt(Math.pow((endPointX - pointX),2) + Math.pow((endPointY - pointY),2));

        if (endPointX > pointX) // 往右
            return rotation +  360/(2 * r * 3.14) * distance * 0.5;
        else                    // 往左
            return rotation -  360/(2 * r * 3.14) * distance * 0.5;

        }


}
