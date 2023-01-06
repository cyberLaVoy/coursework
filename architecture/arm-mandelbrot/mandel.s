                .global mandel

                .text

four:	.double 4.0

@ mandel(maxiters, x, y) -> iters
mandel:
	@ maxiters currently in r0

	@ d0: x (from function call)
	@ d1: y (from function call)
	@ d2: a
	@ d3: b
	@ d4: a^2
	@ d5: b^2
	@ d6: a^2 + b^2
	@ d7: 4.0
	@ r0: iterations
	@ r1: maxiters

	fldd	d7, four	@ d7 = 4.0 (stored above function)
	mov 	r1, r0		@ r1 = maxiters
	mov	r0, #1		@ iterations = 1
	fcpyd	d2, d0		@ a = x
	fcpyd	d3, d1		@ b = y
	
1: @ while True:
	
	fmuld	d4, d2, d2	@ d4 = a * a
	fmuld	d5, d3, d3	@ d5 = b * b
	faddd	d6, d4, d5	@ d6 = a^2 + b^2
	
	@ if a^2 + b^2 >= 4.0 then return from loop 
	fcmpd	d6, d7
	fmstat
	movge	pc, lr

	add 	r0, r0, #1	@ iterations++
	
	@ if iterations > maxiters then return from loop
	cmp	r0, r1	
	movgt	r0, #0		@ return value of zero
	movgt	pc, lr
	
	@ b = 2ab + y
	fmuld	d3, d2, d3	@ b = a*b
	faddd	d3, d3, d3	@ b = 2b
	faddd	d3, d3, d1	@ b = b + y

	@ a = a^2 - b^2 + x
	fsubd	d2, d4, d5	@ a = a^2 - b^2
	faddd	d2, d2, d0	@ a = a + x
	
	@ branch back to continuously loop
	b	1b
	
	
	
	



