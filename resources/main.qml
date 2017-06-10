/*
 *  main.qml
 *
 */

import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.2

import Matrix 1.0

ApplicationWindow {
    id: mainWindow
    flags: Qt.FramelessWindowHint
    visible: true
    color: "transparent"

    Component.onCompleted: {
        matrix_animate.start(1);
        mainWindow.showFullScreen();
    }

    function terminate(a) {
        // Things to do before terminating
        Qt.quit();
    }

    Rectangle {
        id: drawingRectangle
        color: "black"
        opacity: 0.0
        anchors.fill:parent
        focus: true

        SequentialAnimation {
            running: true
            NumberAnimation { target: drawingRectangle; property: "opacity"; to: 1.0; duration: 1000 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.BlankCursor
            onClicked: terminate();
            onDoubleClicked: terminate();
            onPositionChanged: terminate();
        }

        Keys.onPressed: {
            event.accepted = true;
            terminate();
        }

        MatrixAnimate {
            id: matrix_animate
            width: parent.width
            height: parent.height

            onDone: {
                terminate();
            }
        }
    }
}
