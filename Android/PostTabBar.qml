import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

import "../Components"
import "../js/fonticons.js" as FontIcons

ToolBar{
    anchors.left: parent.left
    anchors.right: parent.right
    state: "READING"
    z: 999999
    background: Rectangle{
        anchors.fill: parent
        color: Globals.secondaryColor
    }

    RowLayout{
        Layout.alignment: Qt.AlignHCenter
        anchors.fill: parent
        PostToolButton {
            onClicked: {
                tabBar.state = "READING";
            }
            glyph: FontIcons.Ionicons.android_arrow_back
        }
        PostToolButton {
            glyph: FontIcons.Ionicons.quote
        }
        PostToolButton {
            glyph: FontIcons.Ionicons.ios_photos
        }
        PostToolButton {
            glyph: FontIcons.Ionicons.android_film
        }
        PostToolButton {
            glyph: FontIcons.Ionicons.android_attach
        }
        PostToolButton {
            glyph: FontIcons.Ionicons.android_send
        }
    }
    states: [
        State { name: "POSTING"
            PropertyChanges {
                target: tabBar
                height: implicitHeight
            }
        },
        State { name: "READING"
            PropertyChanges {
                target: tabBar
                height: 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                properties: "height"
                duration: 500
                easing.type: Easing.OutBack
            }
        }
    ]
}
