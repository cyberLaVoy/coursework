                .global filename
                .global xcenter, ycenter, mag
                .global xsize, ysize, iters

                .data
filename:       .asciz  "fractal.ppm"

                .balign 8
@xcenter:        .double -0.743643135
xcenter:        .double -.7436447860 
@ycenter:        .double 0.131825963
ycenter:        .double .1318252536
mag:            .double 90000.0
xsize:          .word   1024
ysize:          .word   786
iters:          .word   4000
