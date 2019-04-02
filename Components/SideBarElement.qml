import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

import "../js/fonticons.js" as FontIcons

Button {
    id: sideBarElement
    width: parent.width
    height: 48

    implicitWidth: width
    implicitHeight: height

    text: "Fat fuck"

    property bool isToggleSwitch: false
    readonly property bool switchState: switchToggle.checked

    property var glyph : FontIcons.Ionicons.person_add

    property int glyphSize : 18

    property color inkColor: Globals.mainColor


    contentItem: RowLayout{
        width: parent.width
        FontIcon{
            width: parent.height
            height: parent.height
            Layout.minimumWidth: width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            glyphSize: sideBarElement.glyphSize
            glyph: sideBarElement.glyph
        }
        Label{
            text: sideBarElement.text
            verticalAlignment: Text.AlignVCenter
            height: parent.height
            Layout.fillWidth: true
        }

        Switch{
            visible: isToggleSwitch
            onClicked: switchToggle.toggle()
            id: switchToggle
            height: 1
            Layout.minimumHeight: 1
            implicitHeight: 1
        }
    }

    onClicked: {
        switchToggle.toggle();
    }

    background: Rectangle{
        implicitWidth: parent.width
        implicitHeight: parent.height



        anchors.fill: parent
        anchors.margins: 0

        color: parent.inkColor
        opacity: parent.pressed ? 0.5 : ( parent.pressed ? 0.1 : ( parent.hovered ? 0.2 : 0.0 ) )
    }

    /*Rectangle{
        id: backgroundIndicator
        anchors.fill: parent
        color: "red"
        opacity: parent.pressed ? 0.5 : ( parent.pressed ? 0.1 : ( parent.hovered ? 0.05 : 0.1 ) )

    }*/

}
