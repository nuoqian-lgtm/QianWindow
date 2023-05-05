import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
Popup {
  id: _popup
  property int bckRadius: 1

  property var backParent: undefined
  signal accept();
  signal reject();
  property alias acceptText: acceptBtn.text
  property alias rejectText: rejectBtn.text
  property bool acceptVisible: true
  property bool rejectVisible: true

  property bool bottomBtnsVisible: true


  implicitWidth: 300
  implicitHeight: 300

  background: Rectangle {
      id: back
      anchors.fill: parent
      radius: bckRadius
      color:skin.light ? "#fff" : "#171717"


  }
  padding: 0

  RowLayout {
     id: btns
     visible: bottomBtnsVisible
     parent: background
     anchors.bottom: parent.bottom
     anchors.bottomMargin: 12
     anchors.rightMargin: 20
     anchors.right: parent.right
     height: 24

     BaseButton {
         id: rejectBtn
         text: "取消"
         Layout.preferredHeight: 26
         Layout.preferredWidth: 68
         font.pixelSize: 13
         bckcolor: "#eeF65924"
         visible: rejectVisible
         backRadius: 2
         onClicked: {
              reject();
              close();
         }
     }

     SkinBaseButton {
         id: acceptBtn
         text: "确定"
         Layout.preferredHeight: 26
         Layout.preferredWidth: 68
         font.pixelSize: 13
         backRadius: 2
         visible: acceptVisible
         onClicked: {
               accept()
         }
     }
  }

  modal: true
  dim: false
  parent: Overlay.overlay
  Rectangle {
    visible: backParent ==  undefined ? false : _popup.visible
    opacity: _popup.opacity
    parent: backParent ==  undefined ? background : backParent
    anchors.fill: parent
    color: "#56000000"
    z:99999
  }


  x : Math.round((parent.width - _popup.width) / 2)
  y : Math.round((parent.height -_popup.height) / 2)

  focus: true
  closePolicy: Popup.CloseOnEscape

  enter: Transition {
        id: _enterAnima

        ScriptAction {
            script: {

            }
        }
        NumberAnimation { property: "opacity"; from: 0.3; to:1.0; duration: 300;  }
        NumberAnimation { property: "y"; from: Math.round((_popup.parent.height - height) / 5); to: Math.round((_popup.parent.height - height) / 2); duration: 300;  }
        ScriptAction {

            script: {
                if(contentChildren.length>0)
                    btns.parent = contentChildren[0]
            }
        }
  }

  exit: Transition {
        id: _exitAnima

        NumberAnimation { target:_popup; property: "opacity"; from: 1.0; to: 0.3; duration: 300;  }
        NumberAnimation { target:_popup; property: "y"; to: Math.round((_popup.parent.height - height) / 5); duration: 300;  }

//        ScriptAction {
//            script: acceptFlg ? accept() : reject();
//        }
  }


}
