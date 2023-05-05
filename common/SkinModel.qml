pragma Singleton
import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Layouts 1.14
import Qt.labs.settings 1.0

Item {
    property alias exteriorComponent: _exteriorComponent
    property int skinCustomIdx: skins.length-1
    property bool skinCustomUpdate: false


    property list<Item> skins : [
           Item {
            property string  name :  "简约白色"
            property bool    windowShadow: true
            property bool    shadow: true
            property string  mainColor: "#f0f0f0"
            property string  titleColor : "#4785FF"
            property string  contentBackColor : "#FFF"

            property string  accentColor : "#4785FF"
            property string  accentContrlColor : "#4785FF"

            property string  stretchColor : "#4785FF"
            property string  stretchBackHoverColor : "#444785FF"
            property string  stretchSelectColor: "#fff"
            property string  stretchBackColor: "#F6F6F6"
            property string  stretchSelectBackColor: "#4785FF"

            property string  stretchFoldSelectColor: "#4785FF"
            property string  stretchFoldBackColor: "transparent"


            property bool  light : true

            property bool  gradSupport: false
            property bool  imageSupport:  false


        },

        Item{
            property string  name :  "暗黑风格"
            property bool    shadow: false
            property string  mainColor: "#000"
            property string  titleColor: "#070709"
            property string  contentBackColor: "#252528"

            property string  accentColor: "#eee"
            property string  accentContrlColor: "#22ffffff"


            property string  stretchColor : "#eee"
            property string  stretchBackHoverColor : "#05ffffff"
            property string  stretchSelectColor: "#00C1CD"
            property string  stretchBackColor: "transparent"

            property string  stretchSelectBackColor: "#11ffffff"


            property string  stretchFoldSelectColor: "#00C1CD"
            property string  stretchFoldBackColor: "#252528"
            property string  stretchFoldBackSelectColor: "#343337"

            property bool    light : false
            property bool    gradSupport: false
            property bool    imageSupport:  false


        },
        Item {
           property string  name :  "午夜巴黎"
           property bool    windowShadow: true
           property bool    shadow: true
           property string  mainColor: "#44ffffff"
           property string  titleColor : "transparent"
           property string  contentBackColor : "#FFF"
           property string  accentColor : "#7C56FF"
           property string  accentContrlColor : "#7C56FF"

           property string  stretchColor : "#4785FF"
           property string  stretchBackHoverColor : "#11ffffff"
           property string  stretchSelectColor: "#fff"
           property string  stretchBackColor: "transparent"
           property string  stretchSelectBackColor: "#ee6BB1FF"

           property string  stretchFoldSelectColor: "#4785FF"
           property string  stretchFoldBackColor: "transparent"


           property bool    light : true
           property bool  gradSupport:   true
           property alias gradient:  _gradient
           property bool  imageSupport:  false
            property real  gradMainOpacity: 0.01



           Gradient {
               id: _gradient
               orientation: Gradient.Horizontal;
               GradientStop { position: 0.0; color: "#12B4FF" }
               GradientStop { position: 0.15; color: "#3297FF" }
               GradientStop { position: 1.0; color: "#B822FF" }
           }


       },

       Item {
            property string  name :  "秋日暖阳"
            property bool    windowShadow: true
            property bool    shadow: true
            property string  mainColor: "#44ffffff"
            property string  titleColor : "transparent"
            property string  contentBackColor : "#FFF"
            property string  accentColor : "#FF5245"
            property string  accentContrlColor : "#FF5245"

            // 伸展
            property string  stretchColor : "#FF5146"
            property string  stretchBackHoverColor : "#11ffffff"
            property string  stretchSelectColor: "#fff"
            property string  stretchBackColor: "transparent"
            property string  stretchSelectBackColor: "#eeFF8A6D"

            property string  stretchFoldSelectColor: "#FF5146"
            property string  stretchFoldBackColor: "transparent"


            property bool    light : true
            property bool  gradSupport:   true
            property alias gradient:  _gradient2
            property bool  imageSupport:  false
            property real  gradMainOpacity: 0.01



            Gradient {
                id: _gradient2
                orientation: Gradient.Horizontal;
                GradientStop { position: 0.0; color: "#FF7C20" }
                GradientStop { position: 0.3; color: "#FF4750" }
                GradientStop { position: 0.7; color: "#FF177A" }
                GradientStop { position: 1.0; color: "#FF0090" }
            }
        },
         Item {
            property string  name :  "午夜巴黎(透明)"
            property bool    windowShadow: false
            property bool    shadow: false
            property string  mainColor: "#44ffffff"
            property string  titleColor : "transparent"
            property string  contentBackColor : "#FFF"
            property string  accentColor : "#7C56FF"
            property string  accentContrlColor : "#7C56FF"

            // 伸展
            property string  stretchColor : "#4785FF"
            property string  stretchBackHoverColor : "#446BB1FF"
            property string  stretchSelectColor: "#fff"
            property string  stretchBackColor: "transparent"
            property string  stretchSelectBackColor: "#886BB1FF"

            property string  stretchFoldSelectColor: "#4785FF"
            property string  stretchFoldBackColor: "transparent"


            property bool    light : true
            property bool  gradSupport:   true
            property bool  imageSupport:  false
             property real  gradMainOpacity: 0.01



            property alias gradient:  _gradient3


            Gradient {
                id: _gradient3
                orientation: Gradient.Horizontal;
                GradientStop { position: 0.0; color: "#AA12B4FF" }
                GradientStop { position: 0.15; color: "#AA3297FF" }
                GradientStop { position: 1.0; color: "#AAB822FF" }
            }


        },

         Item {
          property string  name :  "简约白色(透明)"
          property bool    windowShadow: false
          property bool    shadow: false
          property string  mainColor: "#66FFFFFF"
          property string  titleColor : "#aa4785FF"
          property string  contentBackColor : "#baFFFFFF"

          property string  accentColor : "#4785FF"
          property string  accentContrlColor : "#4785FF"

          // 伸展
          property string  stretchColor : "#4785FF"
          property string  stretchBackHoverColor : "#11ffffff"
          property string  stretchSelectColor: "#fff"
          property string  stretchBackColor: "#AAF6F6F6"
          property string  stretchSelectBackColor: "#AA4785FF"

          property string  stretchFoldSelectColor: "#4785FF"
          property string  stretchFoldBackColor: "transparent"


          property bool    light : true

          property bool  gradSupport: false
          property bool  imageSupport:  false



      },

        Item {
             property string  name :  "蓝灰色"
             property bool    windowShadow: true
             property bool    shadow: true
             property string  mainColor: "#77ffffff"
             property string  titleColor : "transparent"
             property string  contentBackColor : "#FFF"
             property string  accentColor : "#507EA4"
             property string  accentContrlColor : "#507EA4"

             property string  stretchColor : "#507EA4"
             property string  stretchBackHoverColor : "#11ffffff"
             property string  stretchSelectColor: "#fff"
             property string  stretchBackColor: "transparent"
             property string  stretchSelectBackColor: "#C2D2DF"

             property string  stretchFoldSelectColor: "#507EA4"
             property string  stretchFoldBackColor: "transparent"


             property bool    light : true
             property bool  gradSupport:   true
             property alias gradient:  _gradient4
             property bool  imageSupport:  false
             property real  gradMainOpacity: 0.51


             Gradient {
                 id: _gradient4
                 orientation: Gradient.Horizontal;
                 GradientStop { position: 0.0; color: "#507EA4" }
             }
         }
    ]

    Component {
        id: _exteriorComponent
        Item {
            id: content
            property var skinTarget
            width: content.GridView.view.cellWidth; height: content.GridView.view.cellHeight
            clip: true
            Column {
                anchors.fill: parent
                spacing: 6
                anchors.topMargin: 10
                Rectangle {
                    implicitWidth: content.width - 20
                    implicitHeight: implicitWidth - 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: skins[index].mainColor
                    gradient: skins[index].gradient

                    Image {
                       visible: skins[index].imageSupport
                       anchors.fill: parent
                       source: !skins[index].imageSupport ? "" : skins[index].imageUrl
                       fillMode: Image.PreserveAspectCrop
                       mipmap: true
                    }


                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0
                        z: 1
                        Rectangle {
                            Layout.preferredHeight: 14
                            Layout.fillWidth: true
                            color: skins[index].imageSupport   ?  "#33000000" : skins[index].titleColor

                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            color: !skins[index].light  ? "#44000000" : "#11ffffff"
                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 6

                                Rectangle {
                                   z: 2
                                   Layout.fillHeight: true
                                   Layout.preferredWidth: 40
                                   color: !skins[index].gradSupport && !skins[index].imageSupport   ? skins[index].contentBackColor :
                                                                              !skins[index].light  ? "#33000000" : "#33ffffff"
                                   radius: 4

                                }

                                Rectangle {
                                   z: 2
                                   Layout.fillHeight: true
                                   Layout.fillWidth: true
                                   color: !skins[index].gradSupport && !skins[index].imageSupport   ? skins[index].contentBackColor :
                                                                        !skins[index].light  ? "#33000000" : "#33ffffff"
                                   radius: 4
                                }

                            }
                        }


                    }
                }

                YaheiText {
                    text: skins[index].name
                    font.pixelSize: 14
                    color: skins[content.GridView.view.currentIndex].accentColor
                    opacity: 0.7
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                  content.GridView.view.requestSwitchSkin(index)
              }
            }

        }

    }



}
