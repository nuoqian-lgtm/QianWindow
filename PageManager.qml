import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import "qrc:/common"
import "qrc:/pages"
import "qrc:/pages/QianProjectPages"
import "qrc:/pages/QianProjectPages/QianMergeWatermelonPage"
import "qrc:/pages/QianProjectPages/QianDragViewPage"

StackLayout {
    id: stack
    clip: true
    function switchPage(name) {
        for (var i = 0; i < stack.data.length; i++) {
            if (stack.data[i].name == name) {
                stack.currentIndex = i;
                break;
            }
        }
    }

    BaseControlPage {
        property string name: "Buttons"
        width: stack.width
        height: stack.height

    }
    BaseOtherControlPage {
        property string name: "Other"
        width: stack.width
        height: stack.height
    }
    HintPage{
        property string name: "提示"
        width: stack.width
        height: stack.height
    }

    QianPhotoPage {
        property string name: "图片预览器"
        width: stack.width
        height: stack.height
    }

    QianMergeWatermelonPage {
        property string name: "合成大西瓜"
        width: stack.width
        height: stack.height
    }

    QianDragViewPage {
        property string name: "DragView"
        width: stack.width
        height: stack.height
    }


 }
