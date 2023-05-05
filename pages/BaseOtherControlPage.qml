import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import "qrc:/common"
Item {

    property int leftWidth: 182
    property int fontsize: 19
    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: 60
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 60
        spacing: 22

        RowLayout {
            YaheiText {
                text: "Progress Bar"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20
                ProgressBar {
                  id: progress
                  indeterminate: false
                  implicitWidth: 220
                  value: 0

                  NumberAnimation on value {
                      id: progressAnimation
                      from: 0
                      to: 1
                      duration: 2000
                      running: true
                      loops: Animation.Infinite
                  }
                }

                ProgressBar {
                  indeterminate: true
                  implicitWidth: 220
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
                text: "BusyIndicator"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20
                RowLayout {
                    spacing: 20
                    BusyIndicator {
                        running: true

                    }

                    BusyIndicator {
                        running: true
                        Material.accent: "#4785FF"

                    }
                    BusyIndicator {
                        running: true
                        Material.accent: "#EC3315"

                    }
                    BusyIndicator {
                        running: true
                        Material.accent: "#ED9709"

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
                text: "Dial"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 20
                RowLayout {
                    spacing: 20
                    Dial {
                    }

                    Dial {
                        Material.accent: "#4785FF"

                    }
                    Dial {
                        Material.accent: "#EC3315"

                    }
                    Dial {
                        Material.accent: "#ED9709"

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
                text: "Slider"
                font.pixelSize: fontsize
                Layout.preferredWidth: leftWidth
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            ColumnLayout {
                spacing: 10
                RowLayout {
                    spacing: 20
                    YaheiText {
                        text: "Skin Slider"
                        font.pixelSize: fontsize
                        Layout.preferredWidth: 134
                    }
                    Slider {
                        from: 1
                        value: 25
                        to: 100
                    }
                }

                RowLayout {
                    spacing: 20
                    YaheiText {
                        text: "Blue Slider"
                        font.pixelSize: fontsize
                        Layout.preferredWidth: 134
                    }
                    Slider {
                        from: 1
                        value: 25
                        to: 100
                        Material.accent: "#4785FF"
                    }
                }

                RowLayout {
                    spacing: 20
                    YaheiText {
                        text: "Red Slider"
                        font.pixelSize: fontsize
                        Layout.preferredWidth: 134
                    }
                    Slider {
                        from: 1
                        value: 25
                        to: 100
                        Material.accent: "#EC3315"
                    }
                }

                RowLayout {
                    spacing: 20

                    YaheiText {
                        text: "Yellow Slider"
                        font.pixelSize: fontsize
                        Layout.preferredWidth: 134
                    }
                    Slider {
                        from: 1
                        value: 25
                        to: 100
                        Material.accent: "#ED9709"
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
