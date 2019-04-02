import QtQuick 2.0
import QtQuick.Controls 2.2

MouseArea{
    property string icon
    property string name
    property string channelid
    id: channelButton
    width: parent.width
    height: 52

    Component.onCompleted: {console.log(channelButton.icon)}
    Image{
        id: channelBadge
        width: 48
        height: width
        //radius: height/2
        anchors.centerIn: parent
        //color: "transparent"
        clip: true

        source: Qt.resolvedUrl( channelButton.icon )
        property bool rounded: true
        property bool adapt: true
        property real radius: 1

        layer.enabled: rounded
        //MAKE THIS SHADER LOOK BETTER
        layer.effect: ShaderEffect {
            property real adjustX: channelBadge.radius
            property real adjustY: channelBadge.radius

            fragmentShader: "
            #ifdef GL_ES
                precision lowp float;
            #endif // GL_ES
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform lowp sampler2D source;
            uniform lowp float adjustX;
            uniform lowp float adjustY;

            float roundCorners(vec2 p, vec2 b, float r)
            {
                return length(max(abs(p)-b+r,0.0))-r;
            }

            void main(void) {
                lowp float x, y;
                x = (qt_TexCoord0.x - 0.5) * adjustX;
                y = (qt_TexCoord0.y - 0.5) * adjustY;
                float delta = adjustX != 1.0 ? fwidth(y) / 2.0 : fwidth(x) / 2.0;
                /*gl_FragColor = texture2D(source, qt_TexCoord0).rgba
                    * step(x * x + y * y, 0.25)
                    * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
                    * qt_Opacity;*/
                gl_FragColor = vec4(1.0,1.0,1.0,1.0) * udRoundBox(vec(x,y),vec2(adjustX,adjustY),1);
            }"
        }

        states: [
            State { name: "SQUARE"
                PropertyChanges {
                    target: channelBadge
                    radius: 0.8
                }
            },
            State { name: "CIRCLE"
                PropertyChanges {
                    target: channelBadge
                    radius: 1
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    properties: "radius"
                    duration: 500
                    easing.type: Easing.OutExpo
                    easing.period: 0.9
                }
            }
        ]
    }

    hoverEnabled: true
    onEntered: { channelBadge.state = "SQUARE"; messageTick.state = "OPEN" }
    onExited: { channelBadge.state = "CIRCLE"; messageTick.state = "CLOSED" }




    //New messages tick
    Rectangle{
        id: messageTick
        width: 10
        height: 10
        radius: width/2
        anchors.verticalCenter: parent.verticalCenter
        x: -(width/2)
        color: "gray"

        states: [
            State { name: "OPEN"
                PropertyChanges {
                    target: messageTick
                    height: 32
                }
            },
            State { name: "CLOSED"
                PropertyChanges {
                    target: messageTick
                    height: width
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "height"
                    duration: 500
                    easing.type: Easing.OutExpo
                    easing.period: 0.9
                }
            }
        ]
    }

    //Mentioned message badge
    Rectangle{
        anchors{
            right: channelBadge.right
            bottom: channelBadge.bottom

        }
        width: 16
        height: 14
        color: "#F26144"
        radius: 2
        Label{
            anchors.centerIn: parent;
            text: "2"
            font.pixelSize: 7
            font.weight: Font.Bold
            color: "white"
        }
    }
}
