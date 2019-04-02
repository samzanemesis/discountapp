import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import NinepunchGlobals 1.0

import "../js/fonticons.js" as FontIcons
import "../Components"

Button{
    property var glyph : FontIcons.Ionicons.person_add
    FontIcon{
        glyph: parent.glyph

        anchors.centerIn: parent
        color: "white"
    }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: 64
        color: Globals.secondaryColor
        radius: width / 2

        opacity: parent.pressed ? 0.7 : 1.0

        layer.enabled: parent.enabled
        layer.effect: DropShadow {
            verticalOffset: 3
            color: Material.dropShadowColor
            samples: 10
            spread: 0
            radius: 8
        }
    }


}
