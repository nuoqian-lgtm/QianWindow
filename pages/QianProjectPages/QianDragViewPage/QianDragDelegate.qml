import QtQuick 2.0
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
Item {
    id: container
    signal closeRequest()
    height: ListView.view.height
    width: contentLayout.width
    states: State {
        name: "remove";
        PropertyChanges { target: container; y: ListView.view.height }
    }

    transitions: Transition {
        SequentialAnimation {
            NumberAnimation { properties: "y";  duration: 200 }
            ScriptAction { script: closeRequest() }
        }
    }

    function informationContains(x, y) {
        if(x >= information.x  && (x) <= information.x + information.width
                && y >= information.y  && (y) <= information.y + information.height)
            return true

        return false
    }

    RowLayout {
        id: contentLayout
        Layout.margins: 4
        y: (container.height - itemHeight)/2
        spacing: 0
        Rectangle {
            radius: 2
            Layout.preferredHeight: itemHeight
            Layout.preferredWidth: interval
            visible: (index  == dragDelegate.dragIndex) && (index  != dragDelegate.pressIndex)
                   && (index-1  != dragDelegate.pressIndex)
            color:  "#FED963"
        }

        QianDragDelegateInformation {
            id: information
            isSelect: container.ListView.view.currentIndex == index
            opacity: dragDelegate.pressIndex == index ? 0.6 : 1.0
            onRequestRemove:  {
                container.state = "remove";
            }
            modelData: model
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
        Rectangle {
            radius: 1
            Layout.preferredHeight: itemHeight
            Layout.preferredWidth: interval

            visible: index+1 == container.ListView.view.count && (index+1  == dragDelegate.dragIndex) && (index  != dragDelegate.pressIndex)
            color:  "#FED963"

        }
    }


}
