
/* 
   Gonzalo Ruiz
   project test */



/* Assignment 5*/

.data 
   
message1: .asciz "Hello %c bye\n" 

  
.text 

 	 
.globl main 

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     
 	 
     mov r1, #97
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
   
    
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 

