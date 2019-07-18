import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: qsTr("ListViewEx")

    ListViewEx {
        id: listView
        width: parent.width
        height: parent.height
        model: listModel
        delegate: listDelegate

        onLoad: {
            console.log("on load")
            listModel.insert(0, {"name": (Math.floor(Math.random() * 100)).toString(), "number": (Math.floor(Math.random() * 100)).toString()})
        }

        onLoadMore: {
            console.log("on load more")
            listModel.insert(listModel.count, {"name": (Math.floor(Math.random() * 100)).toString(), "number": (Math.floor(Math.random() * 100)).toString()})
        }
    }

    Component{
           id: listDelegate
           Rectangle{
               id: listItem
               width: parent.width
               height: 80

               Text {
                   id: text
                   font.family: "microsoft yahei"
                   font.pointSize: 12
                   height: parent.height
                   width: parent.width - delBtn.width
                   text: "Name: " + model.name + "\n" + "Number: " + model.number
                   color: "green"
                   verticalAlignment: Text.AlignVCenter
                   MouseArea{
                       property point clickPos: Qt.point(0, 0)

                       anchors.fill: parent
                       onPressed: clickPos  = Qt.point(mouse.x,mouse.y);
                       onReleased: {
                           var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                           if ((delta.x < 0) && (delBtnShowAnim.running === false) && (delBtn.width === 0))
                               delBtnShowAnim.start();
                           else if (delBtnHideAnim.running === false && (delBtn.width > 0))
                               delBtnHideAnim.start();

                       }
                   }
               }
               Rectangle{
                   color: "#AAAAAA"
                   height: 1
                   width: parent.width
                   anchors.bottom: parent.bottom
               }
               Rectangle{
                   id: delBtn
                   height: parent.height
                   width: 0
                   color: "#EE4040"
                   anchors.right: parent.right
                   Text {
                       font.family: "microsoft yahei"
                       font.pointSize: 12
                       anchors.centerIn: parent
                       text: qsTr("删除")
                       color: "#ffffff"
                   }
                   MouseArea{
                       anchors.fill: parent
                       onClicked: {
                           listView.model.remove(index);
                       }
                   }
               }
               PropertyAnimation{
                   id: delBtnShowAnim
                   target: delBtn
                   property: "width"
                   duration: 100
                   from: 0
                   to: 60
               }
               PropertyAnimation{
                   id: delBtnHideAnim
                   target: delBtn
                   property: "width"
                   duration: 100
                   from: 60
                   to: 0
               }
           }
       }


    ListModel {
        id: listModel
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
    }
}
