		.global itoa

		.equ div10_magic, 0xcccccccd

		.text
@ itoa(buffer, integer) -> number of bytes written
itoa:
		push {r4, r5, r6, lr}

		@ r0: buffer
		@ r1: integer (n)

		@ r2: length_of_output
		@ r3: division magic number
		@ r4: digit
		@ r5: new n

		ldr	r3, =div10_magic
		mov	r2, #0
1:
		@ do a division by 10
		umull	r4, r5, r3, r1		@ multiply by magic number
		mov	r5, r5, lsr #3		@ shift: new_n is in r5
		add	r4, r5, r5, lsl #2	@ compute new_n*5
		sub	r4, r1, r4, lsl #1	@ remainder = n - new_n*5*2
		add	r4, r4, #'0'		@ convert to digit
		strb	r4, [r0, r2]		@ store in buffer
		add	r2, r2, #1		@ length_of_output++
		subs	r1, r5, #0		@ n = newn and compare with 0
		bgt	1b
	
		@ r1: i	
		@ r3: j
		@ r4: temp_a
		@ r5: temp_b

		mov 	r1, #0			@ i = 0
		mov	r3, r2 			@ j = len(buffer) -1
		sub	r3, r3, #1

		b	3f			@ goto test (3)
2:
		ldrb	r4, [r0, r1]		@ temp_a = buffer[i]
		ldrb	r5, [r0, r3]		@ temp_b = buffer[j]
		strb	r5, [r0, r1]		@ buffer[i] = temp_b
		strb	r4, [r0, r3]		@ buffer[j] = temp_a
		add	r1, r1, #1		@ i += 1
		sub	r3, r3, #1		@ j -= 1
						

3:
		cmp 	r1, r3			@ if i < j
		blt	2b			@ 	goto loop (2)
		
		@ return number of bytes written
		mov	r0, r2
		pop	{r4, r5, r6, pc}
				

