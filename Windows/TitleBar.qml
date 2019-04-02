import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

ToolBar {
    id: titlebar
    width: parent.width
    height: 30

    background: Rectangle{
        anchors.fill: parent
        color: app.active ? Globals.mainColor : Globals.mainColorDisabled
    }

    function toggleMaximized(){
        app.isMaximized ? app.showNormal() : app.showMaximized();
        app.isMaximized = !app.isMaximized;
    }

    MouseArea {
        id:dragparentwindow
        width: parent.width
        height: 57
        property real lastMouseX: 0
        property real lastMouseY: 0
        onPressed: {
            lastMouseX = mouseX
            lastMouseY = mouseY
        }
        onMouseXChanged: app.x += (mouseX - lastMouseX)
        onMouseYChanged: {
            app.y += (mouseY - lastMouseY)

            if(mouseY != lastMouseY && app.isMaximized)
                titlebar.toggleMaximized();

        }

        onDoubleClicked: toggleMaximized()
    }

    RowLayout{
        anchors.fill: parent
        spacing: 6
        opacity: app.active ? 1 : 0.95
        Item{
            width:1
        }
        Item{
            width: 16
            height: width
            anchors.verticalCenter: parent.verticalCenter
            Rectangle{
                anchors.fill: parent
                radius: 4
            }

            /*Image{
                source: "sdklauncher/punyhuman.png"
                mipmap: true
                anchors.fill: parent
            }*/
        }


        Text {
            text: "Discount"
            font.family: "Segoe UI"
            elide: Label.ElideRight
            verticalAlignment: Qt.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: true
            color: "white"
            font.pixelSize: 11
        }
        Row{
            TitleBarButton{
                fontIcon: ""
                onClicked: app.showMinimized()
            }
            TitleBarButton{
                fontIcon: app.isMaximized ? "" :  ""
                onClicked: titlebar.toggleMaximized();
            }
            TitleBarButton{
                fontIcon: ""
                closeButton: true
                onClicked: app.close()
            }
        }
    }

}
