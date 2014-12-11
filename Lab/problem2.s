
/* 
   Gonzalo Ruiz
   Final
   Problem 2 */

.data 
   
message1: .asciz "\nIn problem 2\n"
message2: .asciz "\nEnter number of years (1-20): "
message3: .asciz "\nEnter Interest Rate (0.05 - 0.1): "
message4: .asciz "\nEnter Present Value ($1000 - $5000: "
message5: .asciz "\nFuture Value for year %d = %f\n"

.balign 4
format:   .asciz "%d"
format1:   .asciz "%f" 
number: .word 0

.balign 4
array: .skip 100
  
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
     ldr r4, [r1]

     ldr r0, =format 
     mov r1, r4           
     bl printf 



     ldr r0, =message3            
     bl printf 
     ldr r0, =format1
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     vldr s2, [r1]

     vcvt.f64.f32 d6,s2 
     vmov r2,r3,d6 
     ldr r0, =format1
     bl printf 


    ldr r0, =message4            
     bl printf 
     ldr r0, =format1
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     vldr s3, [r1]

     vcvt.f64.f32 d6,s3 
     vmov r2,r3,d6 
     ldr r0, =format1
     bl printf 
	
     
     end:
	pop {r4, lr}
	bx lr                        /* Leave problem2 */ 

   
