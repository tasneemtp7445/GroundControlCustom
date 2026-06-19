import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

ToolIndicatorPage {
    id: root

    property real _toolButtonHeight: ScreenTools.defaultFontPixelHeight * 3

    contentComponent: Component {
        RowLayout {
            spacing: ScreenTools.defaultFontPixelWidth

            SubMenuButton {
                objectName: "toolbar_viewFly"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Launch")
                imageResource: "/res/FlyingPaperPlane.svg"
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.closeIndicatorDrawer()
                        mainWindow.showFlyView()
                    }
                }
            }

            SubMenuButton {
                objectName: "toolbar_viewPlan"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Plan")
                imageResource: "/qmlimages/Plan.svg"
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.closeIndicatorDrawer()
                        mainWindow.showPlanView()
                    }
                }
            }

            SubMenuButton {
                objectName: "toolbar_viewInspect"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Inspect")
                imageResource: "/qmlimages/Analyze.svg"
                visible: QGroundControl.corePlugin.showAdvancedUI
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.closeIndicatorDrawer()
                        mainWindow.showAnalyzeTool()
                    }
                }
            }

            SubMenuButton {
                id: setupButton
                objectName: "toolbar_viewConfigure"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Configure")
                imageResource: "/res/GearWithPaperPlane.svg"
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.closeIndicatorDrawer()
                        mainWindow.showVehicleConfig()
                    }
                }
            }

            SubMenuButton {
                id: settingsButton
                objectName: "toolbar_viewSettings"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Settings")
                imageResource: "/res/QGCLogoWhite.svg"
                visible: !QGroundControl.corePlugin.options.combineSettingsAndSetup
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.closeIndicatorDrawer()
                        mainWindow.showSettingsTool()
                    }
                }
            }

            SubMenuButton {
                id: closeButton
                objectName: "toolbar_viewClose"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Close")
                imageResource: "/res/OpenDoor.svg"
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        mainWindow.finishCloseProcess()
                    }
                }
            }
            SubMenuButton {
                id: infoButton
                objectName: "toolbar_info"
                implicitHeight: root._toolButtonHeight

                text: qsTr("Info")
                imageResource: "/res/OpenDoor.svg"
                onClicked: {
                    if (mainWindow.allowViewSwitch()) {
                        indifloInfoDialog.open()
                    }
                }
            }

            ColumnLayout {
                id: versionColumnLayout
                Layout.fillWidth: true
                Layout.columnSpan: 2
                spacing: 0

                QGCLabel {
                    id: versionLabel
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("%1 Version").arg(QGroundControl.appName)
                    font.pointSize: ScreenTools.smallFontPointSize
                    wrapMode: QGCLabel.WordWrap
                }

                QGCLabel {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: QGroundControl.qgcVersion
                    font.pointSize: ScreenTools.smallFontPointSize
                    wrapMode: QGCLabel.WrapAnywhere
                }

                QGCLabel {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: QGroundControl.qgcAppDate
                    font.pointSize: ScreenTools.smallFontPointSize
                    wrapMode: QGCLabel.WrapAnywhere
                    visible: QGroundControl.qgcDailyBuild

                    QGCMouseArea {
                        anchors.topMargin: -(parent.y - versionLabel.y)
                        anchors.fill: parent

                        onClicked: (mouse) => {
                                       if (mouse.modifiers & Qt.ControlModifier) {
                                           QGroundControl.corePlugin.showTouchAreas = !QGroundControl.corePlugin.showTouchAreas
                                           showTouchAreasNotification.open()
                                       } else if (ScreenTools.isMobile || mouse.modifiers & Qt.ShiftModifier) {
                                           mainWindow.closeIndicatorDrawer()
                                           if (!QGroundControl.corePlugin.showAdvancedUI) {
                                               advancedModeOnConfirmation.open()
                                           } else {
                                               advancedModeOffConfirmation.open()
                                           }
                                       }
                                   }

                        // This allows you to change this on mobile
                        onPressAndHold: {
                            QGroundControl.corePlugin.showTouchAreas = !QGroundControl.corePlugin.showTouchAreas
                            showTouchAreasNotification.open()
                        }
                    }
                }

            }
            QGCPopupDialog {
                id: indifloInfoDialog

                title: qsTr("About IndiFlo")

                ColumnLayout {

                    spacing: 10

                    QGCLabel {
                        text: qsTr("IndiFlo Ground Control Station")
                        font.pointSize: ScreenTools.defaultFontPointSize
                    }

                    QGCLabel {
                        text: qsTr("Company: IndiFlo Private Limited")
                    }

                    QGCLabel {
                        text: qsTr("Application: IndiFlo Ground Control")
                    }

                    QGCLabel {
                        text: qsTr("Version:1.0 ") + QGroundControl.qgcVersion
                    }

                    QGCLabel {
                        text: qsTr("Developed for UAV Operations")
                    }

                    QGCLabel {
                        text: qsTr("Contact: support@indiflo.com")
                    }
                }
            }
        }
    }

}