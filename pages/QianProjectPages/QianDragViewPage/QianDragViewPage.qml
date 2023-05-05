import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import "qrc:/common"
Item {

    property int index: 5
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 22

        property int index: 5

        RowLayout {
            Layout.fillWidth: true

            spacing: 5
            BaseTextField {
                id: input
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                text: "数据块" + index
                font.pixelSize: 18
                font.family: "Microsoft Yahei"


            }
            SkinBaseButton {
                id: btn
                text: "添加"
                font.pixelSize: 17
                backRadius: 4
                onClicked: {
                    if (input.text.length > 0) {
                        list.append(input.text)
                        index += 1
                        input.text = "数据块" + index
                    }
                }
            }
        }

        QianDragView {
           id: list
           Layout.fillWidth: true
           Layout.fillHeight: true
           clip: true
        }

    }

}
