/*
	Gonzalo Ruiz
	10/13/14
	Assignment 4
*/

.data
 
/* First message */
.balign 4
message1: .asciz "Enter numerator and denominator: "
 
/* Second message */
.balign 4
message2: .asciz "%d / %d is %d\n"

/* Third message */
.balign 4
message3: .asciz "Remainder is %d\n"
 
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d %d"
 
/* Where scanf will store the numerator */
.balign 4
number_read: .word 0

/* Where scanf will store the denominator */
.balign 4
number_read2: .word 0
 
.balign 4
return: .word 0
 

.text
.global main
main:
	ldr r1, address_of_return        /* r1 ? &address_of_return */
    	str lr, [r1]                     /* *r1 ? lr */
 
    	ldr r0, address_of_message1      /* r0 ? &message1 */
    	bl printf                        /* call to printf */

	ldr r0, address_of_scan_pattern  /* r0 ? &scan_pattern */
    	ldr r1, address_of_number_read   /* r1 ? &number_read */
	ldr r2, address_of_number_read2
    	bl scanf  
	
	ldr r2, address_of_number_read    /* a */
	ldr r2, [r2]
	ldr r3, address_of_number_read2
	ldr r3, [r3]                      /* b */
	mov r4, #1     /*scale factor*/
	mov r5, r3     /*subtraction factor*/
	mov r0, #0     /*counter*/
	mov r1, r2     /*remainder*/
	
	cmp r2, r3
	blt output

scale_left:
	mov r4, r4, lsl#1
	mov r5, r5, lsl#1
	cmp r1, r5
	bge scale_left
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
	bge add_sub
	
output:
	mov r3, r0                       /* r3 ? r0 */
	mov r4, r1
    	ldr r1, address_of_number_read   /* r1 ? &number_read */
    	ldr r1, [r1]                     /* r1 ? *r1 */
	ldr r2, address_of_number_read2   /* r2 ? &number_read2 */
    	ldr r2, [r2]
    	ldr r0, address_of_message2      /* r0 ? &message2 */
    	bl printf 

	mov r1, r4                       /* r1 ? r4 */
    	ldr r0, address_of_message3      /* r0 ? &message3 */
    	bl printf 
	

end:
	ldr lr, address_of_return        /* lr ? &address_of_return */
    	ldr lr, [lr]                     /* lr ? *lr */
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_number_read2 : .word number_read2
address_of_return : .word return
 
/* External */
.global printf
.global scanf