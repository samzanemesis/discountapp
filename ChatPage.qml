import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

import "Android"
import "Components"
import "js/fonticons.js" as FontIcons

Page {
    property bool useBackButton: false
    property bool useHeader: true

    ListView{
        id: chatContent
        anchors.fill: parent

        model: 20
        delegate: Item{
            width: parent.width
            height: childrenRect.height
            Item{
                id: chatAvatar
                width: 64
                height: 48
                Rectangle{
                    width: 32
                    height: width
                    radius: width * 0.5
                    anchors.centerIn: parent
                }
            }
            Column{

                anchors{
                    left: chatAvatar.right
                    right: parent.right
                    top: parent.top
                    margins: 4
                }
                Row{
                    spacing: 8
                    Label{
                        text: "Sam Za Nemesis"
                        font.weight: Font.DemiBold
                    }
                    Label{
                        text: "today at 00:00"
                        font.pixelSize: 12
                        color: "gray"
                        anchors.bottom: parent.bottom
                    }
                }
                Label{
                    text: "Lorem ipsum dolor sit amet"
                }
            }
        }

        //Indicate that we are loading previous messages
        footer: Item{
            width: parent.width
            height: 64
            BusyIndicator{
                width: 48
                height: 48
                anchors.centerIn: parent
            }
        }

        //Space so our crazy footer can breathe
        header: Item{
            width: 1
            height: 64
        }

        verticalLayoutDirection: ListView.BottomToTop
    }

    BlurRectangle{
        element: chatContent
        useRGBA: true

        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        color: Globals.mainColor

        height: chatTextArea.contentHeight + 32

        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        RowLayout{
            anchors.fill: parent
            anchors.margins: 4

            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            PostToolButton{
                glyph: FontIcons.Ionicons.ios_plus
                implicitHeight: 32

                onClicked: {

                    console.log( JSON.stringify(discountApp.qdiscord) );

                    console.log( JSON.stringify(discountApp.qdiscord.state) );
                    console.log( JSON.stringify(discountApp.qdiscord.state.guilds) );

                    console.log( JSON.stringify(discountApp.qdiscord.state.guilds[0]) );

                    console.log( discountApp.qdiscord.state.guilds[0].icon );

                }
            }
            Rectangle{
                width: 1
                height: 32
            }
            TextArea{
                id: chatTextArea
                height: 32
                Layout.fillWidth: true
                color: "white"
            }
            PostToolButton{
                glyph: FontIcons.Ionicons.happy
                implicitHeight: 32
            }
            PostToolButton{
                glyph: FontIcons.Ionicons.android_send
                implicitHeight: 32
            }
        }

    }

}
