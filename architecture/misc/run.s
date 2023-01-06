ldr r7, system_call
svc #0	@pass control over to os

r0 file descriptor, r1 address in memory, r2 number of bytes

fd will be in r0


run:
	push	{r7, lr}
	ldr	r0, =filename
	ldr	r1, =flags
	ldr	r2, =mode
	mv	r7, #sys_open
	svc	#0
	
	cmp	r0, #0		@detect any failure
	bge	1f		@branch if successful

	mov	r0, #fail_open
	pop	{r7, pc}

1:				@open success branch

	pop	{r7, pc}
