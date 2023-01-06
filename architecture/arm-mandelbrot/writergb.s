                .global writeRGB

                .text
@ writeRGB(buffer, rgb) -> number of bytes written
writeRGB:

	push {r4, r5, r6, lr}

	@r4: buffer
	@r5: color
	@r6: i (number of bytes)

	mov	r4, r0			@ r4 = buffer
	mov	r5, r1			@ r5 = color
	mov	r6, #0			@ i = 0
	
	@write the red color value to buffer
	mov	r1, #0xff		@ r1 = 0xff (the mask)
	and 	r1, r1, r5, lsr #16	@ r1 = masked color (logically shifted)
	add	r0, r4, r6		@ r0 = location of buffer + i
	bl	itoa
	add	r6, r6, r0		@ i += number of bytes written

	@ store a space in buffer
	mov	r0, #' '		@ r0 = " "
	strb	r0, [r4, r6]		@ buffer[i] = " "
	add	r6, r6, #1		@ i += 1

	@write the green color value to buffer
	mov	r1, #0xff		@ r1 = 0xff (the mask)
	and 	r1, r1, r5, lsr #8	@ r1 = masked color (logically shifted)
	add	r0, r4, r6		@ r0 = location of buffer + i
	bl	itoa
	add	r6, r6, r0		@ i += number of bytes written

	@ store a space in buffer
	mov	r0, #' '		@ r0 = " "
	strb	r0, [r4, r6]		@ buffer[i] = " "
	add	r6, r6, #1		@ i += 1

	@write the blue color value to buffer
	mov	r1, #0xff		@ r1 = 0xff (the mask)
	and 	r1, r1, r5		@ r1 = masked color
	add	r0, r4, r6		@ r0 = location of buffer + i
	bl	itoa
	add	r6, r6, r0		@ i += number of bytes written

	@return value r0 (number of bytes written)
	mov	r0, r6			
	
	pop {r4, r5, r6, pc}
	

