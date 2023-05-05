import QtQuick 2.14
import QtQuick.Controls 2.14
import Qt.QianDragEventCatch 1.0

Flickable {
    id: contains
    property real itemWidth: 140
    property real itemHeight: 180
    property int itemPixSize: 20
    property int interval: 4
    property int itemRadius: 5
    property int animatioMoveIndex: -1
    property int maxFlickVelocity: 0
    property alias chatView : _chatView


    function append(text) {
        modelData.append({"name": text})
        chatView.positionViewAtIndex(modelData.count-1, ListView.End)
    }

    QianDragEventCatch {
        id: dragCatch
        container: contains
        filterObj: _chatView

        property bool isDrag: false
        property int pressMouseX: 0
        property int pressMouseY: 0
        property int pressItemX: 0
        property int pressItemY: 0
        property int pressIndex: -1

        onReleased: {
           chatView.interactive = true
           if (!dragDelegate.visible) {
              chatView.currentIndex = chatView.currentIndex == pressIndex ? -1 : pressIndex
           } else {
              isDrag = false;
              dragDelegate.finish()
           }
        }
        onPressed: {
            if(mouseY >= (chatView.height - itemHeight)/2  && mouseY <= (chatView.height + itemHeight)/2) {
                chatView.interactive = false
                pressIndex = chatView.indexAt(mouseX+chatView.contentX, mouseY);
                if(pressIndex<0) {
                    catchEnable = false
                    chatView.interactive = true
                    return;
                }
                let item = chatView.itemAtIndex(pressIndex)
                if(item == null) {
                    catchEnable = false
                    chatView.interactive = true
                    return;
                }
                let contains = item.informationContains(mouseX-item.x, mouseY -item.y)
                isDrag = false;
                pressMouseX = mouseX;
                pressMouseY = mouseY;
                pressItemX = item.x - chatView.contentX
                pressItemY = (chatView.height - itemHeight)/2;

            } else {
                isDrag = false
                catchEnable = false
                chatView.interactive = true
            }
        }
        onMoved: {
            if (isDrag == false && (Math.abs(pressMouseX-mouseX) > 4 || Math.abs(pressMouseY-mouseY) > 4) && !scrollAnimation.running) {
                dragDelegate.show(chatView.model.get(pressIndex),
                                  pressItemX, mouseX, pressIndex, pressItemY, mouseY)
                isDrag = true
            } else if (isDrag) {
                dragDelegate.move(mouseX, mouseY)
            }
        }
    }


    ListView {
        id: _chatView
        anchors.fill: parent
        currentIndex: -1

        orientation: ListView.Horizontal

        Component.onCompleted:  {
            for(var i = 0; i < 5; i++) {
                modelData.append({"name": "数据块" + i})
            }
        }

        model: ListModel {
            id: modelData
        }




        ScrollBar.horizontal: ScrollBar {
            id: scroll
            policy: size<1.0? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitHeight: 6
                implicitWidth: 100
                radius: 3
                color: scroll.pressed ? accentOpacityColor
                                       : accentOpacityHoverColor
                border.color: "#AAEF3007"
                border.width: dragDelegate.visible && (scroll.position == 0 || scroll.position >=(1.0 - scroll.visualSize)) ? 1 : 0


            }
            background: Item {

            }

            NumberAnimation on position {
                id: scrollAnimation
                duration: 300
                running: false
                function requestStart(from, to, duration) {
                    scrollAnimation.from = from
                    scrollAnimation.to = to
                    scrollAnimation.duration = duration
                    scrollAnimation.restart()
                }
                onRunningChanged: {
                    if(!scrollAnimation.running && dragCatch.isDrag) {
                        if(dragDelegate.visible)  dragDelegate.update()
                    }
                }
            }
        }

        NumberAnimation on x {
            id: xAnimation
            duration: 300
            running: false
            function requestStart(from, to) {
                xAnimation.from = from
                xAnimation.to = to
                xAnimation.restart()
            }

        }


        add: Transition {
                NumberAnimation { properties: "y";  from: -chatView.height; to: 0; duration: 150 }
        }
        move: Transition {
             NumberAnimation { properties: "x,y"; duration: 180 }
        }

        moveDisplaced: Transition {
            SequentialAnimation {
                ScriptAction{
                     script: {
                         let item = chatView.itemAtIndex(animatioMoveIndex)
                         if(item != null)  item.z = 100
                     }
                }

               NumberAnimation { properties: "x,y"; duration: 180 }
               ScriptAction{
                    script: {
                        let item = chatView.itemAtIndex(animatioMoveIndex)
                        if(item != null)  item.z = 1
                    }
               }
            }
        }
        displaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 180 }
        }

        delegate: QianDragDelegate {
            id: delegate
            onCloseRequest: {
                chatView.model.remove(index)
            }
        }
        QianDragDelegateInformation {
            id: dragDelegate
            visible: false
            height: itemHeight
            width: itemWidth
            property int pressX: 0
            property int pressY: 0
            property int baseY: 0
            property int baseX: 0
            property int dragIndex: -99
            property int pressIndex: -99
            function show(data,baseX,preX,pressIndex, baseY,preY) {
                dragDelegate.modelData = data
                dragDelegate.pressIndex = pressIndex
                dragDelegate.isSelect = pressIndex == chatView.currentIndex
                pressX = preX
                x = baseX
                dragDelegate.baseX = baseX
                dragDelegate.baseY = baseY
                pressY = preY
                y = baseY
                visible = true
            }

            function finish() {
                visible = false
                var index = dragIndex;
                if (index > 1 && pressIndex<index)
                    index -= 1
                animatioMoveIndex = index
                modelData.move(pressIndex,parseInt(index),1)
                dragIndex = -99
                pressIndex = -99
                scrollAnimation.stop()
            }

            function update() {
                var dragX = chatView.contentX + x
                var index = chatView.indexAt(dragX, 0);
                if (index < 0) {
                    if (dragX < 0) {
                        dragIndex = 0;
                    } else {
                        dragIndex = _chatView.count
                    }
                } else {
                   dragIndex = (dragX - chatView.itemAtIndex(index).x) > itemWidth/2 ? index+1 : index;
                }

                let to;
                let step;

                if(x < itemWidth/4 && scroll.position > 0) {
                    let step = scroll.visualSize*0.12;
                    to =  scroll.position - step
                    if(to < 0) {
                        to = 0
                    }
                    scrollAnimation.requestStart(scroll.position, to, 200)
                } else if(scrollAnimation.running && x >= itemWidth/4 && x <= itemWidth/4 && scroll.position > 0) {
                    scrollAnimation.stop()
                }  else if(x >= (chatView.width-itemWidth*0.75) && scroll.visualSize > 0 && scroll.position <(1.0 - scroll.visualSize)) {
                    let step = scroll.visualSize*0.12;
                    to =  scroll.position + step
                    if(to > 1.0 - scroll.visualSize) {
                        to = 1.0 - scroll.visualSize
                    }
                    scrollAnimation.requestStart(scroll.position, to, 200)
                }

            }

            function move(mvX, mvY) {
                var movex = mvX - pressX
                x = movex + baseX
                var movey = mvY - pressY
                y = movey + baseY
                update();
            }

        }
    }

}



