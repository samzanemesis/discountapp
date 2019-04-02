import QtQuick 2.0
import QtQuick.Controls 2.2

import NinepunchGlobals 1.0

Item{
    property string headerLabel: "Settings"
    width: parent.width
    height: 48
    Label{
        text: parent.headerLabel
        font.pointSize: 18
        anchors{
            left: parent.left
            leftMargin: 48

        }
        height: parent.height
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle{
        width: parent.width - 48
        height: 1
        anchors{
            right: parent.right
            bottom: parent.bottom
        }
        color: Globals.mainColor
    }
}
