import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Universal 2.0

import com.sampavlovic.discount 1.0

import "Android"
import "Components"
import "Pages"

import NinepunchGlobals 1.0

ApplicationWindow {
    id: app
    visible: true
    width: 360
    height: 640
    title: qsTr("Ninepunch")

    property bool isMaximized: false;
    Material.theme: Globals.isDarkMode ? Material.Dark : Material.Light
    Material.accent: Globals.secondaryColor
    Material.background: Globals.deeperBackgroundColor

    Universal.theme: Globals.isDarkMode ? Universal.Dark : Universal.Light
    Universal.accent: Globals.secondaryColor
    Universal.background: Globals.deeperBackgroundColor

    //Dummy stuff
    FontLoader {
        source: "res/fonts/fontawesome-webfont.ttf"
    }
    FontLoader {
        source: "res/fonts/ionicons.ttf"
    }

    //Our lord and saviour
    Discount{
        id: discountApp
        onLoginFailed:      stackView.pop()
        onLoginSucceeded:   stackView.push(chatPage)
        onLoginStarted:     stackView.push(logginginPage);


        onGuildsChanged: {
            console.log(JSON.stringify(discountApp.guilds));
            console.log("*****Ayy guilds changed******");
        }
    }

    Component{ id: chatPage;        ChatPage{} }
    Component{ id: logginginPage;   LoggingInPage{} }

    header: HeaderComponent{
        id: headerComponent
        isThread: true
        title: stackView.currentItem.title
        useBackButton: stackView.currentItem.useBackButton
    }

    //Side panel
    SidePanel{ id: sidePanel }
    UserPanel{ id: userPanel }

    //Post page
    StackView{
        id: stackView
        anchors.fill: parent;
        initialItem: LoginPage{}
    }

    Component.onCompleted: {    }
}


