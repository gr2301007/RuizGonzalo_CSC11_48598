
/* Problem 1*/

.data 
   
message1: .asciz "\nIn problem 1\n\n"
message2: .asciz "Enter hours worked and rate: "
message3: .asciz "Gross payment is: %d\n\n"
message4: .asciz "No more than 60 hours.\n\n"
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
     mov r2, sp                   /* Set variable of the stack as rate */ 
     add r1, r2, #4               /* and second value as hours of scanf */ 
     bl scanf                     /* Call scanf */ 
   
     add r1, sp, #4               /* Place sp+4 -> r1 */ 
     ldr r1, [r1]                 /* Load the integer hours read by scanf into r1 */ 
     ldr r2, [sp]		  /* Load the integer rate read by scanf into r2 */ 
     
     cmp r1, #60
     bgt invalid_hours

     cmp r1, #20
     ble first
     bgt second

     

     first:
	mul r3, r1, r2
	b output
     
     second:
	cmp r1, #40
        bge third

	mov r4, #20
	mul r3, r2, r4
	sub r1, r1 #20
	mov r5, #2
	mul r6, r1, r5
	mul r7, r2, r6
	add r3, r3, r7
	b output

     third:
	mov r4, #20
 	mul r3, r2, r4
	mov r5, #2
	mul r6, r4, r5
	mul r7, r2, r6
	add r3, r3, r7
	sub r1, r1, #40
	mov r8, #3
	mul r9, r8, r1
	mul r10, r2, r9
	add r3, r3, r9
	
     output:
     mov r1,r3
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     b end
   
     invalid_hours:
     ldr r0, address_of_message4  /* Set &message4 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
     
     end:
     add sp, sp, #8               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_format:   .word format 
