import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.14
import QtGraphicalEffects 1.14
import Qt.Singleton 1.0
Item {
    id: container
    width: skin.gradSupport  ? ListView.view.width : ListView.view.width-10
    height: columnlayout.height


    property int itemLeftMargin:  10 + tier*10

    property int itemIndex: index
    property int crtIndex: container.ListView.view.currentIndex



    function checkCurrentIndexIsChild(subitem) {

        if(subitem.count <= 0) return false;

        for(let i = 0; i < subitem.count; i++) {
            let model = subitem.get(i);

            if(model.subItem.count > 0) {
                let ret = checkCurrentIndexIsChild(model.subItem);
                if(ret != null) {
                    return ret;
                }
            } else {
                if(model.toIndex == strechCurrentIndex)
                    return true;
            }

        }
        return false;

    }

    property int  dataState: strechCurrentIndex == toIndex ? 0 :  mouse.containsMouse ? 1
                                                               :  checkCurrentIndexIsChild(subItem) ? 2 : -1

    ColumnLayout {
        id: columnlayout
        anchors.centerIn: parent

        width: parent.width
        spacing: 0

        Item {
            id: content
            Layout.fillWidth: true
            Layout.preferredHeight: itemHeight


            Rectangle {
                id: frontRect
                anchors.fill: parent
                anchors.leftMargin: skin.gradSupport   ? 28 : 18
                anchors.rightMargin: skin.gradSupport  ? -frontRect.height/2 : 18
                anchors.topMargin: 9
                anchors.bottomMargin: 9

                color:  !skin.light && dataState == 2 ? skin.stretchFoldBackSelectColor  :   subItem.count? skin.stretchFoldBackColor :
                        toIndex == strechCurrentIndex ?  skin.stretchSelectBackColor  :
                        mouse.containsMouse  ? skin.stretchBackHoverColor  : skin.stretchBackColor


                Behavior on color {
                    ColorAnimation { duration: 200 }
                }

                radius: skin.gradSupport  ?  frontRect.height/2 : 6
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.leftMargin: subItem.count > 0 && (skin.gradSupport) ? itemLeftMargin-20 : itemLeftMargin
                    anchors.rightMargin: 20

                    Image {
                        visible: subItem.count > 0 ? true : false
                        Layout.alignment : Qt.AlignVCenter | Qt.AlignLeft
                        Layout.preferredWidth: 20
                        Layout.preferredHeight: 20
                        mipmap: true
                        source: "./icons/indicator_right.png"
                        rotation: !stretch ? 0 : 90

                        Behavior on rotation {
                             NumberAnimation { duration: 200 }
                        }
                        ColorOverlay{
                           anchors.fill: parent
                           source: parent
                           color: stretch ? skin.stretchFoldSelectColor : skin.stretchColor
                        }

                    }

                    Text {
                        Layout.leftMargin: 4
                        font.family: "Microsoft Yahei"
                        text: name
                        font.pixelSize: 16
                        color: stretch ? skin.stretchFoldSelectColor :
                               toIndex == strechCurrentIndex ?  skin.stretchSelectColor : skin.stretchColor


                        elide: Text.ElideRight
                        clip: true
                        scale: tier < 4 ? 1.0 -  tier*0.04 : 0.84

                    }


                    Rectangle {
                        visible: hintNumber < 0 ? false : true
                        Layout.preferredWidth: hintNum.contentWidth < 22 ? 22 : hintNum.contentWidth+6
                        Layout.preferredHeight: 22


                        color: "#FF5E54"
                        radius: Layout.preferredHeight / 2
                        Text {
                            id: hintNum
                            anchors.centerIn: parent
                            font.family: "Microsoft Yahei"
                            text: hintNumber > 999 ? "999+" : hintNumber
                            font.pixelSize: 12
                            color: "#FFF"
                        }
                        scale: tier < 4 ? 1.0 -  tier*0.08 : 0.76
                    }

                    Item {
                        Layout.fillWidth: true
                    }


                }

            }




            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked:  {
                    if(subItem.count > 0) {
                        stretch = !stretch
                    } else if(strechCurrentIndex != toIndex) {
                        strechCurrentName = name
                        strechCurrentIndex = toIndex
                        switchPage(strechCurrentName)
                    }
                }
            }
        }

        ListView {
            id: subView
            model: subItem
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            Layout.preferredHeight:  stretch  ?subView.contentHeight : 0
            visible: true
            clip: true
            currentIndex: -1
            delegate: stretchList.delegate

            Behavior on Layout.preferredHeight {
                NumberAnimation { duration: 200 }
            }

            displaced: Transition {
                     NumberAnimation { properties: "x,y"; duration: 90 }
            }
        }

    }


}
