import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import NinepunchGlobals 1.0

Rectangle{
    property real busyScale : 0
    property string errorType: "Unspecified Error"
    anchors.fill: parent

    id: busyIndicatorPage
    BusyIndicator {
        running: opacity != 0
        anchors.centerIn: parent
        visible: opacity != 0 && parent.state !== "error"

        scale: parent.busyScale * 20 + 1
    }
    z: 999999

    visible: opacity == 0.0 ? false : true

    color: Globals.deeperBackgroundColor

    ParallelAnimation{
        running: state === "finishedLoading"
        NumberAnimation { target: busyIndicatorPage; property: "opacity"; to: 0.0; duration: 300}
        NumberAnimation { target: busyIndicatorPage; property: "busyScale"; easing.type: Easing.OutCubic; to: 1.0; duration: 600;}
    }

    Column{
        anchors.centerIn: parent
        spacing: 16
        anchors.horizontalCenter: parent.horizontalCenter

        visible: parent.state === "error"
        Rectangle{
            width: 128
            height: width
            color: Globals.overlayColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label{
            text: busyIndicatorPage.errorType
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button{
            text: "Reload"
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                threadPage.loadThread();
            }
        }
    }

}
