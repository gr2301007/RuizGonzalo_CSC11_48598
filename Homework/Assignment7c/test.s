


.data

value1: .float 0.55556
value2: .float 68.0
message1: .asciz "Enter fahrenheit (32 - 212): "
message11: .asciz "\nCelsius(Float multiplication) = %f\n"
format:   .asciz "%f" 

.text

.global main
main:
	str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
        sub sp, sp, #8               /* Make room for two 4 byte integer in the stack */

	ldr r0, =message1  /* Set &message1 as the first parameter of printf */ 
        bl printf                    /* Call printf */ 

	ldr r0, =format              /* Set format as the first parameter of scanf */ 
        mov r1, sp                   /* Set the top of the stack as the second parameter*/ 
        bl scanf                     /* Call scanf */ 
   
        ldr r0, [sp]		  /* Load the integer read by scanf into r0 */  
	
	ldr r1, =value1
	
	vldr s2, [r1]
	vldr s3, [r0]

	vmul.f32 s4, s2, s3

	vcvt.f64.f32 d0, s4
	
	ldr r0, =message11
	vmov r2, r3, d0
	bl printf

       add sp, sp, #8               
       ldr lr, [sp], #+4            
       bx lr         

addr_value1: .word value1

