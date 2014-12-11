
/* 
   Gonzalo Ruiz
   Final
   Problem 3 */

.data 
   
message1: .asciz "\nIn problem 3\n"
message2: .asciz "\nEnter a number (1 - 10000): "
message3: .asciz "\nSquare Root is: %f"

.balign 4
number: .word 0

.balign 4
format:  .asciz "%f"

.balign 4
value: .float 600


.text 

.globl main 

main: 
     push {r4, lr}

     ldr r0, =message1            
     bl printf 

     ldr r0, =message2            
     bl printf 
     ldr r0, =format
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     vldr s2, [r1]

     vcvt.f64.f32 d5,s2 
     ldr r0,=message3 
     vmov r2,r3,d5 
     bl printf 

     end:
	pop {r4, lr}
	bx lr                        /* Leave problem3 */ 

   
