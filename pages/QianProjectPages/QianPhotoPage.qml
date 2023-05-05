import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import Qt.labs.platform 1.1
import QtGraphicalEffects 1.14
import "qrc:/common"
Item {
    id: container
    property string picturesLocation : "";
    property var imageNameFilters : ["所有图片格式 (*.png; *.jpg; *.bmp; *.gif; *.jpeg)"];
    property var pictureList : []
    property alias pictureIndex : view.currentIndex
    property var scaleMax : 800           // 最大800%
    property var scaleMin : 10            // 最小10%
    property var titleColor : "#E8E8E8"


    property var ctrlSliderList : [
        ["放大", scaleMin, scaleMax , photoImage.scale * 100 , "%"],
        ["旋转", -180, 180 , photoImage.rotation, "°"],
    ]

    Material.foreground: tingeDrakerColor
    FileDialog {
        id: fileDialog
        title: "请打开图片(可以多选)"
        fileMode: FileDialog.OpenFiles
        folder: picturesLocation
        nameFilters: imageNameFilters
        onAccepted: {
            pictureList = files
            view.currentIndex = -1
            view.currentIndex = 0
        }
        onFolderChanged: picturesLocation = folder
    }

    Rectangle {
        id: back
        radius: 8
        color: skin.light ? "#F4F4F4" : "#22000000"
        anchors.fill: parent
        anchors.margins: 4
        clip: true

        antialiasing: true
    }


    Flickable {
        id: flick
        anchors.fill: back
        clip: true

        MouseArea {
            anchors.fill: parent
            onWheel: {
                console.log( photoImage.rotation, wheel.angleDelta.y);
                if (wheel.modifiers & Qt.ControlModifier) {     // ctrl + 滑轮 则进行旋转图片
                    photoImage.rotation += wheel.angleDelta.y / 120 * 5;
                    if (photoImage.rotation > 180)
                        photoImage.rotation =  180
                    else if (photoImage.rotation < -180)
                        photoImage.rotation =  -180
                    if (Math.abs(photoImage.rotation) < 4)
                        photoImage.rotation = 0;
                } else {
                    photoImage.scale += photoImage.scale * wheel.angleDelta.y / 120 / 10;
                    if (photoImage.scale > scaleMax / 100)
                        photoImage.scale =  scaleMax / 100
                    else if (photoImage.scale < scaleMin / 100)
                        photoImage.scale =  scaleMin / 100
                }
            }
        }
        Image {
            id: photoImage
            fillMode: Image.Pad
            source:  (typeof pictureList[pictureIndex] === 'undefined') ? "" : pictureList[pictureIndex]
            smooth: true
            mipmap: true
            antialiasing: true
            Component.onCompleted: {
                x = parent.width / 2 - width / 2
                y = parent.height / 2 - height / 2
                pictureList.length = 0
            }

            onStatusChanged:  {
                if(status == Image.Ready) {
                    photoImage.x = (imageBack.width) / 2 - photoImage.width / 2
                    photoImage.y = (imageBack.height) / 2 - photoImage.height / 2

                    console.log("back.width imageBack.width", back.width, imageBack.width, photoImage.width)


                    photoImage.scale = 1.0
                    photoImage.rotation = 0

                }

            }

            PinchArea {
                anchors.fill: parent
                pinch.target: parent
                pinch.minimumRotation: -180     // 设置拿捏旋转图片最大最小比例
                pinch.maximumRotation: 180
                pinch.minimumScale: 0.1         // 设置拿捏缩放图片最小最大比例
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAndYAxis
                drag.minimumX: 20 - photoImage.width
                drag.maximumX: flick.width - 20
                drag.minimumY: 20 - photoImage.height
                drag.maximumY: flick.height - 20
            }

        }
    }

    ColumnLayout {
        id: _source
        anchors.fill: back
        anchors.margins: 4
        spacing: 4
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 1

            Item {
                id: imageBack
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth : 220
                color: skin.light ? "#99FFFFFF" : "#88000000"

                radius: 8


                GroupBox {
                     id: fileGroup
                     title: "文件选项"

                     y:5
                     width: parent.width
                     font.family:  "Microsoft Yahei"
                     background.scale: 0.9

                     ColumnLayout {
                         anchors.centerIn: parent
                         spacing: 12
                         Repeater {
                             model : ListModel {
                                 id: fileModel
                                 ListElement { name: "打开文件";  }
                                 ListElement { name: "上一张";  }
                                 ListElement { name: "下一张"; }

                             }
                             SkinBaseButton {
                                 text: fileModel.get(index).name
                                 font.pixelSize: 15
                                 onPressed: fileGroupPressed(index)
                                 Layout.preferredWidth: 92
                                 Layout.preferredHeight: 30
                                 backRadius: 6

                             }
                         }
                     }
                }


                GroupBox {
                     id: ctrlGroup
                     title: "图片控制"
                     width: parent.width
                     font.family:  "Microsoft Yahei"
                     anchors.top: fileGroup.bottom
                     anchors.topMargin: 5
                     background.scale: 0.9

                     ColumnLayout {
                         width: parent.width-10
                         Repeater {
                             model : 2
                             RowLayout {
                                 YaheiText {
                                     leftPadding: 4
                                    text: ctrlSliderList[index][0]
                                    horizontalAlignment: Text.AlignRight
                                    font.pixelSize: 14
                                 }
                                 Slider {
                                    id: ctrlSlider
                                    Layout.fillWidth: true
                                    from: ctrlSliderList[index][1]
                                    value: ctrlSliderList[index][3]
                                    to: ctrlSliderList[index][2]
                                    stepSize: 1
                                    onMoved: setCtrlValue(index, value);
                                 }
                                 YaheiText {
                                     Layout.preferredWidth : 40
                                     color: tingeColor
                                     text: parseInt(ctrlSliderList[index][3].toString()) + ctrlSliderList[index][4]
                                 }
                             }
                         }
                     }
                }

                GroupBox {
                     id: imageInfoGroup
                     title: "基本信息"
                     width: parent.width
                     font.family:  "Microsoft Yahei"
                     height: 170
                     anchors.top: ctrlGroup.bottom
                     anchors.topMargin: 5
                     background.scale: 0.9


                     ColumnLayout {
                         width: parent.width-10
                         spacing: 16
                         YaheiText {
                            text: "尺寸: " + photoImage.sourceSize.width + "X" + photoImage.sourceSize.height
                            font.pixelSize: 14
                            color: tingeColor
                            leftPadding: 4
                         }
                         YaheiText {
                            text: "路径: " + ((typeof pictureList[pictureIndex] === 'undefined') ?
                                              "等待打开文件..." : pictureList[pictureIndex].replace("file:///",""))

                            Layout.preferredWidth: parent.width - 20
                            Layout.preferredHeight: 80
                            wrapMode: Text.Wrap
                            font.pixelSize: 14
                            color: tingeColor
                            leftPadding: 4
                         }

                     }
                }

            }


        }

        Rectangle {
            id: images
            Behavior on Layout.preferredHeight { NumberAnimation { duration: 250 } }
            Layout.fillWidth: true
            Layout.preferredHeight: 130
            color: skin.light ? "#99FFFFFF" : "#88000000"
            radius: 8

            ColumnLayout {
                anchors.fill: parent
                Button {
                    id: imageCtrlBtn
                    Layout.alignment: Qt.AlignVCenter | Qt. AlignRight
                    text:  images.Layout.preferredHeight <= 30 ? "展开("+pictureList.length+")" :
                                                                 "收起("+pictureList.length+")"

                    z: 100
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Label {
                        id: btnForeground
                        text: parent.text
                        font.family: "Microsoft Yahei"
                        font.pixelSize: 14
                        color:  imageCtrlBtn.hovered ? tingeColor : tingeDrakerColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onPressed: {
                        if (text.indexOf("收起") >= 0) {
                            images.Layout.preferredHeight = 30
                        } else {
                            images.Layout.preferredHeight = 130
                        }
                    }
                }

                ListView {
                      id: view
                      Layout.fillHeight: true
                      Layout.fillWidth: true
                      spacing: 4
                      orientation:  ListView.Horizontal
                      ScrollBar.horizontal: ScrollBar {
                          id: scroll1
                          policy: size<1.0? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

                          contentItem: Rectangle {
                               implicitHeight: 8
                               implicitWidth: 100
                               radius: height / 2
                               color: scroll1.pressed ? accentOpacityColor
                                                      : accentOpacityHoverColor
                          }
                          height: 8
                          background: Item {

                          }
                     }

                     model: pictureList.length


                     delegate: Rectangle {
                            implicitWidth: 85
                            implicitHeight: 85
                            Image {
                                anchors.fill:parent
                                anchors.margins: 6
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit
                                source: pictureList[index]
                            }
                            border.color: view.currentIndex == index ? accentContrlColor : "transparent"
                            color: tingeOpacityLightColor
                            radius: 3

                            MouseArea {
                                anchors.fill: parent
                                onClicked: view.currentIndex = index
                            }
                            Component.onCompleted: console.log("pictureList[index]",pictureList[index])
                     }



               }
            }
        }

    }



    function fileGroupPressed(index) {
        switch (index) {
            case 0 :  fileDialog.open(); break;
            case 1 :  openNewImageAndUpdateScroll(pictureIndex - 1); break;
            case 2 :  openNewImageAndUpdateScroll(pictureIndex + 1); break;
        }
    }


    function setCtrlValue(index, value) {
        switch (index) {
            case 0 :  photoImage.scale  = value / 100; break;
            case 1 :  photoImage.rotation = value; break;
        }
    }



    function openNewImageAndUpdateScroll(index) {
        if (index < 0 || index >= pictureList.length) {
            return false
        }
        pictureIndex = index
        view.positionViewAtIndex( pictureIndex, ListView.Beginning)

        return true
    }


}
