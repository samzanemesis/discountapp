import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QtGraphicalEffects 1.0

import NinepunchGlobals 1.0

import "Android"
import "Components"
import "js/fonticons.js" as FontIcons

Page{
    property string threadURL: "https://forum.facepunch.com/f/meta/btjnz/Facepunch-API/1/"
    property string errorType: ""
    property bool useBackButton: false

    id: threadPage

    BusyIndicatorPage{
        id: busyIndicatorPage
        state: threadPage.state
        errorType: threadPage.errorType
    }

    PosterInfoPopup{
        id:posterInfoPopup
    }

    RatingsPopup{
        id:ratingsPopup
    }

    ListModel{
        id: postListModel
    }

    ListView {
        anchors.fill: parent
        model: 1
        id: postView

        header: Item{
            height: parent.width > 768 ? 64 : 0
        }

        delegate:
        Item{
            width: parent.width > 768 ? 768 : parent.width
            height: childrenRect.height

            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                width: parent.width
                id: postContent

                topPadding:  ( -busyIndicatorPage.busyScale + 1 ) * 200 //Fancy effect on page load
                spacing: ( -busyIndicatorPage.busyScale + 1 ) * 200 + ( (parent.width > 512) * 32)
                scale: 1 - (( -busyIndicatorPage.busyScale + 1 ) * 0.1)

                Repeater{
                    model: postListModel
                    delegate: Post{
                        message: Message
                        poster: Username
                        postCountry: Country
                        ratings: Meta.Votes
                    }
                }
                //Infinite scrolling loading indicator
                Item{
                    width: parent.width
                    height: 128
                    Column{
                        anchors.centerIn: parent
                        BusyIndicator { running: true; anchors.horizontalCenter: parent.horizontalCenter }
                        Label { text: "Loading next page..." }
                    }
                }

            }
        }
        ScrollBar.vertical: ScrollBar {}
    }

    //New post button
    CircleButton{
        id: postbutton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        state: tabBar.state
        glyph: FontIcons.Ionicons.edit

        onClicked: {
            tabBar.state = "POSTING";
        }

        states: [
            State { name: "POSTING"
                PropertyChanges {
                    target: postbutton
                    anchors.bottomMargin: -128
                }
            },
            State { name: "READING"
                PropertyChanges {
                    target: postbutton
                    anchors.bottomMargin: 16
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "bottomMargin"
                    duration: 500
                    easing.type: Easing.OutElastic
                    easing.period: 0.9
                }
            }
        ]

    }

    BlurRectangle{
        id: postContainer
        readonly property int widePostingWidth: 512
        readonly property bool isWidePosting: parent.width > widePostingWidth

        anchors.horizontalCenter: parent.horizontalCenter
        width: isWidePosting ? widePostingWidth : parent.width

        height: (postTextContainer.height + 16) * (tabBar.height / tabBar.implicitHeight)
        element: postView

        visible: height > 10

        onWidthChanged: tabBar.visible = !isWidePosting

        clip: true

        //Hack
        Rectangle{
            width: parent.width
            height: 48
            visible: postContainer.isWidePosting
            color: Qt.rgba(Globals.overlayColor.r,Globals.overlayColor.g,Globals.overlayColor.b,0.5)
        }

        Column{
            id:postTextContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 16
            anchors.topMargin: postContainer.isWidePosting ? 0 : 8

            //Wideposting header
            Item{
                width: parent.width
                height: 48
                visible: postContainer.isWidePosting
                PostToolButton {
                    onClicked: {
                        tabBar.state = "READING";
                    }
                    glyph: FontIcons.Ionicons.android_arrow_back
                    useTheme: true
                    anchors.left: parent.left
                }
                GlyphButton {
                    glyph: FontIcons.Ionicons.android_send
                    useTheme: true
                    anchors.right: parent.right
                }
            }

            TextArea {
                id: postTextArea
                placeholderText: qsTr("Comment reply")


                width: parent.width
                height: contentHeight < 100 - 24 ? 100 : contentHeight > 256 ? 256 + 24 : contentHeight + 24 //fixme

                wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
                textFormat: TextEdit.RichText
                selectByMouse: true

                background: Rectangle{

                    height: 2
                    anchors.bottom: parent.bottom;
                    color: parent.focus ? Globals.secondaryColor : "gray"
                }

                textMargin: 0

                color: Globals.isDarkMode ? "white" : "black"
                //textColor: Global.isDarkMode ? "white" : "black"
            }

            //Wideposting footer
            Item{
                width: parent.width
                height: 32
                visible: postContainer.isWidePosting
                RowLayout{
                    width: 256

                    PostToolButton {
                        glyph: FontIcons.Ionicons.quote
                        useTheme: true
                    }
                    PostToolButton {
                        glyph: FontIcons.Ionicons.ios_photos
                        useTheme: true
                    }
                    PostToolButton {
                        glyph: FontIcons.Ionicons.android_film
                        useTheme: true
                    }
                    PostToolButton {
                        glyph: FontIcons.Ionicons.android_attach
                        useTheme: true
                    }
                }
            }

        }



        y: postView.height - height - (isWidePosting * 32) //Hack but needed to avoid further hacks with the blurring
    }

    footer: PostTabBar{
        id: tabBar
    }

    Component.onCompleted: {
        loadThread();
    }

    function loadThread(){
        threadPage.state = "loading";
        busyIndicatorPage.busyScale = 0;
        //console.log( threadURL + "?json=1");
        var jsonurl = threadURL + "?json=1";
        //console.log(jsonurl);
        getData( jsonurl , parseJSON );
    }

    function getData(url, callback) {
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange=function() {
            //console.log("XmlHTTP Status: " + xmlhttp.status);
            if (xmlhttp.readyState == XMLHttpRequest.DONE )
            {
                switch(xmlhttp.status){
                    case 0: //No connection(?)
                        throwError("errorNoConnection");
                        break;
                    case 200: //Successful loading
                        threadPage.state = "finishedLoading";
                        parseJSON(xmlhttp.responseText);
                        console.log("finished");
                        break;
                    case 400:
                        throwError("badRequest");
                        break;
                    case 403:
                        throwError("errorForbidden");
                        break;
                    case 404:
                        throwError("errorThreadNotFound");
                        break;
                    case 503:
                        throwError("errorUnauthorised");
                        break;
                    default: //Unhandled
                        throwError("errorUnknown");
                        break;
                }
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    function parseJSON( json ){
        var threadContent = JSON.parse( json )
        console.log( threadContent );
        console.log( threadContent.Thread.Name )

        threadPage.title = threadContent.Thread.Name;

        threadContent.Posts.forEach(function(post) {
            //console.log( JSON.stringify(element) );
            var userName = post.Username;
            var message = JSON.parse(post.Message);
            postListModel.append( post );
        });
    }

    function throwError(errorType){
        threadPage.state = "error";
        threadPage.errorType = errorType;
        threadPage.title = errorType;
    }
}
