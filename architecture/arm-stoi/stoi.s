        .global stoi
        .text
stoi:
	@r0: address of buffer (from function call)
	@r1: i	
	@r2: buffer_char (single character from bufer)
	@r3: num (integer to return)
	@r4: neg (bool, if number is negative)

	push	{r4, lr}	

	mov	r3, #0		@ num = 0
	mov	r1, #0		@ i = 0
	mov	r4, #0		@ neg = False

	ldrb	r2, [r0]	@ buffer_char = buffer[0]
	cmp	r2, #45		@ if r2 == 45: (first char is '-')
	moveq	r4, #1			@ neg = True
	addeq	r1, #1			@ i++

	b	2f		@ go to test	

1: @ main loop	
	mov	r12, #10
	mul	r3, r3, r12	@ num = num * 10
	sub	r2, r2, #48	@ buffer_char = buffer_char - 48
	add	r3, r3, r2	@ num = num + buffer_char	

	add	r1, #1		@ i++

2: @ test
	ldrb	r2, [r0, r1]	@ buffer_char = buffer[i]
	cmp	r2, #48		@ if buffer_char < 48:
	blt	3f			@ break
	cmp	r2, #57		@ elif buffer_char > 57:	
	bgt	3f			@ break
	
	b	1b		@ else:
					@ go to main loop
3: @ test break
	cmp	r4, #1		@ if neg:
	moveq	r1, #0			@ r1 = 0
	subeq	r3, r1, r3		@ num = 0 - num

	mov 	r0, r3
	@ return num
	pop	{r4, pc}

	
	
