
/* 
   Gonzalo Ruiz
   Assignment 7c */

.data

value1: .float 0.55556    /*Temperature problem: 5/9 */
value2: .float 68.0       /* fahrenheit: 100 - 32 = 68
   
message: .asciz "Fahrenheit = 100\n"
message1: .asciz "Enter fahrenheit (32 - 212): "
message2: .asciz "Enter 32 - 212 only: "
message3: .asciz "Celsius(DivMod) = %d\n"
message4: .asciz "\nCelsius(Pure Int) = %d\n"
message5: .asciz "Time it took: %d (secs)\n"
message6: .asciz "\nDrag problem\n"
message7: .asciz "\nEnter Velocity and Radius: "
message8: .asciz "Integer Dynamic Pressure = %d (lbs)\n"
message9: .asciz "Cross Sectional Area x 32 = %d (ft^2)\n"
message10: .asciz "Integer Drag x 32 = %d (lbs)\n"
message11: .asciz "\nCelsius(Float multiplication) = %f\n"
format:   .asciz "%d" 
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
    
     ldr r0, address_of_message  /* Set &message1 as the first parameter of printf */ 
     bl printf                    /* Call printf */ 

     loop4:
     
   
     mov r0, #100		  /* Load the integer read by scanf into r0 */ 

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

     ldr r1, =value1
	ldr r0, =value2
	vldr s2, [r1]
	vldr s3, [r0]

	vmul.f32 s4, s2, s3

	vcvt.f64.f32 d0, s4
	
	ldr r0, =message11
	vmov r2, r3, d0
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
   
        ldr r0, address_of_format2    
        mov r2, sp                   
        add r1, r2, #4                
        bl scanf                     

        add r1, sp, #4               /* Place sp+4 -> r1 */ 
        ldr r1, [r1]                 /* Load the integer velocity read by scanf into r1 */ 
        ldr r2, [sp]		    /* Load the integer radius read by scanf into r2 */

	ldr r3, =0x9b5
	ldr r4, =0x3243f7
	ldr r5, =0x1c7
	ldr r6, =0x666

	mul r7, r1, r3
	mul r8, r7, r1
	mov r8, r8, ASR #12
	
	mul r7, r4, r2
	mul r9, r7, r2
	mov r9, r9, ASR #12
	mul r10, r9, r5
	mov r10, r10, ASR #16
	mul r7, r8, r10
	mov r7, r7, ASR #12
	mul r9, r7, r6

	mov r8, r8, ASR #9
	mov r10, r10, ASR #3
	mov r9, r9, ASR #12

	mov r1, r8
        ldr r0, address_of_message8   
        bl printf                    

	mov r1, r10
        ldr r0, address_of_message9  
        bl printf

	mov r1, r9
        ldr r0, address_of_message10   
        bl printf 

        mov r7, #1
        swi 0                        
   
address_of_value1:   .word value1

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
address_of_format2:   .word format2 
