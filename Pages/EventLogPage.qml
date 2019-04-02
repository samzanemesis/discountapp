import QtQuick 2.0
import QtQuick.Controls 2.2

import NinepunchGlobals 1.0

import "../Components"
import "SettingsPage"

Page {
    property bool useBackButton: true
    title: "Event Log"

    FloatingCard{

        SettingsPageHeaderLabel{ headerLabel: "Event Log" }
    }

}
