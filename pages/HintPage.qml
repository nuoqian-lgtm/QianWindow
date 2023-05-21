import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import "qrc:/common"
import "qrc:/common/qmlQianHints"
import "qrc:/common/qmlQianDialog"
Item {
    property int leftWidth: 182
    property int fontsize: 19

    Message{
        id:messageTip
        z: 1
        parent: Overlay.overlay
    }

    function message(type, message) {
        if(type!=='success'&&type!=='error'&&type!=='info'){
            return false
        }
        messageTip.open(type, message)
    }

    SkinQianDialog {
        id: skinQianDialog
        backParent: windowEntry
        parent: Overlay.overlay
        onAccept: {
           message('success', "You clicked the accept button!")
           skinQianDialog.close();
        }
    }



    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: 60
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 60
        spacing: 22

        RowLayout {
            YaheiText {
                text: "Top Hint"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20

                SkinBaseButton {
                  font.pixelSize:  14
                  backRadius: 4
                  text: "Info"
                  onClicked: message('info', "You clicked the info button!")
                }
                SkinBaseButton {
                    font.pixelSize:  14
                    backRadius: 4
                    text: "Error"
                    onClicked: message('error', "You clicked the error button!")
                }
                SkinBaseButton {
                    font.pixelSize:  14
                    backRadius: 4
                    text: "Success"
                    onClicked: message('success', "You clicked the success button!")
                }

            }
        }

        Rectangle {
            height: 1
            color: tingeOpacityColor
            Layout.fillWidth: true
        }

        RowLayout {
            YaheiText {
                text: "对话框"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20
                RowLayout {
                    spacing: 40
                    SkinBaseButton {
                      font.pixelSize:  14
                      backRadius: 4
                      text: "无标题询问"
                      onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogQuestion, "是否需要清理任务？")
                    }
                    SkinBaseButton {
                        font.pixelSize:  14
                        backRadius: 4
                        text: "带标题询问"
                        onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogQuestion, "是否需要清理任务？", "任务清理")
                    }
                }

                RowLayout {
                    spacing: 40
                    BaseButton {
                      font.pixelSize:  14
                      backRadius: 4
                      text: "无标题成功"
                      bckcolor: "#4785FF"
                      onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogSuccess, "任务清理完成! 请重启软件生效!")
                    }
                    BaseButton {
                        font.pixelSize:  14
                        backRadius: 4
                        text: "带标题成功"
                        bckcolor: "#4785FF"
                        onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogSuccess, "任务清理完成! 请重启软件生效!", "任务清理")
                    }
                }
                RowLayout {
                    spacing: 40
                    BaseButton {
                      font.pixelSize:  14
                      backRadius: 4
                      text: "无标题提示"
                      bckcolor: "#16B7BF"
                      onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogInformation, "当前没有任务可以清理!")
                    }
                    BaseButton {
                        font.pixelSize:  14
                        backRadius: 4
                        text: "带标题提示"
                        bckcolor: "#16B7BF"
                        onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogInformation, "当前没有任务可以清理!", "任务清理")
                    }
                }

                RowLayout {
                    spacing: 40
                    BaseButton {
                      font.pixelSize:  14
                      backRadius: 4
                      text: "无标题错误"
                      bckcolor: "#EC3315"
                      onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogError, "清理任务失败,请检查用户权限!")
                    }
                    BaseButton {
                        font.pixelSize:  14
                        backRadius: 4
                        text: "带标题错误"
                        bckcolor: "#EC3315"
                        onClicked: skinQianDialog.dialogOpen(SkinQianDialog.DialogError, "清理任务失败,请检查用户权限!", "任务清理")
                    }
                }


            }
        }

        Rectangle {
            height: 1
            color: tingeOpacityColor
            Layout.fillWidth: true
        }

        RowLayout {
            YaheiText {
                text: "提示标记"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20

                RowLayout {
                    BaseCheckBox {
                      font.pixelSize: fontsize - 2
                      text: "开启GPU渲染"

                    }
                    QianQuestionMark {
                        hint: "如果支持GPU,开启GPU渲染更加流畅"
                    }

                }

                RowLayout {
                    BaseCheckBox {
                      font.pixelSize: fontsize - 2
                      text: "开启安全防护"
                    }
                    QianQuestionMark {
                        hint: "开启后不被其他恶意软件篡改"
                    }

                }




            }
        }






        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

    }

}
