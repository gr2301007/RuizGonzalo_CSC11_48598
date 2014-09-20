	.global _start
_start:

	mov r1, #111  /* a */
	mov r2, #5    /* b */
	mov r3, #0  /*counter*/

	cmp r1, r2
	bne case_different
	blt case_lower

case_different:
	sub r1, r1, r2
	add r3, r3, #1
	cmp r1, r2
	blt case_lower
	bne case_different

case_lower:
	mov r0, r3
	b end

end:
	mov r7, #1
	swi 0
