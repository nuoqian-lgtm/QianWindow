import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtCharts 2.14
import QtQuick.Controls.Material 2.12
import Qt.Singleton 1.0
import QtGraphicalEffects 1.14
import "qrc:/common"
Rectangle {
    id: contentList

    color: mainColor

    RowLayout {
        anchors.fill: parent
        anchors.rightMargin: 14
        anchors.leftMargin: leftSidebar.isOpen ? 14 : 0
        anchors.topMargin: 14
        anchors.bottomMargin: 14

        Behavior on anchors.leftMargin {
            NumberAnimation { duration: 100 }
        }

        spacing: 20
        LeftSidebar {
            id: leftSidebar
            Layout.fillHeight: true
            layoutPreferredWidth: skin.gradSupport  ? 175 : 198
            bckColor: !skin.gradSupport && !skin.imageSupport ? skin.contentBackColor:
                        !skin.light  ? Qt.rgba(0,0,0, 0.7 - setting.skinOpacity * 0.38) : Qt.rgba(1,1,1, 0.20 + setting.skinOpacity * 0.68)

        }

        Rectangle {
            Layout.leftMargin: -leftSidebar.tailWidth
            Layout.fillHeight: true
            Layout.fillWidth: true

            radius: skin.gradSupport || skin.imageSupport ? 14 : 8
            color: !skin.gradSupport && !skin.imageSupport ? skin.contentBackColor :
                            !skin.light  ? Qt.rgba(0,0,0, 0.7 - setting.skinOpacity * 0.38) : Qt.rgba(1,1,1, 0.10 + setting.skinOpacity * 0.88)


            layer.enabled: skin.shadow
            layer.effect: DropShadow {
                color: !skin.gradSupport && !skin.imageSupport ? "#36000000" : "#36FFFFFF"
                radius: 8
                samples: 17
            }

            PageManager {
                id: pages
                anchors.fill: parent


            }
        }

    }

    Connections {
        target: leftSidebar.stretchEntry
        onSwitchPage:  pages.switchPage(name)
    }

}
