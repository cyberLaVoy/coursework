                .global remainder

                .text
@ remainder(numerator, denominator) -> remainder
remainder:
	@r0: n
	@r1: d
	push	{r4, lr}
	@r4: shift

	cmp	r0, r1		@ if n < d:
	poplt	{r4, pc}	@	return n (already in r0)

	clz	r2, r1		@ r2 = number of leading zeros in d	
	clz	r3, r0		@ r3 = number of leading zeros in n	

	sub	r4, r2, r3	@ shift = (num leading zeros d) - (num leading zeros n)
	
	b	2f		@ go to test

@ loop body
1:				 
	mov	r2, r1, lsl r4 	@ r2 = d<<shift
	cmp	r0, r2		@ if n >= d<<shift:
	subge	r0, r0, r2	@	n = n - d<<shift
	
	sub	r4, r4, #1	@ shift = shift - 1

@ loop test
2:
	cmp	r4, #0		@ if shift >= 0:
	bge	1b		@	go to loop body


	@r0: remainder
	pop	{r4, pc}
