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

    mov r2, #70
    mov r3, #71
    mov r4, #72
    mov r5, #73
    
    output: 
    mov r1, r5
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf                    /* Call printf */ 

    mov r1, r5
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf  

    mov r1, r5
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf

    mov r1, r5
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
    bl printf  

   
    
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_format:   .word format
