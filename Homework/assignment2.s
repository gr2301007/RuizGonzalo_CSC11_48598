	.global _start
_start:

	mov r1, #111
	mov r2, #5
	cmp r1, r2
	bne zeroclear
	
	mov r7, #1
	swi 0
