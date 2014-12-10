
/* 
   Gonzalo Ruiz
   Final
   Problem 1 */

.data 
   
message1: .asciz "\nIn problem 1\n\n"
message2: .asciz "I have a number between 1 and 1000\nCan you guess my number? You will be\ngiven a maximum of 10 guesses.\nPlease type your first guess: "

message3: .asciz "\nCongratulations, You guessed the number!"
message4: .asciz "Too low. Try again. "
message5: .asciz "Too high. Try again. "
message6: .asciz "\nToo many tries."
message7: .asciz "\nWould you like to play again(y or n)?: "
format:   .asciz "%d"
format1:   .asciz "%c" 
  
.text 

scaleRight: 
 	push {lr}             
 	loop0:     
 		mov r3,r3,ASR #1
 		mov r2,r2,ASR #1 
 	cmp r1,r2 
 	blt loop0 
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
 	blt end_div 
 		bl scaleLeft 
 		bl addSub 
 	end_div: 
 	pop {lr}  
     bx lr 


.globl main 

main: 
     str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
     sub sp, sp, #8               /* Make room for two 4 byte integers in the stack */ 

     loop:
     mov r0, #0
     bl time
     bl srand
     bl rand
     mov r1, r0, ASR #1
     mov r2, #1000
     bl divMod
     add r1, #1

     mov r4, r1

     ldr r0, =format            
     bl printf  
     
     ldr r0, =message1            /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     ldr r0, =message2            /* Set &message2 as the first parameter of printf */ 
     bl printf                    /* Call printf */
   
     ldr r0, =format              /* Set format as the first parameter of scanf */ 
     mov r1, sp                   
     bl scanf                     /* Call scanf */ 
   
     ldr r2, [sp]                 /* Load the integer read by scanf into r2 */ 
     mov r1, r2
     ldr r0, =format            
     bl printf
     
     cmp r2, r4
     beq win

     b end

     win:
        ldr r0, =message3
	bl printf
	ldr r0, =message7
	bl printf
	ldr r0, =format1              /* Set format as the first parameter of scanf */ 
        mov r1, sp                   
        bl scanf                     /* Call scanf */ 
        ldr r4, [sp]                 /* Load the character read by scanf into r4 */
	
	cmp r4, #121
        beq loop 
     
     end:
     add sp, sp, #8               /* Discard the integer read by scanf */ 
     ldr lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
     bx lr                        /* Leave problem1 */ 
   
