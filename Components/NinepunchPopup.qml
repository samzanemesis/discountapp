import QtQuick 2.6
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../Android"
import "../js/fonticons.js" as FontIcons

Popup {
    id: popupRoot

    width: 256
    height: 256

    x: (parent.width - width) /2
    y: (parent.height - height) /2

    default property alias contents: placeholder.data

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    background: Item{}

    Rectangle{
        id: mask
        width: parent.width
        height: parent.height
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

        radius: 128

        offsetX: popupRoot.x
        offsetY: popupRoot.y + 13

        Item{
            anchors.fill: parent
            id: placeholder
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
        samples: 10
        color: "#40000000"
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
