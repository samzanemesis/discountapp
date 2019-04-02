import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

FastBlur {
    property Item element
    property color color: Globals.backgroundColor

    property int offsetX: 0
    property int offsetY: 0

    property bool live: true

    property bool useRGBA: false

    id: fastBlur
    radius: 64
    opacity: 1

    cached: true

    Rectangle{
        anchors.fill: parent;
        color: parent.color
        opacity: 0.6
    }

    source: ShaderEffectSource {
        sourceItem: element
        sourceRect: Qt.rect( fastBlur.x + fastBlur.offsetX,
                             fastBlur.y + fastBlur.offsetY,
                             fastBlur.width,
                             fastBlur.height )
        textureSize: Qt.size( fastBlur.width * 0.2, fastBlur.height *0.2 )
        mipmap: false
        format: fastBlur.useRGBA ? ShaderEffectSource.RGBA : ShaderEffectSource.RGB
        live: fastBlur.visible && fastBlur.live
    }

    Rectangle{
        anchors.fill: parent;
        color: parent.color
        z:-1
        visible: fastBlur.useRGBA
    }
}
