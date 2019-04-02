import QtQuick 2.6
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../Android"
import "../js/fonticons.js" as FontIcons

Popup {
    id: popupRoot

    width: mask.width
    height: mask.height

    x: (parent.width - width) /2
    y: (parent.height - height) /2

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    background: Item{}

    Rectangle{
        id: mask
        width: 256
        height: 400
        radius: 24
        visible: false
    }

    //A bit way too expensive with BlurRectangle
    BlurRectangle{
        id: popup
        anchors.fill: mask
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        element: postView

        //color: "Red"

        live: state === "STOCK"

        radius: 128

        offsetX: popupRoot.x
        offsetY: popupRoot.y + 13

        state: "STOCK"

        states: [
            State { name: "STOCK"
                PropertyChanges {
                    target: mask
                    height: 400
                }
                PropertyChanges {
                    target: avatarBackground
                    height: 96
                }
                PropertyChanges {
                    target: avatar
                    opacity: 1
                }
            },
            State { name: "EXTEND"
                PropertyChanges {
                    target: mask
                    height: 512
                }
                PropertyChanges {
                    target: avatarBackground
                    height: mask.height
                }
                PropertyChanges {
                    target: avatar
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "height,opacity"
                    duration: 500
                    easing.type: Easing.OutExpo
                    easing.period: 0.9
                }
            }
        ]


        Item{
            id: avatarBackground

            width: parent.width
            height: 96
            Image{
                source: "https://files.facepunch.com/forum/upload/718/f3f0f47c-26dc-4459-aa5f-f67fb9fe2af0/WhatTheFuckDidYouJustFuckingSayAboutMeYouLittleBitchIllHaveYouKnowIGraduatedTopOfMyClassInTheNavySeals.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                clip: true
                z:-1
            }
            MouseArea{
                anchors.fill: parent
                onClicked: popup.state = "EXTEND"
            }

            //Close button
            ToolButton{
                anchors.top: parent.top
                anchors.right: parent.right
                visible: popup.state === "STOCK"
                onClicked: popupRoot.close()

                FontIcon{
                    color: "white"
                    anchors.centerIn: parent
                    glyph: FontIcons.Ionicons.android_close
                    fontFamily: "IonIcons"
                }
            }
            ToolButton{
                anchors.top: parent.top
                anchors.left: parent.left
                onClicked: popup.state = "STOCK"
                visible: popup.state === "EXTEND"

                FontIcon{
                    color: "white"
                    anchors.centerIn: parent
                    glyph: FontIcons.Ionicons.ios_arrow_back
                    fontFamily: "IonIcons"
                }
            }
        }

        //Avatar
        Rectangle{
            id: avatar
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

            anchors.top: avatarBackground.bottom
            anchors.topMargin: -height*0.5
            anchors.horizontalCenter: parent.horizontalCenter
        }



        //Subtle transition effect
        transform: Rotation {
            origin.x: popup.width /2;
            origin.y: popup.height /2;
            axis {
                x: 1;
                y: 0;
                z: 0
            }
            angle: (popupRoot.scale - 1) * 300
        }
    }

    DropShadow {
        anchors.fill: mask
        horizontalOffset: 0
        verticalOffset: 30
        radius: 50
        samples: 20
        color: "#80000000"
        source: mask
        z:-3
        transform: Rotation {
            origin.x: popup.width /2;
            origin.y: popup.height /2;
            axis {
                x: 1;
                y: 0;
                z: 0
            }
            angle: (popupRoot.scale - 1) * 300
        }
    }

    //Animation
    enter: Transition {
        NumberAnimation {
            property: "y"; from: parent.height*2; to: (parent.height - height) /2
            duration: 500
            easing.type: Easing.OutExpo
        }

        NumberAnimation {
            property: "scale"; from: 1.15; to: 1
            easing.type: Easing.OutSine
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "y"; from: (parent.height - height) /2; to: parent.height*2
            easing.type: Easing.InSine
        }
        NumberAnimation {
            property: "scale"; from: 1; to: 0.9
            easing.type: Easing.OutSine
        }
    }
}
