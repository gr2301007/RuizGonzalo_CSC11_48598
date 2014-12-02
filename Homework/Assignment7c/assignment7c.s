
/* 
   Gonzalo Ruiz
   Assignment 7c */

.data


f1:.float 9
f2:.float 5
f3:.float 32
f: .word 0

value3: .float 1.0        /* Half */
value4: .float 0.00237    /* Rho */
value5: .float 3.1416     /* Pi */
value6: .float 0.0069     /* Conv 1 / 144 */
value7: .float 0.4        /* Cd */
value8: .float 200.0      /* Velocity */
value9: .float 6.0        /* Radius */
 
   
message: .asciz "Enter fahrenheit (32 - 212) as float: "
message1: .asciz "Enter fahrenheit (32 - 212): "
message2: .asciz "Enter 32 - 212 only: "
message3: .asciz "Celsius(DivMod) = %d\n"
message4: .asciz "\nCelsius(Pure Int) = %d\n"
message5: .asciz "Time it took: %d (secs)\n"
message6: .asciz "\nDrag problem\n"
message7: .asciz "\nVelocity = 200 Radius = 6"
message8: .asciz "\nInteger Dynamic Pressure = %d (lbs)\n"
message9: .asciz "Cross Sectional Area x 32 = %d (ft^2)\n"
message10: .asciz "Integer Drag x 32 = %d (lbs)\n"
message11: .asciz "\nCelsius(Float multiplication) = %f\n"
format:   .asciz "%f"
format1:   .asciz "%d"
format2:   .asciz "%d %d"
  
.text

convertDivMod:
     push {lr}

     sub r3, r0, #32
     mov r2, #5
     mul r1, r2, r3
     mov r2, #9
     bl divMod
     
     pop {lr}
     bx lr

convertPureInt:
	push {lr}

	ldr r1, =0x8e38f
	sub r2, r0, #32
	mul r0, r1, r2
	mov r0, r0, ASR #20
	
	pop {lr}
	bx lr

convertFloat:
	push {lr}

	
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
     sub sp, sp, #8               /* Make room for two 4 byte integer in the stack */
     
     ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     loop4:
     ldr r0, address_of_format1    /* Set format as the first parameter of scanf */ 
     mov r1, sp                   /* Set the top of the stack as the second parameter*/ 
     bl scanf                     /* Call scanf */ 
   
     ldr r0, [sp]		  /* Load the integer read by scanf into r0 */ 
   
     cmp r0, #32
     blt invalid

     cmp r0, #212
     bgt invalid

     ldr r7, =0x989680           /*Number of loops*/
     mov r8, r0

     mov r0, #0 
     bl time
     mov r9, r0
     
     loopDivMod:
        mov r0, r8
        bl convertDivMod
        sub r7, r7, #1
        cmp r7, #0
        bne loopDivMod

     mov r5, r0
     mov r0, #0 
     bl time
     mov r4, r0
     sub r6, r4, r9

     mov r1, r5
     ldr r0, address_of_message3  /* Set &message3 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     mov r1, r6
     ldr r0, address_of_message5  /* Set &message5 as the first parameter of printf */ 
     bl printf                    /* Call printf */

     

     ldr r7, =0x989680           /*Number of loops*/
     
     mov r0, #0 
     bl time
     mov r9, r0
     
     loopPureInt:
        mov r0, r8
        bl convertPureInt
        sub r7, r7, #1
        cmp r7, #0
        bne loopPureInt

     mov r5, r0
     mov r0, #0 
     bl time
     mov r4, r0
     sub r6, r4, r9

     mov r1, r5
     ldr r0, address_of_message4  /* Set &message4 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     mov r1, r6
     ldr r0, address_of_message5  /* Set &message5 as the first parameter of printf */ 
     bl printf                    /* Call printf */

	ldr r1, address_of_f1
	vldr s9,[r1]

	ldr r0, address_of_message
	bl printf


	ldr r1,address_of_f2
	vldr s10,[r1]

	
	ldr r0,address_of_format
	ldr r1,address_of_f
	bl scanf

	ldr r1,address_of_f
	vldr s11,[r1]
	
	ldr r1,address_of_f3
	vldr s12,[r1]

	vsub.f32 s11,s11,s12
	vmul.f32 s11,s10,s11
	vdiv.f32 s11,s11,s9

	vcvt.f64.f32 d7,s11
	ldr  r0,address_of_message11
	vmov r2,r3,d7
	bl printf

     b drag

     invalid:
     ldr r0, address_of_message2  /* Set &message2 as the first parameter of printf */ 
     bl printf                    /* Call printf */
     b loop4

     drag:
        ldr r0, address_of_message6   
        bl printf                    

        ldr r0, address_of_message7  
        bl printf                    
   
       
	ldr r1, =value8
	ldr r2, =value9

	ldr r3, =value3
	ldr r4, =value4
	ldr r5, =value5
	ldr r6, =value6
	ldr r7, =value7
	
	vldr s24, [r1]
	vldr s25, [r2]
	vldr s26, [r3]
	vldr s27, [r4]
	vldr s28, [r5]
	vldr s29, [r6]
	vldr s30, [r7]
	
	vmul.f32 s10, s27, s24
	vmul.f32 s11, s10, s24

	vmul.f32 s12, s28, s25
	vmul.f32 s13, s12, s25
	vmul.f32 s14, s13, s29

	vmul.f32 s15, s11, s14
	vmul.f32 s16, s15, s30
	

	vcvt.f64.f32 d0, s11
	vcvt.f64.f32 d1, s14
	vcvt.f64.f32 d2, s16

	ldr r0, =message8
	vmov r2, r3, d0
	bl printf

	ldr r0, =message9
	vmov r2, r3, d1
	bl printf

	ldr r0, =message10
	vmov r2, r3, d2
	bl printf

        add sp, sp, #8               
        ldr lr, [sp], #+4            
        bx lr  

                    
address_of_f:.word f
address_of_f1:.word f1
address_of_f2:.word f2
address_of_f3:.word f3

address_of_message: .word message 
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_message6: .word message6 
address_of_message7: .word message7 
address_of_message8: .word message8
address_of_message9: .word message9
address_of_message10: .word message10
address_of_message11: .word message11
address_of_format:   .word format
address_of_format1:   .word format1
address_of_format2:   .word format2 
