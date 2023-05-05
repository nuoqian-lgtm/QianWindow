import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtLocation 5.14
import QtQuick.Controls.Material 2.12
import Qt.labs.platform 1.0
import "qrc:/common"

DropPopup {
    id: skinDialog


    readonly property string typeQuestion : "question.png"
    readonly property string typeError : "error.png"
    readonly property string typeInformation : "info.png"
    readonly property string typeSuccess : "ok.png"

    enum DialogType {
        DialogQuestion,
        DialogError,
        DialogInformation,
        DialogSuccess
    }

    z: 100
    width: contentLayout.width-80 < 340 ? 340 : contentLayout.width + 80
    height: !title.length ? dialogLayout.height + 20 : dialogLayout.height + 40

    property alias title: _title.text
    property alias icon: _icon.source

    property string accentColorStr: accentColor
    function dialogOpen() {

        icon = typeInformation
        rejectVisible =   false
        open()
    }


    Item {
        anchors.fill: parent

        ImageButton {
            anchors.right: parent.right
            imageSrc: "qrc:/windowRes/close2.png"
            hoverimageSrc:"qrc:/windowRes/close_hover.png"
            backHoverColor: "#FA5151"
            BaseToolTip {
                 visible: parent.hovered
                 text: "关闭"
                 font.pixelSize: 12
                 delay: 1000
            }
            onClicked: close();
        }

        ColumnLayout {
            id: dialogLayout
            width: skinDialog.width
            spacing: 0
            RowLayout {
                visible: title.length
                Layout.leftMargin: 6
                Layout.preferredHeight: 28
                YaheiText {
                    id: _title
                    font.pixelSize: 16
                    color: tingeColor
                    text: "关于QianWindow"
                }
            }
            Rectangle {
                visible: title.length
                height: 1
                color: tingeOpacityColor
                Layout.fillWidth: true
            }
            ColumnLayout {
                id: contentLayout
                Layout.margins: 20
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                RowLayout {
                        Layout.topMargin: 20
                        Layout.bottomMargin: 20
                        Image {
                            id: _icon
                            antialiasing: true
                            source: "info.png"
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            fillMode: Image.PreserveAspectFit
                        }

                        YaheiText {
                            text: `最新版本视频地址： <font color="${accentColorStr}"><a href="https://space.bilibili.com/82157618/channel/seriesdetail?sid=3264958&ctype=0">B站演示入口</a></font>`
                            font.pixelSize: 15
                            color: tingeColor
                            onLinkActivated:  Qt.openUrlExternally(link);
                        }

               }

             }
         }
    }

}
