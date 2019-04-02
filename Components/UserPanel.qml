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
    id: userPanel
    width: 256
    height: parent.height
    element: stackView
    z: 9999
    state: "CLOSED"

    visible: x < parent.width

    radius: 127

    //color: Globals.mainColor

    //Close other panel if this state changed to open
    onStateChanged: if(state === "OPEN") sidePanel.state = "CLOSED";

    states: [
        State { name: "OPEN"
            PropertyChanges {
                target: userPanel
                x: parent.width - width
            }
            PropertyChanges {
                target: dimmer
                opacity: 0.25
            }
        },
        State { name: "CLOSED"
            PropertyChanges {
                target: userPanel
                x: parent.width
            }
            PropertyChanges {
                target: dimmer
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                properties: "x,opacity"
                duration: 500
                easing.type: Easing.OutExpo
                easing.period: 0.9
            }

        }
    ]

    //Cheap shadow
    LinearGradient{
        start: Qt.point(width, 0)
        end: Qt.point(0, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.05) }
            GradientStop { position: 1.0; color: "transparent" }
        }
        anchors.right: parent.left
        width: 16
        height: parent.height
    }

    //WTF
    Rectangle{
        id: dimmer
        anchors.right: parent.left
        height: parent.height
        width: stackView.width

        color: "black"

        MouseArea{
            anchors.fill: parent
            onClicked: userPanel.state = "CLOSED"
        }
    }

}


