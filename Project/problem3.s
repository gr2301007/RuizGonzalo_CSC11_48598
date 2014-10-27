
/* 
   Gonzalo Ruiz
   Midterm
   Problem 3 */

.data 
   
message1: .asciz "\nIn problem 3\n\n"
message2: .asciz "Enter term in sequence: "
message3: .asciz "The term is: %d\n\n"
format:   .asciz "%d" 
  
.text 

.globl problem3 

problem3: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 
     
 	 
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     ldr r0, address_of_message2  /* Set &message2 as the first parameter of printf */ 
     bl printf                    /* Call printf */
   
     ldr r0, address_of_format    /* Set format as the first parameter of scanf */ 
     mov r1, sp                   /* Set the top of the stack as the second parameter*/ 
     bl scanf                     /* Call scanf */ 
   
     ldr r0, [sp]		  /* Load the integer read by scanf into r0 */ 
     
     mov r1, #0			/* first  = 0 */
     mov r2, #1			/* second = 1 */
     mov r3, #0			/* next = 0 */
     mov r4, #0			/* i = 0 */

     loop:
	cmp r4, #1		/* if i <= 1 go to less_one */
	ble less_one

	add r3, r1, r2		/* next = first + second */
	mov r1, r2		/* first = second */
	mov r2, r3		/* second = next */
	b test

	less_one:
	   mov r3, r4		/* next = i */

	test:
	   add r4, #1		/* i++ */
	   cmp r4, r0		/* while (i < n) */
	   blt loop
	
     
     mov r1,r3
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
    
     add sp, sp, #4               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave problem3 */ 
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_format:   .word format 
