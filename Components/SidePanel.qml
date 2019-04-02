import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

import "../js/fonticons.js" as FontIcons
import "../Pages"
import "../Android"
import ".."


BlurRectangle{
    id: sidePanel
    width: 256
    height: parent.height
    element: stackView
    z: 9999
    state: "CLOSED"

    visible: x > -width

    radius: 127

    //color: Globals.mainColor

    //Close other panel if this state changed to open
    onStateChanged: if(state === "OPEN") userPanel.state = "CLOSED";

    states: [
        State { name: "OPEN"
            PropertyChanges {
                target: sidePanel
                x: 0
            }
        },
        State { name: "CLOSED"
            PropertyChanges {
                target: sidePanel
                x: -width
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                properties: "x"
                duration: 500
                easing.type: Easing.OutExpo
                easing.period: 0.9
            }
        }
    ]

    //Cheap shadow
    LinearGradient{
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.05) }
            GradientStop { position: 1.0; color: "transparent" }
        }
        anchors.left: parent.right
        width: 16
        height: parent.height
    }

    //WTF
    Rectangle{
        anchors.left: parent.right
        height: parent.height
        width: stackView.width - (parent.x + parent.width)

        color: "black"

        opacity: (1-( Math.abs(parent.x) / parent.width )) * 0.25
        MouseArea{
            anchors.fill: parent
            onClicked: sidePanel.state = "CLOSED"
        }
    }

    ColumnLayout{
        anchors.fill: parent
        Item{
            width: parent.width
            Layout.fillHeight: true

            Rectangle{
                id: channelSelector
                width: 64
                height: parent.height
                color: Qt.rgba(Globals.mainColor.r,Globals.mainColor.g,Globals.mainColor.b,0.25)

                clip: true

                ListView{
                    id: guildsListView
                    anchors.fill: parent
                    model: discountApp.guilds
                    delegate: ChannelButton{
                        icon: discountApp.guilds[index].icon
                        name: discountApp.guilds[index].name
                        channelid: discountApp.guilds[index].id
                    }
                    header: Column{
                        width: parent.width
                        Item{ width: 1; height: 8 }
                        ChannelButton{}
                        Label{ text: "0 ONLINE"; font.pixelSize: 8; color: "gray";
                            anchors.horizontalCenter: parent.horizontalCenter; }
                        Item{ width: 1; height: 16 }

                    }
                }

            }


            ColumnLayout{
                anchors{
                    right: parent.right
                    left: channelSelector.right
                }
                height: parent.height
                Item{
                    width: parent.width
                    height: 48
                    Label{
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: "Channel Name"
                        font.weight: Font.DemiBold
                        anchors{
                            fill: parent
                            margins: 16
                        }
                    }

                    PostToolButton{
                        anchors.right: parent.right
                        glyph: FontIcons.Ionicons.android_arrow_dropdown
                    }
                    Rectangle{
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 1
                        opacity: 0.25
                    }
                }

                ListView{
                    Layout.fillHeight: true
                    width: parent.width

                    model: ListModel {
                        ListElement {
                            section: "Big Guys"
                            name: "BillSmith"
                            number: "555 3264"
                        }
                        ListElement {
                            section: "Big Guys"
                            name: "JohnBrown"
                            number: "555 8426"
                        }
                        ListElement {
                            section: "Big Guys"
                            name: "SamWise"
                            number: "555 0473"
                        }
                        ListElement {
                            section: "For You"
                            name: "Retro-Teamplay"
                            number: "555 0473"
                        }
                    }

                    clip: true

                    delegate: ItemDelegate {
                        text: "# " + name.toLowerCase()
                        width: parent.width
                        height: 42
                        leftPadding: 16
                        font.weight: Font.DemiBold
                        font.pixelSize: 12
                        //onClicked: root.StackView.view.push("qrc:/ConversationPage.qml", { inConversationWith: model.display })

                    }

                    section.property: "section"
                    section.criteria: ViewSection.FullString
                    section.delegate: Label {
                        text: section.toUpperCase()
                        height: 24
                        font.bold: true
                        font.pixelSize: 12
                        leftPadding: 16
                        color: "gray"
                    }

                    //Small shadow to better differentiate
                    LinearGradient{
                        start: Qt.point(0, height)
                        end: Qt.point(0, 0)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.05) }
                            GradientStop { position: 1.0; color: "transparent" }
                        }
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 32
                        z: 10
                    }
                }

            }
        }
        RowLayout{
            width: parent.width
            height: 48
            //Avatar
            Item{
                width: parent.height
                height: width
                Rectangle{
                    anchors.centerIn: parent
                    width: 32
                    height: width
                    radius: width * 0.5
                    //Online, Away, Busy indicator
                    Rectangle{
                        width: 10
                        height: width
                        radius: width *0.5
                        border.width: 2
                        border.color: sidePanel.color

                        color: "green"

                        anchors{
                            right: parent.right
                            bottom: parent.bottom
                        }
                    }
                }
            }
            //User Info
            Item{
                Layout.fillWidth: true
                height: parent.height

                Item{
                    height:32
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    Label{ font.pixelSize: 12; width: parent.width; anchors.top: parent.top; text: "Sam Za Nemesis"; font.weight: Font.DemiBold }
                    Label{ font.pixelSize: 12; width: parent.width; anchors.bottom: parent.bottom; text: "#1234"; opacity: 0.5 }
                }
            }
            //Settings button etc
            PostToolButton{
                glyph: FontIcons.Ionicons.android_settings
                onClicked: parent.pushPage( settingsPage )
            }
            function pushPage( page ){
                stackView.push( page );
                sidePanel.state = "CLOSED";
            }
        }

        Component{ id: settingsPage; SettingsPage{} }
    }

}


