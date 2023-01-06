                .global calcPixel

                .text

two: .double 2.0

@ calcPixel(maxiters, col, row, xsize, ysize, xcenter, ycenter, maginifcation) -> rgb
calcPixel:
	push {ip, lr}
	@ r0: maxiters (from function call)
	@ r1: col (from function call)
	@ r2: row (from function call)
	@ r3: xsize (from function call)
	@ ysize is stored on stack 8 bytes up (ip, then lr, then ysize)
	@ d0: xcenter (from fucntion call)
	@ d1: ycenter (from function call)
	@ d2: magnificaiton (from fucntion call)
	
	fldd	d7, two			@ d7 = 2.0

	@ cast xsize to double (double)xsize
	vmov	s8, r3
	fsitod	d4, s8			@ d4 = xsize
	@ cast col to double (double)col
	vmov	s10, r1
	fsitod	d5, s10			@ d5 = column

	fdivd	d4, d4, d7		@ d4 = xsize/2.0
	fsubd	d4, d5, d4		@ d4 = column - xsize/2.0
	
	@ r1 is now clear to use	

	@ cast ysize to double (double)ysize
	ldr	r1, [sp, #8]		@ r1 = ysize
	vmov	s10, r1		
	fsitod	d5, s10			@ d5 = ysize
	@ cast row to double (double)row
	vmov	s12, r2
	fsitod	d6, s12			@ d6 = row

	fdivd	d5, d5, d7		@ d5 = ysize/2.0
	fsubd	d5, d6, d5		@ d5 = row - ysize/2.0

	@ find minsize
	cmp	r3, r1			@ compare xsize and ysize
	movlt	r1, r3			@ if r3 < r1: 
					@	r1 = r3	

	@ r2, and r3 are now clear to use	
	@ d4: x numerator
	@ d5: y numerator
	@ r1: minsize

	@ calculate division number
	sub	r1, r1, #1		@ minsize = (minsize - 1)
	@ cast minsize to double (double)minsize
	vmov	s6, r1
	fsitod	d3, s6			@ d3 = (minsize - 1)
	
	fmuld	d2, d2, d3		@ d2 = (magnification * (minsize -1))

	@ d2: division_number (magnification * (minsize - 1))

	
	fdivd	d3, d4, d2		@ d3 = x_numerator/division_number	
	faddd	d0, d0, d3		@ x = xcenter + d3
	fdivd	d3, d5, d2		@ d3 = y_numerator/division_number	
	fsubd	d1, d1, d3		@ y = ycenter - d3
	@ r0 is still maxiters

	bl	mandel			@ mandel(maxiters, x, y)
	@ r0 now contains the number of iterations until escape
	bl	getColor	
	@ r0 is now the return vaule of rgb value
	
	@ return from function	
	pop {ip, pc}



