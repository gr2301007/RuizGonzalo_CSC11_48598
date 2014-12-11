
/* 
   Gonzalo Ruiz
   Final
   Problem 2 */

.data 
   
message1: .asciz "\nIn problem 2\n"
message2: .asciz "\nEnter number of years (1-20): "
message3: .asciz "\nEnter Interest Rate (0.05 - 0.1): "
message4: .asciz "\nEnter Present Value ($1000 - $5000: "
message5: .asciz "Future Value for year %d = "
message6: .asciz "%f\n"

.balign 4
number: .word 0

.balign 4
format:   .asciz "%d"
format1:   .asciz "%f" 

.balign 4
array: .skip 100
  
.text 

.globl problem2 

problem2: 
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

     ldr r0, =message3            
     bl printf 
     ldr r0, =format1
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     vldr s2, [r1]

     ldr r0, =message4            
     bl printf 
     ldr r0, =format1
     ldr r1, =number     
     bl scanf                      
     ldr r1, =number
     vldr s3, [r1]

     ldr r1, =array
     mov r5, #0

     vmov r6, s3
     str r6, [r1, r5, LSL #2]

      b .Lcheck_loop_array 
     .Lloop_array: 

        ldr r7, [r1, r5, LSL #2]
	vmov s4, r7
        vmul.f32 s5, s4, s2
        vadd.f32 s4, s4, s5

	vmov r6, s4
        str r6, [r1, r5, LSL #2]
	mov r8, r5
	add r8, r8, #1
	str r6, [r1, r8, LSL #2]

 	add r5, r5, #1             /* r4 ? r4 + 1 */ 

     .Lcheck_loop_array: 
       cmp r5, r4                 /* r4 - r0 and update cpsr */ 
       bne .Lloop_array    /* if r4 != r0 go to .Lloop_array_double */ 

      ldr r9, =array
      mov r10, #0
      
      b .check_print_array 
     .print_array: 

        ldr r0,=message5 
 	mov r1, r10
	add r1, r1, #1
 	bl printf 

	ldr r0,[r9,r10, LSL #2]     @float number in the  array 
 	vmov s3,r0               @ready to print out 
 	vcvt.f64.f32 d5,s3 
 	ldr r0,=message6 
 	vmov r2,r3,d5 
 	bl printf 

 	add r10, r10, #1             /* r4 ? r4 + 1 */ 

     .check_print_array: 
       cmp r10, r4                 /* r4 - r0 and update cpsr */ 
       bne .print_array    /* if r4 != r0 go to .Lloop_array_double */ 
     
     end:
	pop {r4, lr}
	bx lr                        /* Leave problem2 */ 

   
