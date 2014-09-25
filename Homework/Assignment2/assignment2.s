	.global _start
_start:

	mov r2, #111   /* a */
	mov r3, #5     /* b */
	mov r4, #0     /*counter*/
	mov r5, #0     /*flag not set*/

	cmp r2, r3
	blt output
	bne case_different
	beq case_equal

case_different:
	sub r2, r2, r3
	add r4, r4, #1
	cmp r2, r3
	blt output
	bne case_different
	beq case_equal

case_equal:
	sub r2, r2, r3
	add r4, r4, #1
	b output

output:
	mov r0, r4
	mov r1, r2
	cmp r5, #0
	bne swap
	b end

swap:
	mov r0, r2
	mov r1, r4
	b end

end:
	mov r7, #1
	swi 0
