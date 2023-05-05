import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.3
import "qrc:/common"

Item {

    FileDialog {
        id: _file
        title: "打开文件"
        selectMultiple: true
        selectFolder: false
        nameFilters: ["all files (*.png *.jpg *.mp3 *.mp4 *.avi *.wav)"]
        onAccepted: {
            for(let i = 0; i < fileUrls.length; i++) {


                appendFile(fileUrls[i])
            }

        }
    }

    ListModel {
        id: fileModel
    }

    function appendFile(fileLocal) {

        let arr =   fileLocal.split("/")

        fileModel.append({"fileLocal": fileLocal, "name":arr[arr.length-1]})

    }

    Component {
        id: _contentDelegate
        Item {
            id: block
            width: _content.cellWidth; height: _content.cellHeight
            clip: true
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 6
                Rectangle {
                  Layout.fillWidth: true
                  Layout.fillHeight: true
                  radius: 5
                  color: "#070709"
                  Image {
                    anchors.fill: parent
                    anchors.margins: 4
                    source: fileLocal
                    fillMode:  Image.PreserveAspectCrop
                  }
                }
                YaheiText {
                    text: name
                    Layout.fillWidth: true
                    elide: Text.ElideMiddle
                    clip: true
                    font.pixelSize: 14
                    color: "#888"
                }
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                  _content.currentIndex = index;
              }
            }
        }
    }


    ColumnLayout {
        visible: fileModel.count
        anchors.fill: parent
        anchors.margins: 8
        SkinBaseButton {
            onClicked: _file.open()
            Layout.preferredHeight: 36
            Layout.preferredWidth: 88
            backRadius: 4

            contentItem: Item {
                RowLayout {
                    anchors.centerIn: parent
                    Rectangle {
                        Layout.preferredHeight: 18
                        Layout.preferredWidth: 18
                        radius: 9
                        color: "#00C1CD"
                        YaheiText {
                            text: "+"
                            font.pixelSize: 14
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -1
                            color: "#FFF"
                        }
                    }

                    YaheiText {
                        text: "导入"
                        font.pixelSize: 16
                        color: "#fff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                }


            }
        }

        GridView {
            id: _content
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: fileModel
            cellWidth:  parent.width/4
            cellHeight: cellWidth - 20
            delegate: _contentDelegate
            clip: true
            currentIndex: -1
            highlight: Rectangle { color:"transparent"; border.width: 3; border.color: "#00C1CD";  radius: 3 }
        }

    }



    SkinBaseButton {
        visible: !fileModel.count

        width: 260
        height: 180
        text: ""

        anchors.centerIn: parent

        onClicked: _file.open()

        ColumnLayout {
            anchors.centerIn: parent

            RowLayout {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                Rectangle {
                    Layout.preferredHeight: 18
                    Layout.preferredWidth: 18
                    radius: 9

                    color: "#00C1CD"

                    YaheiText {
                        text: "+"
                        font.pixelSize: 14
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -1
                        color: "#FFF"
                    }
                }

                YaheiText {
                    text: "导入"
                    font.pixelSize: 18
                    color: "#F5F5F5"
                }

            }
            YaheiText {
                text: "视频、音频、图片"
                font.pixelSize: 15
                color: "#33ffffff"
            }

        }



    }



}
