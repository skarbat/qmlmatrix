##QML Matrix Screen Saver

Matrix animation running on QT5 framework QML engine.

###How it works

Radek wrote a first implementation for the browser using an HTML Canvas.
The original source code can be found here: https://github.com/KanoComputing/kano-matrix

I migrated it to a QML Canvas to work on MacOS and the RaspberryPI.

###Build and run

Install the QT5 framework, then:

```
$ cd build && qmake && make
```

The app will be found at `bin/qmlmatrix` and it is self contained.

When you run the app, it will play the Matrix animation until you move the mouse or press a key.

###Fonts

For Linux Debian systems you need the font packages `fonts-ipafont-gothic` and `fonts-dejavu-core`.
