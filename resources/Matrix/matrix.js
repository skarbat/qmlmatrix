/*
 *  matrix.js
 *
 *  Copyright (C) 2017 Kano Computing Ltd.
 *  License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPLv2
 *
 *  Main rendering loop for the Matrix animation
 */

function darkenCanvas(canvas, context, ratio) {
    context.fillStyle = "rgba(0, 0, 0, " + ratio + ")";
    context.fillRect(0, 0, canvas.width, canvas.height);
}


function paint_matrix(ctx, canvas, drops, fadeout) {

    /* Draw black translucent overlay over the whole image to create the trail. */
    darkenCanvas(canvas, ctx, 0.03);

    /* Update each drop */
    for (var i = 0; i < drops.length; i++) {
        drops[i].update();
    }
}
