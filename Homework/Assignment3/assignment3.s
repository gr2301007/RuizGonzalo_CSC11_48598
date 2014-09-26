/*
	Gonzalo Ruiz
	9/29/14
	Assignment 3
*/
 
.text
.global main
main:
	mov r2, #222   /* a */
	mov r3, #5     /* b */
	mov r4, #0     /*counter*/
	mov r5, #0     /*flag not set*/
	mov r6, #0     /*present scale 10^*/
	mov r7, #0     /*scale factor= r3*r6 to subtract*/
	mov r8, #10    /*shift factor 10*/
	mov r9, #0     /*shift test r7*r8*/
	
	cmp r2, r3
	blt output

scale:
	mov r6, #1
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r2, r9
	bgt shift_scale
	b repeat

shift_scale:
	mul r10, r6, r8
	mov r6, r10
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r2, r9
	bgt shift_scale

repeat:
	sub r2, r2, r7
	add r4, r4, r6
	cmp r2, r7
	bge repeat
	cmp r6, #1
	bgt scale
	
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
	bx lr
