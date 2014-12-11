
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

.balign 4
value1: .float 2

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

     ldr r2, =value
     vldr s3, [r2]
     ldr r3, =value1
     vldr s6, [r3]

     mov r4, #0
     mov r5, #10

     loop:
	vdiv.f32 s4, s2, s3
	vadd.f32 s3, s3, s4
	vdiv.f32 s5, s3, s6
	vmov s3, s5

	add r4, r4, #1
	cmp r4, r5
	bne loop

     vcvt.f64.f32 d5,s3 
     ldr r0,=message3 
     vmov r2,r3,d5 
     bl printf 

     end:
	pop {r4, lr}
	bx lr                        /* Leave problem3 */ 

   
