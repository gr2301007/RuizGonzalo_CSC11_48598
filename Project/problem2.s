
/* Problem 2*/

.data 
   
message1: .asciz "\nIn problem 2\n\n"
message2: .asciz "Enter package(a,b,c) and hours: "
message3: .asciz "Monthly bill is: %d\n\n"
format:   .asciz "%d %d"
  
.text 

.globl main 

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #8               /* Make room for two 4 byte integers in the stack */ 
     
 	 
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     ldr r0, address_of_message2  /* Set &message2 as the first parameter of printf */ 
     bl printf                    /* Call printf */
   
     ldr r0, address_of_format    /* Set format as the first parameter of scanf */ 
     mov r2, sp                   /* Set variable of the stack as hours */ 
     add r1, r2, #4               /* and second value as package of scanf */ 
     bl scanf                     /* Call scanf */ 
   
     add r1, sp, #4               /* Place sp+4 -> r1 */ 
     ldr r1, [r1]                 /* Load the character package read by scanf into r1 */ 
     ldr r2, [sp]		  /* Load the integer hours read by scanf into r2 */ 
     
     
	
     output:
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     b end
   
     end:
     add sp, sp, #8               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_format:   .word format 
