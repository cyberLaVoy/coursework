                .global palette, palette_size, black

                .data
palette:
                @ blues
                .word   0x000011
                .word   0x000022
                .word   0x000033
                .word   0x000044
                .word   0x000055
                .word   0x000066
                .word   0x000077
		.word   0x000011
                .word   0x000022
                .word   0x000033
                .word   0x000044
                .word   0x000055
                .word   0x000066
                .word   0x000077


                @ blues
                .word   0x111111
                .word   0x222222
                .word   0x333333

palette_size:   .word   (.-palette) / 4

black:          .word   0
