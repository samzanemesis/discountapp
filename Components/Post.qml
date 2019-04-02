import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

import "../Android"
import "../js/fonticons.js" as FontIcons

Column{
    property string message: "Lorem Ipsum"
    property string poster: "Lorem Ipsum"
    property var ratings: []

    property string postCountry: "Unknown"
    property string postMessage

    id: post
    width: parent.width

    //Time of posting
    Rectangle {
        width: parent.width
        height: 46
        color: Globals.overlayColor
        RowLayout{
            anchors.fill: parent;
            spacing:10
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Item{
                width:1
            }
            Image{
                source: "https://emojipedia-us.s3.amazonaws.com/thumbs/240/microsoft/106/alarm-clock_23f0.png"
                sourceSize.width: 16
                sourceSize.height: 16
                width: 16
                height: 16
            }

            Label{
                text: "10 hours ago"
                x: 10
                Layout.fillWidth: true

            }
            ToolButton{
                text: "⋯"
                font.pointSize: 18
            }
        }
    }

    Rectangle{
        width: parent.width
        height: childrenRect.height
        color: Globals.backgroundColor //Background

        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            anchors.bottomMargin: 0
            //Post Header
            MouseArea{
                width: parent.width
                height: 100
                onPressedChanged: opacity = pressed ? 0.5 : 1
                onClicked: posterInfoPopup.open();
                Row{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    //Avatar
                    Rectangle{
                        width: 82
                        height: width
                        radius: 8
                        color: "lightgray"
                        layer.enabled: parent.enabled
                        layer.effect: DropShadow {
                            verticalOffset: 3
                            color: Qt.rgba(0,0,0,0.15)
                            samples: 10
                            spread: 0
                            radius: 8
                        }
                    }
                    //PosterInfo
                    ColumnLayout{
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.fillWidth: true
                        spacing: 0
                        Label {
                            text: qsTr( poster )
                            font.weight: Font.Bold
                            color: "#0d5e9e"
                        }
                        Label {text: qsTr("Member")}
                        Label {text: qsTr("--- Coins")}
                    }

                }

                LinearGradient{
                    start: Qt.point(0, 0)
                    end: Qt.point(0, height)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Globals.backgroundColor }
                        GradientStop { position: 1.0; color: Qt.rgba(Globals.backgroundColor.r - 0.03,Globals.backgroundColor.g - 0.03,Globals.backgroundColor.b - 0.03,0.90) }
                    }
                    anchors.fill: parent
                    anchors.rightMargin: -10
                    anchors.leftMargin: -10

                    z:-1
                    Image{
                        source: "https://files.facepunch.com/forum/upload/718/f3f0f47c-26dc-4459-aa5f-f67fb9fe2af0/WhatTheFuckDidYouJustFuckingSayAboutMeYouLittleBitchIllHaveYouKnowIGraduatedTopOfMyClassInTheNavySeals.png"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        clip: true
                        z:-1
                    }
                }
            }



            //Thin line post separator
            Rectangle{
                width:parent.width
                height:1
                color: "black"
                opacity: 0.2
            }

            //Post Content
            Column{
                width: parent.width
                topPadding: 18
                spacing:0
                bottomPadding: 0
                Label{
                    text: post.postMessage
                    wrapMode: Text.WordWrap
                    anchors.left: parent.left
                    anchors.right: parent.right
                    textFormat: Text.RichText
                    onLinkActivated: console.log(link + " link activated")
                    linkColor: "blue"
                }
                //Ratings
                RowLayout{
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Item{
                        Label{
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Ratings go here"
                            opacity: 0.1
                        }
                        height: 48
                        Layout.fillWidth: true;
                    }
                    Button{
                        implicitHeight: 32 //42
                        implicitWidth: 64
                        padding: 0
                        Row{
                            anchors.centerIn: parent
                            FontIcon{
                                width: parent.height
                                glyphSize: 18
                                glyph: "\uf417"
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                            }
                            Label{
                                text: "Reply"
                                verticalAlignment: Qt.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                            }
                        }
                    }
                    Button{
                        implicitHeight: 32 //42
                        implicitWidth: 32
                        padding: 0
                        FontIcon{
                            glyphSize: 18
                            glyph: FontIcons.Ionicons.ios_star_outline
                            anchors.centerIn: parent
                        }
                        onClicked: ratingsPopup.open()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        parseRatings( post.ratings );
        post.postMessage = parsePost( JSON.parse(post.message) );
    }

    function parseRatings( ratings ){
        // TODO: console.log( "FIXME: Parse Ratings" );
    }

    function parsePost( json ){
        var message = "";
        json.ops.forEach(function(postMessage) {

            if(postMessage.attributes)
                if(postMessage.attributes.blockquote) //Special case if it's a blockquote
                    message += "[BLOCKQUOTE]\n";
                else
                    message += formatSpecialAttributes( postMessage.attributes, postMessage.insert );

            else if(postMessage.insert.postquote)
                message += "[POST FROM "+ postMessage.insert.postquote.username +"]\n";
            else if(postMessage.insert.hotlink)
                message += "[EMBEDDED OBJECT]\n";
            else if(postMessage.insert.emote)
                message += "EMOTE + " + postMessage.insert.emote;
            else
                message += (postMessage.insert);

        });

        //Do some cleanup
        message = sanitizeMessage(message);

        //God this is awful
        message = message.replace(/\n$/, "");
        message = message.replace(/(?:\n\n)/g, '\n');
        message = message.replace(/(?:\n)/g, '<br><br>');

        return message;
    }

    function formatSpecialAttributes( attributes, message ){
        if(attributes.strike)
            return "<s>" + message + "</s>";
        else if(attributes.bold)
            return "<b>" + message + "</b>";
        else if(attributes.italic)
            return "<i>" + message + "</i>";
        else if(attributes.underline)
            return "<u>" + message + "</u>";
        else if(attributes.spoiler)
            return "<font color=\"#e4e4e4\">" + message + "</font>"; //Todo: reveal when touched
        else if(attributes.link)
            return "<a href=\" " + attributes.link + "\"><font color=\"#ff0000\">" + message + "</font></a>";

        //If not found
        console.warn("Unhandled Special Attribute: " + JSON.stringify(attributes) );
        return "<b>FIX-ME</b>\n";
    }

    function sanitizeMessage(message){
        //TODO
        return message;
    }
}
