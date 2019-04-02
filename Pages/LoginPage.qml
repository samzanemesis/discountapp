import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

import "../Components"
import "SettingsPage"

Page {
    property bool useBackButton: true
    property bool useHeader: false

    title: "Log in"
    id: loginPage

    Rectangle{
        width: 256
        height: 32
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column{
        width: 300
        height: 300

        spacing: 8

        anchors.centerIn: parent

        Label{text: "Welcome back!"; font.pixelSize: 24; anchors.horizontalCenter: parent.horizontalCenter}
        Label{text: "Something something!"; font.pixelSize: 14; anchors.horizontalCenter: parent.horizontalCenter}

        Label{text: "TOKEN";font.pixelSize: 12;font.weight: Font.DemiBold}
        TextArea{width: parent.width; id: tokenTextArea; color: "white";text:"" }
        Label{text:"What's this?";font.pixelSize: 12;font.weight: Font.DemiBold; color: Globals.secondaryColor}
        Button{width: parent.width;text: "Sign in"; onClicked: loginPage.login() }
    }

    Label{
        text:   "<p>Discount is <i>not</i> affiliated to Discord Inc. in any way</p>
                <p>Please read our disclaimer <b>here</b></p>";
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }

        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: 12;
        opacity: 0.5
    }

    function login(){
        if(tokenTextArea.text === "" ){
            console.log("Empty!");
            return;
        }

        discountApp.doLogin( tokenTextArea.text );
    }


}
