import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

import QtGraphicalEffects 1.0

import "../Windows" as Windows

import "../js/fonticons.js" as FontIcons



Column{
    id: header
    property bool isThread: false
    property string title: "Ninepunch"
    property bool useBackButton: false

    width: parent.width

    Windows.TitleBar{}
    ToolBar {
        id: toolBar
        width: parent.width
        height: 48
        visible: stackView.currentItem.useHeader

        background: Rectangle{
            anchors.fill: parent
            color: Globals.mainColor

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 3
                samples: 10
                spread: 0
                radius: 8
                color: "#30000000"
            }
        }

        RowLayout {
            width: parent.width

            spacing:0

            PostToolButton{
                glyph: header.useBackButton ? FontIcons.Ionicons.ios_home_outline : FontIcons.Ionicons.android_menu
                Layout.fillWidth: false
                glyphOpacity: 1
                onClicked: {
                    discountApp.updateGuildList();
                    if(header.useBackButton){
                        stackView.pop();
                        return;
                    }

                    if( sidePanel.state === "OPEN" )
                        sidePanel.state = "CLOSED";
                    else
                        sidePanel.state = "OPEN";

                }
            }
            Label {
                leftPadding: 10
                text: header.title
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                font.weight: Font.DemiBold
                font.pointSize: 14
                color: "white"
            }

            PostToolButton{
                implicitWidth: implicitHeight - 5
                glyph: FontIcons.Ionicons.ios_bell
                Layout.fillWidth: false
                glyphOpacity: 0.9
                Rectangle{
                    width: 12
                    height: width
                    radius: width * 0.5

                    x: parent.width/2
                    y: parent.height/2
                    color: "#F26144"
                    Label{
                        anchors.centerIn: parent;
                        text: "2"
                        font.pixelSize: 7
                        font.weight: Font.Bold
                        color: "white"
                    }
                }
            }
            PostToolButton{
                property bool isToggled: false
                implicitWidth: implicitHeight - 5
                glyph: FontIcons.Ionicons.android_people
                Layout.fillWidth: false
                glyphOpacity: 0.9
                fontFamily: "FontAwesome"
                onClicked: {
                    if( userPanel.state === "OPEN" )
                        userPanel.state = "CLOSED";
                    else
                        userPanel.state = "OPEN";
                }

            }
        }
    }
}
