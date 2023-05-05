import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.12

ToolTip {
    y: parent.height + 3
    leftMargin: 0
    rightMargin: 0
    topPadding: Qt.platform.os === "linux" ? 11 : 9
    leftPadding: 3
    rightPadding: 3
    Material.foreground: "#EEE"

    font.family: "Microsoft Yahei"
    delay: 1000

}
