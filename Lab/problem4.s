
/* 
   Gonzalo Ruiz
   Final
   Problem 4 */

.data 
   
message1: .asciz "\nIn problem 4\n"
message2: .asciz "\nEnter x as an integer 0 to 255: "
message3: .asciz "\nax^2+bx = %d\n"

.balign 4
number: .word 0

.balign 4
format:  .asciz "%d"

.text 

.globl problem4 

problem4: 
     push {r4, lr}

     ldr r0, =message1            
     bl printf 

     ldr r0, =message2            
     bl printf 

     ldr r0, =format
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     ldr r2, [r1]

     ldr r3, =0x12b02
     ldr r4, =0xe04188

     mul r5, r3, r2
     mov r5, r5, ASR #4
     mul r6, r5, r2
     mov r6, r6, ASR #1

     mul r7, r4, r2
     mov r7, r7, ASR #9
     add r8, r6, r7
     mov r8, r8, ASR #15

     ldr r0, =message3
     mov r1, r8        
     bl printf 

     end:
	pop {r4, lr}
	bx lr                        /* Leave problem4 */ 

   
