/* 
   Gonzalo Ruiz
   project test */

.data 

newline: .asciz "\n"
message1: .asciz "%c " 
format:   .asciz "%c" 

.text 

.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 

    mov r0, sp
    bl getch
    
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_newline: .word newline
address_of_message1: .word message1 
address_of_format:   .word format
