import QtQuick 2.0
import QtQuick.Controls 2.2

import NinepunchGlobals 1.0

import "../Components"
import "SettingsPage"

Page {
    property bool useBackButton: true
    title: "Settings"

    FloatingCard{

        SettingsPageHeaderLabel{ headerLabel: "My pinned threads" }
        SideBarElement{ text: "Fat fuck takara" }
    }

}
