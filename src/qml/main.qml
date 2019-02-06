

import QtQuick 2.10
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import "./." as Lottie

Window {
    id: root

    width: 800
    height: 600
    title: "Lottie Tester"
    visible: true

    property int countLoader: value

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: animationArea

        onStatusChanged: {
            console.log("Lottie - loader.status: " + loader.status + " - count: " + countLoader)
            if (loader.status === Loader.Ready)
                countLoader = countLoader + 1
        }
    }

    Timer {
        id: triggerTimer
        interval: 400
        running: true
        repeat: true
        onTriggered: {
            if (countLoader >= 10) {
                triggerTimer.running = false
                loader.sourceComponent = undefined
            } else {

                if (loader.sourceComponent != undefined) {
                    loader.sourceComponent = undefined
                    console.log("Timer unload")
                } else {
                    loader.sourceComponent = animationArea
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

            Rectangle {
                id: animBackground
                width: 0.65 * parent.width
                height: parent.height - 0.1175 * root.width //0.65 * parent.height
                //anchors.centerIn: parent
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                radius: 3

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

                    Component.onDestruction: {
                        console.log("Thomas - main onDestruction")
//                        lottieAnim.destroyAll()
                    }
                }
            }
        }
    }

    // Lottie.LottieAnimation {
    //     id: lottieAnim
    //     anchors.centerIn: parent
    //     width: parent.width
    //     height: parent.height
    //      source: "qrc:/lottieFiles/gradient_animated_background.json"
    //     running: true
    //     clearBeforeRendering: true
    //     speed: 1.0
    //     loops: Animation.Infinite
    //     fillMode: Image.PreserveAspectFit
    //     reverse: false
    // }
}
