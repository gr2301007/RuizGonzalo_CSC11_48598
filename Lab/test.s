
/* 
   Gonzalo Ruiz
   project test */

.data 
   
message1: .asciz " | %c | %c | %c "


 .text 


.global main

main: 

     mov r1, #97
     mov r2, #98
     mov r3, #99
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     bx lr                        /* Leave main */ 
	
     
   
address_of_message1: .word message1 

