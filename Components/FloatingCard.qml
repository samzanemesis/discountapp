import QtQuick 2.0
import QtGraphicalEffects 1.0
import NinepunchGlobals 1.0

Flickable{
    contentHeight: rectFuck.height

    default property alias contents: placeholder.data

    anchors.fill: parent
    Item{
        width: parent.width > 768 ? 768 : parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: rectFuck
            width: parent.width

            Item{
                width: parent.width
                height: app.width > 768 ? 128 : 0
            }

            Rectangle {
                id: rectFucking
                width: parent.width;
                height: childrenRect.height;
                color: Globals.backgroundColor
                Column{
                    width: parent.width
                    id: placeholder
                }
                RectangularGlow {
                    id: effect
                    anchors.fill: parent
                    glowRadius: 20
                    spread: 0.2
                    color: Qt.rgba(0,0,0,0.1)
                    z:-1;
                    visible: app.width > 768
                }
            }



            Item{
                width: parent.width
                height: app.width > 768 ? 128 : 0
            }
        }


    }

}
