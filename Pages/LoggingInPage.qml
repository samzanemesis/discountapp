import QtQuick 2.0
import QtQuick.Controls 2.2

import NinepunchGlobals 1.0

import "../Components"
import "SettingsPage"

import "../js/fonticons.js" as FontIcons

Page {
    property bool useBackButton: true
    property bool useHeader: false

    title: "Log In"


    Column{
        anchors.centerIn: parent
        spacing: 16


        Rectangle{

            rotation: 0.1
            onRotationChanged: { rotation = rotation + 0.5 }
        }

        BusyIndicator{
            width: 64
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Label{
            text: "Be glad that we don't put memes here."
            anchors.horizontalCenter: parent.horizontalCenter
            //font.weight: Font.DemiBold
            font.italic: true
        }
        Label{
            text: "CONNECTING"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.5
        }
    }

    Component.onCompleted: {
        console.log("Fart");
        discountApp
    }
}
