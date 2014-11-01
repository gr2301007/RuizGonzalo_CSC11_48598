/* 
   Gonzalo Ruiz
   project test */

.data 

message1: .asciz "%c " 
format:   .asciz " %c" 

.text 

.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 

    mov r4, #95
    mov r5, #95
    mov r6, #95
    mov r7, #95
    mov r8, #95
    mov r9, #5			 /*length of the word*/
    mov r10, #0

    loop:
    ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
    mov r1, sp                   /* Set the top of the stack as the second parameter */
                                 /* of scanf */
    bl scanf                     /* Call scanf */
    ldr r1, [sp]		 /* Load character read into r1*/

    cmp r1, #67
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
	mov r4, r1
	b output
    letter_h:
	mov r5, r1
	b output
    letter_i:
	mov r6, r1
	b output
    letter_n:
	mov r7, r1
	b output
    letter_a:
	mov r8, r1
	b output

    wrong:
	add r10, r10, #1

    output: 
    mov r1, r4
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf                    /* Call printf */ 

    mov r1, r5
    ldr r0, address_of_message1
    bl printf 

    mov r1, r6
    ldr r0, address_of_message1
    bl printf 

    mov r1, r7
    ldr r0, address_of_message1
    bl printf 

    mov r1, r8
    ldr r0, address_of_message1
    bl printf 

    sub r9, r9, #1
    cmp r9, #0
    bne loop
    
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_format:   .word format
