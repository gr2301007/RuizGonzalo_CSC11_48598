
/* 
   Gonzalo Ruiz
   project test */

.data 
   
.balign 4
message1: .asciz "Hello/n"


 .text 


.global main

main: 
     ldr r1, address_of_return        /* r1 ? &address_of_return */
     str lr, [r1]  

     /*mov r1, #97*/
   
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */

     ldr lr, address_of_return        /* lr ? &address_of_return */
     ldr lr, [lr]   

     bx lr                        /* Leave main */ 
	
     
   
address_of_message1: .word message1 
.global printf
