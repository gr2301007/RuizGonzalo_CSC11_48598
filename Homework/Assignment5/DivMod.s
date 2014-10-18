
/* Assignment 5*/

.data 
   
message1: .asciz "Enter numerator and denominator: " 
format:   .asciz "%d %d" 
message2: .asciz "You entered: a = %d, b = %d\n" 
message3: .asciz "a / b = %d and a mod b = %d\n" 
  
.text 

scaleRight: 
 	push {lr}             
 	loop:     
 		mov r3,r3,ASR #1
 		mov r2,r2,ASR #1 
 	cmp r1,r2 
 	blt loop 
 	pop {lr}
     bx lr
  
 
addSub: 
 	push {lr} 
 	loop2: 
 		add r0,r0,r3 
 		sub r1,r1,r2 
 		bl scaleRight 
 	cmp r3,#1 
 	bge loop2 
     pop {lr} 
     bx lr 

 
scaleLeft: 
 	push {lr}  
 	loop3:   
 		mov r3,r3,LSL #1 
 		mov r2,r2,LSL #1 
 		cmp r1,r2 
 	bge loop3 
 	mov r3,r3,ASR #1  
 	mov r2,r2,ASR #1   
 	pop {lr}  
     bx lr  
  
 
divMod: 
 	push {lr}  
 	
 	mov r0,#0 
 	mov r3,#1 
 	cmp r1,r2 
 	blt end 
 		bl scaleLeft 
 		bl addSub 
 	end: 
 	pop {lr}  
     bx lr 

 	 
.globl main 

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #8               /* Make room for two 4 byte integers in the stack */ 
 	 
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
   
     ldr r0, address_of_format    /* Set format as the first parameter of scanf */ 
     mov r2, sp                   /* Set variable of the stack as b */ 
 	add r1, r2, #4               /* and second value as a of scanf */ 
     bl scanf                     /* Call scanf */ 
   
 	add r1, sp, #4               /* Place sp+4 -> r1 */ 
     ldr r1, [r1]                 /* Load the integer a read by scanf into r1 */ 
     ldr r2, [sp]		         /* Load the integer b read by scanf into r2 */ 
     ldr r0, address_of_message2  /* Set &message2 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
 	 
 	add r1, sp, #4               /* Place sp+4 -> r1 */ 
     ldr r1, [r1]                 /* Load the integer a read by scanf into r1 */ 
     ldr r2, [sp]		         /* Load the integer b read by scanf into r2 */ 
 	bl divMod 
 	mov r2,r1					 /* divMod returns r0,r1 -> need r1,r2 for printf */ 
 	mov r1,r0 
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 
   
     add sp, sp, #8               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave main */ 
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3 
address_of_format:   .word format 
