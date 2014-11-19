
/* 
   Gonzalo Ruiz
   Assignment 7a */

.data 
   
message1: .asciz "Enter fahrenheit (32 - 212): "
message2: .asciz "Enter 32 - 212 only: "
message3: .asciz "Celsius/Centigrade = %d\n"
format:   .asciz "%d" 
  
.text

convert:
     push {lr}

     sub r3, r0, #32
     mov r1, #5
     mov r2, #9
     bl divMod
     mov r2, r0
     mul r0, r3, r2

     pop {lr}
     bx lr

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

.global main

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */ 
     
 	 
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     loop4:
     ldr r0, address_of_format    /* Set format as the first parameter of scanf */ 
     mov r1, sp                   /* Set the top of the stack as the second parameter*/ 
     bl scanf                     /* Call scanf */ 
   
     ldr r0, [sp]		  /* Load the integer read by scanf into r0 */ 

     cmp r0, #32
     blt invalid

     cmp r0, #212
     bgt invalid

     bl convert
     b output

     invalid:
     ldr r0, address_of_message2  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     b loop4


     output:     
     mov r1, r0
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
    
     add sp, sp, #4               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave problem3 */ 
   
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_format:   .word format 
