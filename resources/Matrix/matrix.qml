/*
 *  matrix.qml
 *
 *  Copyright (C) 2017 Kano Computing Ltd.
 *  License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPLv2
 *
 *  Matrix like animation on QML. Most of the rendering code comes from
 *  Radek's project at https://github.com/KanoComputing/kano-matrix
 */

import QtQuick 2.3

/* Javascript modules that do the graphic rendering */
import 'drop.js' as DropJS
import 'matrix.js' as MatrixJS

Rectangle {
    id: matrix_box
    color: "black"

    /* This timer is used to simulate setInterval() available on web browsers */
    Timer {
        id: paintTimer
        interval: 150
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            canvas.requestPaint()
        }
    }

    Timer {
        id: animationTimer
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            if (repeat == false) {
                canvas.fadeout = true;
            }
        }
    }

    /* indicates completion of the animation, set by start(duration) */
    signal done()

    /* main function to start the animation, will signal "done" on completion */
    /* a duration of 1 will play the matrix forever */
    function start(duration) {

        /* start the timer for the overall animation time - in msecs */
        animationTimer.interval = duration
        if (duration == 1) {
            animationTimer.repeat = true;
        }

        animationTimer.start()

        /* start the timer that paints continously and causes the animation */
        paintTimer.start()
    }

    Canvas {
        id: canvas
        width: parent.width
        height: parent.height

        property int numberOfDrops: 0
        property int fontSize: 0
        property var drops: []
        property bool fadeout: false

        onPaint: {
            var ctx = getContext("2d");

            /* create the drops the first time */
            if (numberOfDrops === 0) {

                fontSize = canvas.width / 32
                numberOfDrops = canvas.width / fontSize;

                for(var x = 0; x < numberOfDrops; x++) {
                   drops.push(new DropJS.Drop(x, canvas, ctx, fontSize));
                }

                /* set the canvas font face size and family name */
                if (Qt.platform.os == "linux") {
                    ctx.font = fontSize + "px Monospace";
                }
                else {
                    ctx.font = fontSize + "px Courier";
                }
            }

            MatrixJS.paint_matrix(ctx, canvas, drops, fadeout);

            /* to terminate the animation, remove each drop one at a time */
            if (fadeout === true && drops.length > 0) {
                drops.pop();
            }

            /* do extra paints to smoothly fade away the animation */
            if (fadeout && drops.length === 0) {
                if (numberOfDrops === 1) {
                    /* terminate and signal animation completion */
                    paintTimer.running = false;
                    done();
                }
                else {
                    /* keep painting until all drops fade away */
                    MatrixJS.paint_matrix(ctx, canvas, drops, fadeout);
                    numberOfDrops--;
                }
            }
        }
    }
}
