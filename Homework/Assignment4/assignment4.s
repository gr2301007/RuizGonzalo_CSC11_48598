/*
	Gonzalo Ruiz
	9/29/14
	Assignment 4
*/
 
.text
.global main
main:
	mov r2, #24    /* a */
	mov r3, #6     /* b */
	mov r4, #1     /*scale factor*/
	mov r5, r3     /*subtraction factor*/
	mov r0, #0     /*counter*/
	mov r1, #r2    /*remainder*/
	mov r6, #0     /*flag not set*/
	
	cmp r2, r3
	blt output

scale_left:
	mov r4, r4, lsl#1
	mov r5, r5, lsl#1
	cmp r1, r5
	bge shift_left
	mov r4, r4, lsr#1
	mov r5, r5, lsr#1
	
add_sub:
	add r0, r0, r4
	sub r1, r1, r5
	b scale_right
	

scale_right:
	mov r4, r4, lsr#1
	mov r5, r5, lsr#1
	cmp r1, r5
	blt scale_right
	cmp r4, #1
	bgt add_sub
	
output:
	cmp r6, #0
	bne swap
	b end

swap:
	mov r7, r0
	mov r0, r1
	mov r1, r7
	b end

end:
	bx lr
