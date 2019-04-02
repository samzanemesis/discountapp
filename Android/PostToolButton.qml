import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

import "../js/fonticons.js" as FontIcons
import "../Components"

ToolButton {
    property var glyph : FontIcons.Ionicons.person_add
    property var glyphOpacity: useTheme? 1 : 0.75
    property string fontFamily: "IonIcons"
    property int glyphSize: 18
    property bool useTheme: false;

    implicitWidth: implicitHeight
    text: qsTr("­­")
    FontIcon{
        color: useTheme ? (Globals.secondaryColor ) :"white"
        anchors.centerIn: parent
        glyph: parent.glyph
        glyphSize: parent.glyphSize
        opacity: glyphOpacity
        fontFamily: parent.fontFamily
    }
}
