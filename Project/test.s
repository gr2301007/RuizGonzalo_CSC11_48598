
/* 
   Gonzalo Ruiz
   project test */



/* Assignment 5*/

.data 
   
message1: .asciz "%c " 
format:   .asciz "%c" 

  
.text 

 	 
.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 

    ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
    mov r1, sp                   /* Set the top of the stack as the second parameter */
                                 /* of scanf */
    bl scanf                     /* Call scanf */
    ldr r1, [sp]		 /* Load integer read into r1*/
     
    mov r1, #67
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf                    /* Call printf */ 

    mov r1, #104
    ldr r0, address_of_message1
    bl printf 

    mov r1, #105
    ldr r0, address_of_message1
    bl printf 

    mov r1, #110
    ldr r0, address_of_message1
    bl printf 

    mov r1, #97
    ldr r0, address_of_message1
    bl printf 
    
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_format:   .word format
