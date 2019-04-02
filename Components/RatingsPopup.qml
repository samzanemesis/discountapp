import QtQuick 2.0
import QtQuick.Controls 2.2
import "../js/fonticons.js" as FontIcons

NinepunchPopup{

    id: popupRoot

    //Close button
    ToolButton{
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked: popupRoot.close()

        FontIcon{
            color: "white"
            anchors.centerIn: parent
            glyph: FontIcons.Ionicons.android_close
            fontFamily: "IonIcons"
        }
    }

    Label{
        id: rateLabel
        text: "Rate %USERNAME%"
        font.pixelSize: 18
        width: parent.width
        height: 64
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
    }

    Rectangle{
        width: 200
        anchors{
            top: rateLabel.bottom
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

    }
}
