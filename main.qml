import QtQuick 2.0
import QtQuick.Particles 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    visible: true
    id: root
    width: 1100; height: 700
    property Rectangle rec: goldButton

    // ----- sky -------------------------------------------------------------------
    Rectangle {
        id: sky
        width: root.width; height: (root.height)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black" }
            GradientStop { position: 1.0; color: "#1C1C1C" }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: particleSystemAttack.running = true
        }
    }

// ----- sky PARTICLE-------------------------------------------------------------------
    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        source: "star.png"
        system: particleSystem
        color: '#FFD700'
        colorVariation: 0.2
        rotation: 0
        rotationVariation: 45
        rotationVelocity: 15
        rotationVelocityVariation: 15
        entryEffect: ImageParticle.Scale
    }

    Emitter {
        id: emitter
        emitRate: 19
        anchors.fill: sky
        system: particleSystem
        lifeSpan: 7500
        size: 42
        endSize: 21
    }

    // particle buttons
    Rectangle {
        id: heartsButton
        width: 100; height: 100
        x: 50
        y: sky.height / 2 - 50
        border.color: "red"
        gradient: Gradient {
                GradientStop { position: 0.0; color: "#FFBF00" }
                GradientStop { position: 1.0; color: "#FF4000" }
        }

        radius: width/2

        MouseArea {
            anchors.fill: parent
            drag {
               target: parent
                axis: Drag.XandYAxis
            }
            onPressed: {
                particleSystemHearts.running = true;
            }
        }

    }
    Rectangle {
        id: bombelsButton
        x: sky.width - 150
        y: sky.height / 2 - 50
        width: 100; height: 100
        gradient: Gradient {
                GradientStop { position: 0.0; color: "lightsteelblue" }
                GradientStop { position: 1.0; color: "blue" }
        }
        radius: width/2
        border.color: "blue"

        MouseArea {
            anchors.fill: parent
            drag {
               target: parent
                axis: Drag.XandYAxis
            }
            onPressed: {
                particleSystemAttack.running = true
            }
        }
    }

    Rectangle {
        id: centerEffectView
        visible: true
        width: 230; height: 230
        color: "transparent"
        radius: 80
        anchors.centerIn: sky
        anchors.rightMargin: 35;
        border.width: 2
        border.color: "gold"

        MouseArea {
            anchors.fill: parent
            onClicked: particleSystemAttack.running = true
        }
    }


    Rectangle {
        id: goldButton
        width: 100; height: 100
        border.color: "red"
        gradient: Gradient {
                GradientStop { position: 0.0; color: "#FFBF00" }
                GradientStop { position: 1.0; color: "#FF4000" }
        }
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 35;
        anchors.bottomMargin: 35;
        radius: width/2

        MouseArea {
            anchors.fill: parent
            onClicked: {
                particleSystemStar.running = true
                parent.anchors.bottom = undefined;
                parent.anchors.right = undefined;
                anim(parent);
            }
        }
    }

// ----- RUN STAR PARTICLE -------------------------------------------------------------------

    ParticleSystem {
        id: particleSystemStar
        running: false
    }

    ImageParticle {
        source: "star.png"
        system: particleSystemStar
        color: '#FFD700'
        colorVariation: 0.2
        rotation: 0
        rotationVariation: 45
        rotationVelocity: 15
        rotationVelocityVariation: 15
        entryEffect: ImageParticle.Scale
    }

    Emitter {
        id: emitterStar
        anchors.left: parent.left
        anchors.verticalCenter: sky.bottom
        width: 1; height: 1
        system: particleSystemStar
        emitRate: 18
        lifeSpan: 10400
        lifeSpanVariation: 400
        size: 35
        velocity: AngleDirection {
            angle: -43.9
            angleVariation: 0
            magnitude: 239.0
        }
        acceleration: AngleDirection {
            angle: 70
            magnitude: 70
        }
    }

// ----- BOOMBELS PARTICLE -------------------------------------------------------------------
    ParticleSystem {
        id: particleSystemAttack
        running : false
    }

    ImageParticle {
        source: "particleX.png"
        system: particleSystemAttack
        color: 'blue'
        colorVariation: 0.35
        rotation: 0
        rotationVariation: 52
        rotationVelocity: 15
        rotationVelocityVariation: 15
        entryEffect: ImageParticle.Scale
    }

    Emitter {
        id: emitterAttack
        anchors.right: bombelsButton.left
        y: bombelsButton.y + (bombelsButton.height/2)
        width: 1; height: 1
        system: particleSystemAttack
        emitRate: 12
        lifeSpan: 6800
        lifeSpanVariation: 400
        size: 32
        velocity: AngleDirection {
            angle: 180
            angleVariation: 15
            magnitude: 140
            magnitudeVariation: 50
        }
    }

    // ----- HEARTH PARTICLE -------------------------------------------------------------------
        ParticleSystem {
            id: particleSystemHearts
            running : false
        }

        ImageParticle {
            source: "S.png"
            system: particleSystemHearts
            color: 'gold'
            colorVariation: 0.2
            rotation: 300
            rotationVariation: 52
            rotationVelocity: 75
            rotationVelocityVariation: 35
            entryEffect: ImageParticle.Scale
        }

        Emitter {
            id: emitterAttackHearts
            anchors.right: heartsButton.right
            y: heartsButton.y + (heartsButton.height/2)
            width: 1; height: 1
            system: particleSystemHearts
            emitRate: 12
            lifeSpan: 6990
            lifeSpanVariation: 400
            size: 32
            velocity: AngleDirection {
                angle: 0
                angleVariation: 15
                magnitude: 120
                magnitudeVariation: 50
            }
        }
        Turbulence {
            anchors.fill: centerEffectView
            system: particleSystemAttack
           strength: 160
        }

        Attractor {
            anchors.horizontalCenter: parent.horizontalCenter
            width: centerEffectView.width; height: centerEffectView.height
            system: particleSystemHearts
            pointX: centerEffectView.x
            pointY: 0
            strength: 1.0
            anchors.fill: centerEffectView
        }

        function anim(button) {
            root.rec = button;
            animStarButton.restart();
        }

        SequentialAnimation {
            id: animStarButton
            NumberAnimation {
                target: root.rec
                properties: "x"
                to: 35
                duration: 1700
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: root.rec
                properties: "y"
                to: -240
                duration: 1300
                easing.type: Easing.InExpo
            }
        }
}
