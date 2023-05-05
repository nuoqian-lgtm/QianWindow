import QtQuick 2.14
import QtGraphicalEffects 1.12
import Qt.Window 1.0
import QtQuick.Window 2.14
import Qt.Singleton 1.0
import QtQuick.Controls.Material 2.12
import Qt.labs.platform 1.1
import Qt.labs.settings 1.0

Frameless {
    id: rootWindow

    property string titleStr: "QianWindow"
    property var areas: [
            Qt.rect(0, 0, 99999, 42)
    ]

    property color accentColor: SkinSingleton.skins[setting.skinIndex].accentColor              // 皮肤深色
    property color accentContrlColor: SkinSingleton.skins[setting.skinIndex].accentContrlColor  // 皮肤控件深色
    property color accentOpacityColor: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.5)        // 皮肤控件深色透明 (一般用在滚动条)
    property color accentOpacityHoverColor: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.45)  // 皮肤控件深色透明 淡色 (一般用在滚动条鼠标徘徊)

    property color tingeColor: skin.light ? "#555" : "#b1b1b1"                      // 皮肤淡色(白色皮肤为浅黑   黑色皮肤为灰色)
    property color tingeDrakerColor: Qt.darker(tingeColor, 1.2)                     // 皮肤谈深色



    property color tingeOpacityColor: skin.light ? "#11000000" : "#11FFFFFF"        // 皮肤谈透明色
    property color tingeOpacityLightColor: skin.light ? "#06000000" : "#06FFFFFF"   // 皮肤谈透明色(亮)


    property color mainColor: !skin.gradSupport && !skin.imageSupport ? skin.mainColor :
                              !skin.light  ? Qt.rgba(0,0,0, skin.gradMainOpacity - setting.skinOpacity * 0.48)    : Qt.rgba(1,1,1, skin.gradMainOpacity + setting.skinOpacity * 0.28)

    property var skin: SkinSingleton.skins[setting.skinIndex]


    Material.accent: accentColor
    Material.theme:  skin.light ? Material.Light : Material.Dark
    Material.foreground: tingeColor
    width: 1150
    height: 750
    visible: true
    title: titleStr
    color: "transparent"
    resizable: true
    moveArea:  areas
    minimumWidth: 1130
    minimumHeight: 730

    function closeFunc() {
        close();
    }

    WindowEntry {
        anchors.fill: parent
        anchors.margins: rootWindow.maximized ? 0 : 8
        radius: rootWindow.maximized ? 0 : 4
    }



    Settings {
        id: setting
        property int skinIndex: 1
        property real skinOpacity: 1
        property string skinCustomFile: ""
        fileName: "app.ini"
    }


}
