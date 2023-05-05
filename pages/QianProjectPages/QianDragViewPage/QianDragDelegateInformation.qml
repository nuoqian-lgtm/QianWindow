import QtQuick 2.0
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14
import ".."
import "qrc:/common"
Rectangle {
    id: container
    property var modelData: null
    property bool isSelect: false
    signal requestRemove()

    radius: itemRadius
    Layout.margins: 4
    implicitHeight: itemHeight
    implicitWidth: itemWidth
    color:   isSelect ? "#FED963" : skin.light ? "#F1F1F1" : "#222"
    clip: true

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 1
        verticalOffset: 1
        color: "#000"
    }

    ImageButton {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 5
        width: 49
        height: 49
        imageSrc: "qrc:/pages/QianProjectPages/QianDragViewPage/remove.png"
        backHoverColor: skin.light ? "#02000000" : "#11FFFFFF"
        ToolTip.delay: 1000
        ToolTip.visible: hovered
        ToolTip.text: qsTr("删除")
        onClicked:  requestRemove()
    }

    Text {
        anchors.centerIn: parent
        color: isSelect ? "#AC2727" : skin.light ? "#F2732E" : "#FED963";
        text:  modelData == null ? "" : modelData.name
        font.pixelSize: itemPixSize
        font.family: "Microsoft Yahei"
        elide: Text.ElideRight
    }
}
