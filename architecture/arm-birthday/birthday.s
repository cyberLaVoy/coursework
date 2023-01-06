        .global birthday
        .text

one:		.double 1.0
days:		.double 365.0
onehundred:	.double 100.0

birthday:
	@ r0: num_people (from function call)
	@ r1: i
	@ r2: days (days in a year) int
	@ d1: prob (prob of no collision)
	@ d2: days (days in a year) float

	push	{r4, lr}

	fldd	d1, one		@ prob = 1.0
	ldr	r2, =365	@ days = 365
	fldd	d2, days	@ days = 365.0
	mov	r1, #0		@ i = 0.0
	
	b	2f		@ go to test	
1: @ main loop
	sub	r3, r2, r1	@ unused_days = 365 - i

	@ convert unused_days to float
	vmov	s0, r3
	fsitod	d0, s0		
	
	fdivd	d0, d0, d2	@ unused_days /= 365.0
	fmuld	d1, d1, d0	@ prob *= unused_days
	
	add	r1, r1, #1	@ i++
	
2: @ test
	cmp	r1, r0		@ if i < num_people:
	blt	1b			@ go to main loop

	fldd	d0, one		@ d0 = 1.0
	fsubd	d1, d0, d1	@ prob = 1.0 - prob
	fldd	d2, onehundred	@ d0 = 100.0
	fmuld	d0, d1, d2	@ collision_chance = prob * 100.0
	
	@ convert collision_chance to integer
	ftosid	s0, d0	
	vmov	r0, s0

	@ r0 is now collision_chance	
	pop	{r4, pc}
	
