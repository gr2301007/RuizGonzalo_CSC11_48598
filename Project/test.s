
/* 
   Gonzalo Ruiz
   project test */

.data 
   
message1: .asciz "Hello/n"


 .text 


.global main

main: 

     /*mov r1, #97*/
   
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     bx lr                        /* Leave main */ 
	
     
   
address_of_message1: .word message1 
.global printf
