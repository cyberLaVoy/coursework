                .global writeHeader

                .text
@ writeHeader(buffer, x_size, y_size) -> number of bytes written
writeHeader:
	@r0: buffer (from function call)
	@r1: x_size (from function call)
	@r2: y_size (from function call)

	@r4: buffer
	@r5: i
	@r6: y_size

	push {r4, r5, r6, lr}	
	mov	r4, r0		@ r4 = buffer_location
	mov	r5, #0		@ i = 0
	mov	r6, r2		@ r6 = y_size
	

	@ write P to buffer
	mov	r0, #'P'	@ r0 = "P"
	strb	r0, [r4, r5]	@ buffer[i] = "P"	
	add	r5, r5, #1	@ i += 1
	
	@ write 3 to buffer
	mov	r0, #'3'	@ r0 = "3"
	strb	r0, [r4, r5]	@ buffer[i] = "3"	
	add	r5, r5, #1	@ i += 1

	@ write new line to buffer
	mov	r0, #'\n'	@ r0 = "\n"
	strb	r0, [r4, r5]	@ buffer[i] = "\n"	
	add	r5, r5, #1	@ i += 1

	@ write x_size to buffer via itoa
	add	r0, r4, r5	@ buffer location to r0
	@ r1 is already x_size
	bl itoa	
	add	r5, r5, r0	@ i += number of bytes written

	@ store a space in buffer
	mov	r0, #' '	@ r0 = " "
	strb	r0, [r4, r5]	@ buffer[i] = " "
	add	r5, r5, #1	@ i += 1

	@ write y_size to buffer via itoa
	add	r0, r4, r5	@ buffer location to r0
	mov 	r1, r6		@ r1 = y_size	
	bl itoa	
	add	r5, r5, r0	@ i += number of bytes written

	@ write new line to buffer
	mov	r0, #'\n'	@ r0 = "\n"
	strb	r0, [r4, r5]	@ buffer[i] = "\n"	
	add	r5, r5, #1	@ i += 1

	@ write 255 to buffer via itoa
	add	r0, r4, r5	@ buffer location to r0
	mov 	r1, #255	@ r1 = 255
	bl itoa	
	add	r5, r5, r0	@ i += number of bytes written

	@ write new line to buffer
	mov	r0, #'\n'	@ r0 = "\n"
	strb	r0, [r4, r5]	@ buffer[i] = "\n"	
	add	r5, r5, #1	@ i += 1
	
	

	@ return number of bytes written
	mov 	r0, r5
	pop {r4, r5, r6, pc}
