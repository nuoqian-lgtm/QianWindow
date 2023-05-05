import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import Qt.labs.platform 1.0
import Qt.Singleton 1.0
import "qrc:/common"

Popup {
  id: _popup




  background: Rectangle {
      implicitWidth: 650
      implicitHeight: 420
      radius: 1
      layer.enabled: true
      gradient: skin.gradient
      layer.effect: DropShadow {
         visible: !_enterAnima.running & !_exitAnima.running
      }
      Image {
         id: image
         visible: skin.imageSupport
         anchors.fill: parent
         source: !skin.imageSupport ? "" : skin.imageUrl
         fillMode: Image.PreserveAspectCrop
      }

      ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            color: skin.titleColor
            width: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: 33
        }
        Rectangle {
            color: skin.contentBackColor
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
      }


      ImageButton {
          anchors.right: parent.right
          imageSrc: "qrc:/windowRes/close.png"
          // hoverimageSrc:"qrc:/res/close_hover.png"
          backHoverColor: "#FA5151"
          ToolTip.delay: 1000
          ToolTip.visible: hovered
          ToolTip.text: qsTr("关闭")
          onClicked: close();
      }
      Image {
          antialiasing: true
          source: "qrc:/windowRes/icon.png"
          width: 24
          height: 24
          x: 4
          y: 2
          fillMode: Image.PreserveAspectFit
      }
      YaheiText {
          text: "主题装扮"
          font.pixelSize: 15
          x: 32
          y: 4
          color: "#FFF"
      }

      Row {
          spacing: 12
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: 23
          anchors.bottomMargin: 5
          visible: skin.gradSupport || skin.imageSupport
          YaheiText {
              text: "透明度"
              font.pixelSize: 13
              color: skin.accentColor
              anchors.verticalCenter: parent.verticalCenter
          }
          BaseSlider {
              id: _slider
              from: 0.5
              to: 1.0
              value:  setting.skinOpacity
              onMoved: {
                setting.skinOpacity = value;
              }
          }
      }

      Row {
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.rightMargin: 23
          anchors.bottomMargin: 8
          spacing: 6

          SkinBaseButton {
              text: "自定义"
              height: 21
              width: 75
              font.pixelSize: 12
              anchors.verticalCenter: parent.verticalCenter
              backRadius: 5
              onClicked: {
                  message('info', "暂不支持!")

              }
          }


          SkinBaseButton {
              text: "恢复默认"
              height: 21
              width: 75
              font.pixelSize: 12
              anchors.verticalCenter: parent.verticalCenter
              backRadius: 5
              onClicked: {
                     _content.currentIndex = 1;
                    setting.skinOpacity = 0.9
              }
          }
      }
  }


  GridView {
      id: _content
      anchors.fill: parent
      anchors.topMargin: 30
      anchors.bottomMargin: 30
      model: SkinSingleton.skins
      cellWidth: parent.width/4
      cellHeight: cellWidth
      delegate: SkinSingleton.exteriorComponent
      clip: true
      currentIndex: setting.skinIndex
      highlight: Rectangle { border.width: 2; color: "transparent"; border.color: accentColor;  radius: 5 }
      onCurrentIndexChanged: {
        setting.skinIndex = currentIndex
      }

      function requestSwitchSkin(idx) {
            _content.currentIndex = idx;
      }
  }

  modal: true
  dim: false
  focus: true

  parent: Overlay.overlay
  x: Math.round((parent.width - width) / 2)
  y: Math.round((parent.height - height) / 2)

  closePolicy: Popup.CloseOnEscape

  enter: Transition {
        id: _enterAnima
        NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: 200; easing.type : Easing.OutBack }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 300;  }
        ScriptAction {
            script: _content.positionViewAtIndex( setting.skinIndex, GridView.Center);
        }
  }
  exit: Transition {
        id: _exitAnima
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 300; }
  }
}
