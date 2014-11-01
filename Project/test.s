/* 
   Gonzalo Ruiz
   project test */

.data 

newline: .asciz "\n"
message1: .asciz "%c " 
format:   .asciz " %c" 

.text 

.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 

    mov r2, #70
    mov r3, #71
    mov r4, #72
    mov r5, #73
    mov r6, #74
    mov r7, #5			 /*length of the word*/
    mov r8, #0

    loop:
    ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
    mov r1, sp                   /* Set the top of the stack as the second parameter */
                                 /* of scanf */
    bl scanf                     /* Call scanf */
    ldr r1, [sp]		 /* Load character read into r1*/

    /* cmp r1, #67
    beq letter_c

    cmp r1, #104
    beq letter_h

    cmp r1, #105
    beq letter_i

    cmp r1, #110
    beq letter_n

    cmp r1, #97
    beq letter_a
    
    b wrong

    letter_c:
	mov r2, r1
	b output
    letter_h:
	mov r3, r1
	b output
    letter_i:
	mov r4, r1
	b output
    letter_n:
	mov r5, r1
	b output
    letter_a:
	mov r6, r1
	b output

    wrong:
	add r8, r8, #1 */

    output: 
    mov r1, #65
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf                    /* Call printf */ 

    mov r1, r2
    ldr r0, address_of_message1
    bl printf 

    mov r1, r4
    ldr r0, address_of_message1
    bl printf 

    mov r1, r5
    ldr r0, address_of_message1
    bl printf 

    mov r1, r6
    ldr r0, address_of_message1
    bl printf 

    sub r7, r7, #1
    cmp r7, #0
    bne loop
    
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_newline: .word newline
address_of_message1: .word message1 
address_of_format:   .word format
