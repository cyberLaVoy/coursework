                .global run

                .equ    flags, 577
                .equ    mode, 0644

                .equ    sys_write, 4
                .equ    sys_open, 5
                .equ    sys_close, 6

                .equ    fail_open, 1
                .equ    fail_writeheader, 2
                .equ    fail_writerow, 3
                .equ    fail_close, 4

                .text

@ run() -> exit code
run:
@ your code goes here

	push	{r4, r5, r6, r7, r8, lr}
	@r4: file descriptor
	@r5: buffer size
	@r6: column (for gradient)
	@r8: row (for gradient)

	ldr	r0, =filename
	ldr	r1, =flags
	ldr	r2, =mode
	mov	r7, #sys_open
	svc	#0
	
	cmp	r0, #0		@detect any failure from return value (r0)
	bge	1f		@branch if successful

	mov	r0, #fail_open
	pop	{r4, r5, r6, r7, r8, pc}

1: @ open file success branch
	@r0 is now file descriptor/handle
	mov	r4, r0		@r4 = file_handle

	ldr	r0, =buffer
	ldr	r1, =xsize	@ r1 = memory address of xsize
	ldr	r1, [r1]	@ r1 = value stored in xsize
	ldr	r2, =ysize	@ r2 = memory address of ysize
	ldr	r2, [r2]	@ r2 = value stored in ysize

	bl	writeHeader	
	@r0 is now the num bytes in the buffer

	mov	r2, r0		@ r2 = buffer_size	
	mov	r0, r4		@ r0 = file_handle (from previous system call)
	ldr	r1, =buffer
	mov	r7, #sys_write
	svc	#0
	
	cmp	r0, #0		@detect any failure from return value (r0)
	bge	2f		@branch if successful

	mov	r0, #fail_writeheader
	pop	{r4, r5, r6, r7, r8, pc}

2: @ write header success branch


	mov 	r8, #0		@ row = 0	
3: @ row loop

	mov	r5, #0		@ buffer_size = 0
	mov	r6, #0		@ column = 0
4: @ column loop

@ write one color to buffer
	ldr	r0, =xcenter
	fldd	d0, [r0]		@ d0 = xcenter
	ldr	r0, =ycenter
	fldd	d1, [r0]		@ d1 = ycenter
	ldr	r0, =mag
	fldd	d2, [r0]		@ d2 = mag

	ldr	r0, =iters		@ r0 = max_iterations
	ldr	r0, [r0]
	mov	r1, r6			@ r1 = column_number
	mov	r2, r8			@ r2 = row_number
	
	ldr	r3, =ysize		
	ldr 	r3, [r3]		@ r3 = ysize
	sub	sp, sp, #8		@ move stack pointer down two slots
	str	r3, [sp]		@ store ysize in the first slot

	ldr	r3, =xsize		
	ldr 	r3, [r3]		@ r3 = xsize

	bl	calcPixel
	add	sp, sp, #8		@ move stack pointer to original position
	@ r0 now contains color value

	mov	r1, r0			@ r1 = color
	ldr	r0, =buffer
	add	r0, r0, r5	@ r0 = buffer location + buffer_size
	bl 	writeRGB	@ writeRGB(r0, color)
	@ r0 now contains the num bytes written to buffer
	add	r5, r0		@ buffer_size += num bytes written
	
	@ store a space in buffer
	ldr	r0, =buffer
	mov	r1, #' '	@ r0 = " "
	strb	r1, [r0, r5]	@ buffer[buffer_size] = " "
	add	r5, r5, #1	@ buffer_size += 1	
	
	@ test column value
	add	r6, r6, #1	@ column += 1
	ldr	r3, =xsize	@ r3 = memory address of xsize
	ldr	r3, [r3]	@ r3 = value stored in xsize
	cmp	r6, r3	
	blt	4b		@ if column < xsize: goto column loop
@ end column loop

	@ replace last space with newline
	ldr	r0, =buffer
	mov	r1, #'\n'	@ r0 = "\n"
	sub	r5, r5, #1	@ buffer_size -= 1
	strb	r1, [r0, r5]	@ buffer[buffer_size-1] = "\n"
	add	r5, r5, #1	@ buffer_size += 1	

	@ proceed to write buffer to file
	mov	r2, r5		@ r2 = buffer_size	
	mov	r0, r4		@ r0 = file_handle (from previous system call)
	ldr	r1, =buffer
	mov	r7, #sys_write
	svc	#0
	
	cmp	r0, #0		@detect any failure from return value (r0)
	bge	5f		@branch if successful

	mov	r0, #fail_writerow
	pop	{r4, r5, r6, r7, r8, pc}

5: @ write gradient success branch
	
	@ test row value	
	add 	r8, r8, #1	@ row += 1
	ldr	r3, =ysize	@ r3 = memory address of ysize
	ldr	r3, [r3]	@ r3 = value stored in ysize
	cmp	r8, r3	
	blt	3b		@ if row < ysize: goto row loop branch
@end row loop


	@ call to close file handle
	mov	r0, r4		@ r0 = file_handle
	mov	r7, #sys_close	
	svc	#0

	cmp	r0, #0		@detect any failure from return value (r0)
	bge	6f		@branch if successful

	mov	r0, #fail_close
	pop	{r4, r5, r6, r7, r8, pc}

6: @ file handle close success

	mov	r0, #0		@return 0 to indicate success	
	pop	{r4, r5, r6, r7, r8, pc}



@ why is the buffer declared way down here??
                .bss
buffer:         .space 64*1024

