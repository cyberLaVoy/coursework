                .global getColor

                .text
@ getColor(iters) -> rgb
getColor:
	@ r0: iters
	push	{r4, lr}
	
	@ special teset case
	cmp	r0, #0			@ if iters == 0:
	ldreq	r0, =black 
	ldreq	r0, [r0]		@ 	r0 = black
	popeq	{r4, pc}		@ 	return 0


	sub	r0, r0, #1		@ r0 = (iters - 1)	
	ldr	r1, =palette_size
	ldr	r1, [r1]		@ r1 = palette_size
	bl	remainder		@ remainder (n, d)	
	@ r0 = (iters - 1) % palette_size

	ldr	r1, =palette		@ r1 = address_of_palette
	add	r0, r1, r0, lsl #2	@ r0 = address_of_palette + color_index*4
	ldr	r0, [r0]		@ r0 = color stored at r0

	@ r0: rgb
	pop	{r4, pc}
