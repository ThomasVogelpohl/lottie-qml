

import QtQuick 2.10
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import "./." as Lottie
import "script.js" as MyScript

Window {
    id: root

    width: 800
    height: 600
    title: "Lottie Tester"
    visible: true

    property int countLoader: 0

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: undefined

        onStatusChanged: {
            // console.log("Lottie - loader.status: " + loader.status + " - count: " + countLoader)
            if (loader.status === Loader.Ready) {
                countLoader = countLoader + 1
                console.log("Loader - Loader.Ready")
            } else if(loader.status === Loader.Null) {
               gc()
                console.log("Loader - Loader Null")


            } else {
                console.log("Loader - Unhandled status: " + loader.status)
            }
        }
    }

    Timer {
        id: triggerTimer
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            if (countLoader >= 200) {
                triggerTimer.running = false
                loader.sourceComponent = undefined
                
                gc()
//                Qt.quit();
            } else {

                if (loader.sourceComponent != undefined) {
                    loader.sourceComponent = undefined
                    console.log("Timer unload")
                } else {
                    loader.sourceComponent =  animationArea // animationAreaTest
                    console.log("Timer load")
                }
            }
        }
    }

    Component {
        id: animationArea
        Item {
            width: 800
            height: 600

            Item {
                id: animBackground
                width: 0.65 * parent.width
                height: parent.height - 0.1175 * root.width //0.65 * parent.height
                //anchors.centerIn: parent
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Lottie.LottieAnimation {
                    anchors.fill: parent
                    id: lottieAnim
                    objectName: "AnimationLottie.qml"

                    running: true
                    clearBeforeRendering: true
                    speed: 1.0
                    loops: Animation.Infinite
                    fillMode: Image.PreserveAspectFit
                    reverse: false

                    renderTarget: Canvas.FramebufferObject
                    renderStrategy: Canvas.Cooperative

                    source: "qrc:/lottieFiles/material_wave_loading.json"
                }
            }
        }
    }


    Component {
        id: animationAreaTest
        Item {
            width: 800
            height: 600

            Rectangle {
                id: animBackground
                width: 0.65 * parent.width
                height: parent.height - 0.1175 * root.width //0.65 * parent.height
                //anchors.centerIn: parent
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "blue"
                radius: 3

                Component.onCompleted: {
                    MyScript.showCalculations(10)
                }

                Component.onDestruction: {
                    MyScript.deleteFactorial()
                }
                
            }
        }
    }
}
