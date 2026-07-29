import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import Qt5Compat.GraphicalEffects

Item {
    id: root

    width: 1600
    height: 900

    property string notificationMessage

    // Base resolution is 1080p.
    property real uiScale: Math.max(0.6, root.height / 1080)

    LayoutMirroring.enabled: Application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    // -----------------------------
    // CUSTOM FONTS
    // -----------------------------
    FontLoader {
        id: titleFont
        source: "fonts/Cinzel-Regular.ttf"
    }
    
    FontLoader {
        id: elegantFont
        source: "fonts/EBGaramond-Regular.ttf"
    }

    // -----------------------------
    // WAYLAND WALLPAPER SCAFFOLDING
    // -----------------------------
    Item {
        id: wallpaper
        anchors.fill: parent
        Repeater {
            model: screenModel

            Image {
                x: geometry.x
                y: geometry.y
                width: geometry.width
                height: geometry.height
                source: config.background
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
            }
        }
    }

    // Reusable DropShadow
    Component {
        id: shadowEffect
        DropShadow {
            horizontalOffset: 0
            verticalOffset: Math.round(2 * root.uiScale)
            radius: Math.round(10 * root.uiScale)
            samples: 21
            color: "#d9000000"
        }
    }

    // -----------------------------
    // FRIEREN CUSTOM LEFT ALIGNED LAYOUT
    // -----------------------------
    Item {
        id: leftContainer
        anchors.left: parent.left
        anchors.leftMargin: Math.round(120 * uiScale)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: Math.round(400 * uiScale)
        
        Behavior on opacity {
            OpacityAnimator { duration: 250 }
        }

        // -----------------------------
        // MAIN UNIFIED STACK
        // -----------------------------
        Column {
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: Math.round(-40 * uiScale)
            width: parent.width
            spacing: Math.round(10 * uiScale)

            // Logo Title
            Text {
                text: "F R I E R E N"
                color: "white"
                font.pixelSize: Math.round(64 * uiScale)
                font.family: titleFont.name
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
            }
            // Logo Subtitle
            Text {
                text: "Beyond Journey's End"
                color: "white"
                font.pixelSize: Math.round(18 * uiScale)
                font.family: elegantFont.name
                font.letterSpacing: 2.0
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
            }

            // Spacer
            Item { width: 1; height: Math.round(15 * uiScale) }

            // Clock
            Text {
                id: timeText
                color: "white"
                font.pixelSize: Math.round(130 * uiScale)
                font.family: elegantFont.name
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
                
                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: timeText.text = Qt.formatTime(new Date(), "HH:mm")
                }
                Component.onCompleted: timeText.text = Qt.formatTime(new Date(), "HH:mm")
            }

            // Date
            Text {
                id: dateText
                color: "white"
                font.pixelSize: Math.round(24 * uiScale)
                font.family: elegantFont.name
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
                
                Timer {
                    interval: 60000; running: true; repeat: true
                    onTriggered: dateText.text = Qt.formatDate(new Date(), "dddd dd MMMM")
                }
                Component.onCompleted: dateText.text = Qt.formatDate(new Date(), "dddd dd MMMM")
            }

            // Spacer before inputs
            Item { width: 1; height: Math.round(30 * uiScale) }

            // Floating Power & Restart Icons
            Row {
                anchors.left: parent.left
                anchors.leftMargin: Math.round(20 * uiScale)
                spacing: Math.round(25 * uiScale)

                Text {
                    text: "⏻"
                    color: "white"
                    font.pixelSize: Math.round(22 * uiScale)
                    layer.enabled: true
                    layer.effect: shadowEffect
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: sddm.powerOff()
                    }
                }

                Text {
                    text: "↻"
                    color: "white"
                    font.pixelSize: Math.round(22 * uiScale)
                    font.bold: true
                    layer.enabled: true
                    layer.effect: shadowEffect
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: sddm.reboot()
                    }
                }
            }

            // Username Pill Field
            Rectangle {
                width: parent.width
                height: Math.round(48 * uiScale)
                radius: Math.round(24 * uiScale)
                color: "#1affffff"
                border.color: "#66ffffff"
                border.width: Math.round(1.5 * uiScale)

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Math.round(15 * uiScale)
                    anchors.rightMargin: Math.round(15 * uiScale)
                    spacing: Math.round(12 * uiScale)

                    Rectangle {
                        width: Math.round(26 * uiScale)
                        height: Math.round(26 * uiScale)
                        radius: Math.round(13 * uiScale)
                        color: "#40ffffff"
                        Text { text: "👤"; color: "white"; font.pixelSize: Math.round(14 * uiScale); anchors.centerIn: parent }
                    }

                    TextInput {
                        id: usernameField
                        text: userModel.lastUser
                        color: "white"
                        font.pixelSize: Math.round(16 * uiScale)
                        font.family: elegantFont.name
                        font.capitalization: Font.AllUppercase
                        Layout.fillWidth: true
                        clip: true
                    }

                    Text {
                        text: "⚙"
                        color: "white"
                        font.pixelSize: Math.round(18 * uiScale)
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            // Password Pill Field
            Rectangle {
                width: parent.width
                height: Math.round(48 * uiScale)
                radius: Math.round(24 * uiScale)
                color: "#1affffff"
                border.color: passwordField.text === "" && root.notificationMessage !== "" ? "#ff4444" : "#66ffffff"
                border.width: Math.round(1.5 * uiScale)

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Math.round(15 * uiScale)
                    anchors.rightMargin: Math.round(15 * uiScale)
                    spacing: Math.round(12 * uiScale)

                    Rectangle {
                        width: Math.round(26 * uiScale)
                        height: Math.round(26 * uiScale)
                        radius: Math.round(13 * uiScale)
                        color: "#40ffffff"
                        Text { text: "🔑"; color: "white"; font.pixelSize: Math.round(14 * uiScale); anchors.centerIn: parent }
                    }

                    TextInput {
                        id: passwordField
                        color: "white"
                        font.pixelSize: Math.round(18 * uiScale)
                        echoMode: TextInput.Password
                        focus: true
                        Layout.fillWidth: true
                        clip: true
                        onAccepted: sddm.login(usernameField.text, passwordField.text, sessionBox.currentIndex)
                    }
                }
            }

            // Spacer
            Item { width: 1; height: Math.round(10 * uiScale) }

            // Centered Login Button
            Text {
                text: root.notificationMessage !== "" ? "LOGIN FAILED" : "LOG IN"
                color: root.notificationMessage !== "" ? "#ff4444" : "white"
                font.pixelSize: Math.round(16 * uiScale)
                font.bold: true
                font.family: elegantFont.name
                font.letterSpacing: 1.5
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.login(usernameField.text, passwordField.text, sessionBox.currentIndex)
                }
            }
        }

        // BOTTOM SECTION: Centered Session Info
        Column {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Math.round(40 * uiScale)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Math.round(8 * uiScale)

            Text { 
                id: sessionText
                color: "white"
                font.pixelSize: Math.round(11 * uiScale)
                font.family: "sans-serif"
                text: "SESSION: " + (sessionBox.currentText !== "" ? sessionBox.currentText : "DEFAULT")
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (sessionBox.count > 0) {
                            sessionBox.currentIndex = (sessionBox.currentIndex + 1) % sessionBox.count
                        }
                    }
                }
            }
            
            QQC2.ComboBox { 
                id: sessionBox
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
                visible: false 
            }

            Text { 
                text: "VIRTUAL KEYBOARD (OFF)"
                color: "#ccffffff"
                font.pixelSize: Math.round(11 * uiScale)
                font.family: "sans-serif"
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: shadowEffect
            }
        }
    }

    // -----------------------------
    // SDDM BACKEND CONNECTIONS
    // -----------------------------
    Connections {
        target: sddm
        function onLoginFailed() {
            root.notificationMessage = "Login Failed"
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
        function onLoginSucceeded() {
            leftContainer.opacity = 0
        }
    }

    onNotificationMessageChanged: {
        if (notificationMessage) {
            notificationResetTimer.start();
        }
    }

    Timer {
        id: notificationResetTimer
        interval: 3000
        onTriggered: root.notificationMessage = ""
    }
}
