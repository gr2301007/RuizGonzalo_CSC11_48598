
/* 
   Gonzalo Ruiz
   project test */



/* Assignment 5*/

.data 
   
message1: .asciz "%d\n" 
format:   .asciz "%c" 

  
.text 

 	 
.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 

    ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
    mov r1, sp                   /* Set the top of the stack as the second parameter */
                                 /* of scanf */
    bl scanf                     /* Call scanf */
     
    ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
   
    
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_format:   .word format
