import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import NinepunchGlobals 1.0

import "../js/fonticons.js" as FontIcons

Text {
    property string fontFamily : "IonIcons"
    property var glyph : FontIcons.Ionicons.person_add
    property var glyphSize: 14

    verticalAlignment: Text.AlignVCenter
    font.pointSize: glyphSize
    font.family: fontFamily
    text: glyph
    opacity: 0.75

    color: Globals.isDarkMode ? "white" : "black"
}
