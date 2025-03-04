import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Effects
import SddmComponents 2.0
import "."

Rectangle {
    id: container
    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    property int sessionIndex: session.index
    property date dateTime: new Date()


    TextConstants {
        id: textConstants
    }

    Connections {
        target: sddm
        function onLoginSucceeded() {
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#ff3333"
            errorMessage.text = textConstants.loginFailed
        }
    }

    FontLoader {
        id: myFontNormal
        source: "./assets/Croissant_One/CroissantOne-Regular.ttf"
    }

    Image {
        id: behind
        anchors.fill: parent
         source: config.background
         fillMode: Image.Stretch
         onStatusChanged: {
             if (config.type === "color") {
                 source = config.defaultBackground
             }
         }
    }

    MultiEffect {
        source: behind
        anchors.fill: behind
        brightness: -0.2
        contrast: -0.4
        blurEnabled: true
        blurMax: 32
        blur: 0.8
    }

    ColumnLayout{
        id: centerBox
        anchors.centerIn: parent
        spacing: 24

            Rectangle {
                color: "#33f2f2f2"
                // radius: 18
                width: 360
                height: 38

                TextField {
                    id: nameinput
                    focus: true
                    anchors.fill: parent
                    text: userModel.lastUser
                    font.family: myFontNormal.name
                    font.bold: true
                    font.pointSize: 11
                    leftPadding: 16
                    color: "white"
                    selectionColor: "#454545"

                    background: Rectangle {
                        id: textback
                        color: "#33f2f2f2"
                        // radius: 18

                        states: [
                            State {
                                name: "yay"
                                PropertyChanges {
                                    target: textback
                                    opacity: 1
                                }
                            },
                            State {
                                name: "nay"
                                PropertyChanges {
                                    target: textback
                                    opacity: 0
                                }
                            }
                        ]

                        transitions: [
                            Transition {
                                to: "yay"
                                NumberAnimation {
                                    target: textback
                                    property: "opacity"
                                    from: 0
                                    to: 1
                                    duration: 200
                                }
                            },

                            Transition {
                                to: "nay"
                                NumberAnimation {
                                    target: textback
                                    property: "opacity"
                                    from: 1
                                    to: 0
                                    duration: 200
                                }
                            }
                        ]
                    }

                    KeyNavigation.tab: password
                    KeyNavigation.backtab: password

                    Keys.onPressed: (event)=> {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                        }
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            textback.state = "yay"
                        } else {
                            textback.state = "nay"
                        }
                    }
                }
            }

            Rectangle {
                color: "#33f2f2f2"
                // radius: 18
                width: 360
                height: 38

                TextField {
                    id: password
                    anchors.fill: parent
                    font.family: myFontNormal.name
                    font.pointSize: 11
                    leftPadding: 16
                    echoMode: TextInput.Password
                    color: "white"
                    selectionColor: "#454545"
                    placeholderText: "password"
                    placeholderTextColor: "#66f2f2f2"

                    background: Rectangle {
                        id: textback1
                        color: "#33f2f2f2"
                        // radius: 18

                        states: [
                            State {
                                name: "yay1"
                                PropertyChanges {
                                    target: textback1
                                    opacity: 1
                                }
                            },
                            State {
                                name: "nay1"
                                PropertyChanges {
                                    target: textback1
                                    opacity: 0
                                }
                            }
                        ]

                        transitions: [
                            Transition {
                                to: "yay1"
                                NumberAnimation {
                                    target: textback1
                                    property: "opacity"
                                    from: 0
                                    to: 1
                                    duration: 200
                                }
                            },

                            Transition {
                                to: "nay1"
                                NumberAnimation {
                                    target: textback1
                                    property: "opacity"
                                    from: 1
                                    to: 0
                                    duration: 200
                                }
                            }
                        ]
                    }

                    KeyNavigation.tab: nameinput
                    KeyNavigation.backtab: nameinput

                    Keys.onPressed: (event)=> {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(nameinput.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            textback1.state = "yay1"
                        } else {
                            textback1.state = "nay1"
                        }
                    }
                }
            }

        Image {
            id: loginButton
            source: "assets/buttonup.svg"
            Layout.alignment: Qt.AlignRight

            property string toolTipText3: textConstants.login
            ToolTip.text: toolTipText3
            ToolTip.delay: 500
            ToolTip.visible: toolTipText3 ? ma3.containsMouse : false

            MouseArea {
                id: ma3
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.source = "assets/buttonhover.svg"
                }
                onExited: {
                    parent.source = "assets/buttonup.svg"
                }
                onPressed: {
                    parent.source = "assets/buttondown.svg"
                    sddm.login(nameinput.text, password.text, sessionIndex)
                }
                onReleased: {
                    parent.source = "assets/buttonup.svg"
                }
            }
        }
    } //columnlayout



    ComboBox {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        anchors.left: centerBox.left
        anchors.leftMargin: 9
        id: session
        color: "#3b3749"
        hoverColor: "#a1a1a1"
        textColor: "#f7f7f7"
        menuColor: "#565658"
        width: 224
        height: 28
        font.pointSize: 9
        font.family: myFontNormal.name
        arrowBox: "assets/comboarrow.svg"
        backgroundNormal: "assets/cbox.svg"
        backgroundHover: "assets/cboxhover.svg"
        backgroundPressed: "assets/cboxhover.svg"
        model: sessionModel
        index: sessionModel.lastIndex
        KeyNavigation.backtab: password
        KeyNavigation.tab: nameinput
    }



    Image {
        id: shutdownButton
        source: "assets/shutdown.svg"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        anchors.right: centerBox.right
        anchors.rightMargin: 9
        width: 28
        height: 28

        property string toolTipText1: textConstants.shutdown
        ToolTip.text: toolTipText1
        ToolTip.delay: 500
        ToolTip.visible: toolTipText1 ? ma1.containsMouse : false

        MouseArea {
            id: ma1
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.source = "assets/shutdownhover.svg"
            }
            onExited: {
                parent.source = "assets/shutdown.svg"
            }
            onPressed: {
                parent.source = "assets/shutdownpressed.svg"
                sddm.powerOff()
            }
            onReleased: {
                parent.source = "assets/shutdown.svg"
            }
        }
    }

    Image {
        id: rebootButton
        source: "assets/reboot.svg"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        anchors.right: shutdownButton.left
        anchors.rightMargin: 28
        width: 28
        height: 28

        property string toolTipText2: textConstants.reboot
        ToolTip.text: toolTipText2
        ToolTip.delay: 500
        ToolTip.visible: toolTipText2 ? ma2.containsMouse : false

        MouseArea {
            id: ma2
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.source = "assets/reboothover.svg"
            }
            onExited: {
                parent.source = "assets/reboot.svg"
            }
            onPressed: {
                parent.source = "assets/rebootpressed.svg"
                sddm.reboot()
            }
            onReleased: {
                parent.source = "assets/reboot.svg"
            }
        }
    }

    Component.onCompleted: {
        nameinput.focus = true
        textback1.state = "nay1" //dunno why both inputs get focused
    }
}
