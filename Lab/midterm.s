
/* 
   Gonzalo Ruiz
   Midterm program */

.data 
   
message1: .asciz "Type 1 for problem 1\nType 2 for problem 2\nType 3 for problem 3\nType 4 to exit: "

format:   .asciz "%d" 
message2: .asciz "You typed %d to exit the program\n"
 
.text 

Menu: 
 	push {lr}
           
 	ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     	bl printf                    /* Call printf */ 

 	pop {lr}
        bx lr
  
  	 
.globl main

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 

     
     loop:
        bl Menu

        ldr r0, address_of_format    /* Set format as the first parameter of scanf */ 
        mov r1, sp                   /* Set the top of the stack as the second parameter*/ 
        bl scanf                     /* Call scanf */
        ldr r0, [sp]		     /* Load the integer read by scanf into r0 */

 	cmp r0, #1
	beq one
	cmp r0, #2
	beq two
	cmp r0, #3
	beq three
	b def

	one:
	   bl problem1
	   b loop
	two:
	   bl problem2
	   b loop
	three:
	   bl problem3
	   b loop
	def:
	   mov r1, r0
	   ldr r0, address_of_message2  /* Set &message1 as the first parameter of printf */ 
     	   bl printf                    /* Call printf */ 

     add sp, sp, #4               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
	
     
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_format:   .word format 
