
/* 
   Gonzalo Ruiz
   Midterm
   Problem 2 */

.data 
   
message1: .asciz "\nIn problem 2\n\n"
message2: .asciz "Enter hours and package(a,b,c): "
message3: .asciz "Monthly bill is: %d\n\n"
format:   .asciz "%d %c"
  
.text 

.globl problem2

problem2: 
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
     ldr r1, [r1]                 /* Load the integer hours read by scanf into r1 */ 
     ldr r2, [sp]		  /* Load the character package read by scanf into r2 */ 
     
     cmp r2, #97		/* 97  = a */
     beq pckga

     cmp r2, #98		/* 98  = b */
     beq pckgb

     cmp r2, #99		/* 99  = c */
     beq pckgc

     pckga:
	cmp r1, #11		/* If hours <= 11 go to first option else go to second*/
	ble firsta
	bgt seconda

	firsta:
	   mov r3, #30 		/* bill = 30 */
	   b output

	seconda:
	   cmp r1, #22		/* If hours > 22 go to third option*/
	   bgt thirda

	   mov r3, #30
	   sub r1, r1, #11
	   mov r4, #3
	   mul r5, r4, r1
	   add r3, r3, r5	/* bill = 30 + 3 * (h - 11) */
	   b output 

	thirda:
	   mov r3, #30
	   mov r4, #3
	   mov r5, #11
	   mul r6, r4, r5
	   add r3, r3, r6	/* bill = 30 + 3 * 11 */
	   sub r1, r1, #22
	   mov r7, #6
	   mul r8, r7, r1
	   add r3, r3, r8	/* bill += 6 * (h - 22) */
	   b output

     pckgb:
	cmp r1, #22		/* If hours <= 22 go to first option else go to second*/
	ble firstb
	bgt secondb

	firstb:
	   mov r3, #35 		/* bill = 35 */
	   b output

	secondb:
	   cmp r1, #44		/* If hours > 44 go to third option*/
	   bgt thirdb

	   mov r3, #35
	   sub r1, r1, #22
	   mov r4, #2
	   mul r5, r4, r1
	   add r3, r3, r5	/* bill = 35 + 2 * (h - 22) */
	   b output 

	thirdb:
	   mov r3, #35
	   mov r4, #2
	   mov r5, #22
	   mul r6, r4, r5
	   add r3, r3, r6	/* bill = 35 + 2 * 22 */
	   sub r1, r1, #44
	   mov r7, #4
	   mul r8, r7, r1
	   add r3, r3, r8	/* bill += 4 * (h - 44) */
	   b output
	

     pckgc:
	cmp r1, #33		/* If hours <= 33 go to first option else go to second*/
	ble firstc
	bgt secondc

	firstc:
	   mov r3, #40 		/* bill = 40 */
	   b output

	secondc:
	   cmp r1, #66		/* If hours > 66 go to third option*/
	   bgt thirdc

	   mov r3, #40
	   sub r1, r1, #33
	   add r3, r3, r1	/* bill = 40 + (h - 33) */
	   b output 

	thirdc:
	   mov r3, #40
	   add r3, r3, #33	/*  bill = 40 + 33 */
	   sub r1, r1, #66
	   mov r4, #2
	   mul r5, r4, r1
	   add r3, r3, r5	/* bill += 2 * (h - 66) */
	   
     output:
     mov r1, r3			  /* r1 = bill(r3) */
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
   
     end:
     add sp, sp, #8               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave problem2 */
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_format:   .word format 
