import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

Button{
    property bool closeButton: false
    property string fontIcon: ""
    property bool darkTheme: true


    implicitWidth:45
    implicitHeight: 30

    contentItem: Text{
        anchors.fill: parent
        text: parent.fontIcon
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: 11
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: darkTheme ? "white" : ( closeButton ? ( parent.hovered ? "white" : "black" ) : "black" )
    }

    background: Rectangle{
        implicitWidth:45
        implicitHeight: 30

        anchors.fill: parent

        color: closeButton ? "#e81123" : Globals.isDarkMode ? "white" : "black"
        opacity: closeButton ? parent.pressed ? 0.5 : ( parent.hovered ? 1.0 : 0.0 ) : ( parent.pressed ? 0.1 : ( parent.hovered ? 0.05 : 0.0 ) )
    }

}
