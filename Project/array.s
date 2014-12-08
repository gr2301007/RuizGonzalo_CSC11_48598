/*  
 	Gonzalo Ruiz
	Project 2
 */

 .data 
   
 .align 4 
 
word1: .word 6, 99, 104, 105, 110, 97	/* word china (ascii code) */
cover1: .word 6, 95, 95, 95, 95, 95	/* cover word with '_' (ascii code = 95) */

word2: .word 6, 115, 112, 97, 105, 110	/* word spain (ascii code) */
cover2: .word 6, 95, 95, 95, 95, 95	

word3: .word 6, 104, 97, 105, 116, 105	/* word haiti (ascii code) */
cover3: .word 6, 95, 95, 95, 95, 95	

word4: .word 12, 97, 102, 103, 104, 97, 110, 105, 115, 116, 97, 110 /* word afghanistan (ascii code) */
cover4: .word 12, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95	

word5: .word 8, 100, 101, 110, 109, 97, 114, 107	/* word denmark (ascii code) */
cover5: .word 8, 95, 95, 95, 95, 95, 95, 95	

.align 4 

message: .asciz "%c "
message1: .asciz "Welcome to hangman...Guess a country name\n"
message2: .asciz "\n\nPick a letter: "
message3: .asciz "\nThat letter isn't in the word\n"
message4: .asciz "You have %d guesses left\n"
message5: .asciz "\nYou already used that letter\n"
message6: .asciz "You have 5 tries to guess the word\n"
message7: .asciz "Sorry you've been hanged\n"
message8: .asciz "Congratulations you win!\n"
message9: .asciz "The word was: "
message10: .asciz "Average of correct letters entered: %f\n"
format:   .asciz " %c" 

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

replace_letter: 
     push {r4, r5, r6, r7, r8, lr} 
   
     mov r4, #0      /* r4 ? 0 */ 
     
     ldr r6, [r0, r4, LSL #2] 
     mov r4, #1   
     mov r7, #0
     mov r8, #0

    b .Lcheck_letter 
     .Lloop_repeat: 
       ldr r5, [r1, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
       
	cmp r2, r5
	beq used

        b continue

	used:
           mov r8, #1  		/* flag letter already used*/
	   mov r7, #1
           b end
       
        continue:
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_letter: 
       cmp r4, r6                 /* r4 - r6 and update cpsr */ 
       bne .Lloop_repeat       /* if r4 != r6 goto .Lloop_print_items */ 
   
   mov r4, #1
     
   b .Lcheck_loop_items 
     .Lloop_items: 
       ldr r5, [r0, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
       
	cmp r2, r5
	beq replace

        b continue1

	replace:
           str r2, [r1, r4, LSL #2]  /*replace '_' with letter entered by user*/
	   
	   mov r7, #1  		/* flag letter found in word*/
       
        continue1:
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_items: 
       cmp r4, r6                 /* r4 - r6 and update cpsr */ 
       bne .Lloop_items       /* if r4 != r6 goto .Lloop_print_items */ 

    end:
     mov r0, r7
     mov r1, r8
   
     pop {r4, r5, r6, r7, r8, lr} 
     bx lr 

print_word: 
     push {r4, r5, r6, r7, r8, lr} /* r8 is unused */ 
   
     mov r4, #0      /* r4 ? 0 */ 
     
     mov r7, r0  
     ldr r6, [r7, r4, LSL #2] 
     mov r4, #1   
     
   
     b .Lcheck_loop_print_items 
     .Lloop_print_items: 
       ldr r5, [r7, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
       
       /* Prepare the call to printf */ 
       ldr r0, address_of_message /* first parameter of the call to printf below */ 
       mov r1, r5      /* second parameter: item position */ 
       
       bl printf       /* call printf */ 

       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_print_items: 
       cmp r4, r6                 /* r4 - r6 and update cpsr */ 
       bne .Lloop_print_items       /* if r4 != r6 goto .Lloop_print_items */ 
   
     pop {r4, r5, r6, r7, r8, lr} 
     bx lr 

random_word: 
 	push {lr}             
 	
	mov r0, #0
    	bl time
    	bl srand
    	bl rand
    	mov r1, r0, ASR #1
    	mov r2, #5
    	bl divMod
    	add r1, #1

        cmp r1, #1
    	beq w1
    	cmp r1, #2
    	beq w2
    	cmp r1, #3
    	beq w3
    	cmp r1, #4
    	beq w4
    	cmp r1, #5
    	beq w5

    	w1:
    	ldr r0, =word1
	ldr r1, =cover1
	mov r4, #0
        ldr r2, [r0, r4, LSL #2] 
    	b end_rand
    	
	w2:
    	ldr r0, =word2
	ldr r1, =cover2
	mov r4, #0
        ldr r2, [r0, r4, LSL #2] 
    	b end_rand
    	
	w3:
    	ldr r0, =word3
	ldr r1, =cover3
	mov r4, #0
        ldr r2, [r0, r4, LSL #2] 
    	b end_rand
    	
	w4:
    	ldr r0, =word4
	ldr r1, =cover4
	mov r4, #0
        ldr r2, [r0, r4, LSL #2] 
    	b end_rand
    	
	w5:
    	ldr r0, =word5
	ldr r1, =cover5
	mov r4, #0
        ldr r2, [r0, r4, LSL #2] 

    end_rand:
     sub r2, r2, #1
     pop {lr}
     bx lr
   

 .globl main 
main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */

    bl random_word

    mov r8, r0
    mov r9, r1
    mov r4, r2			/*size of the word*/
    mov r5, #5			/*guesses left*/
    mov r6, #0			/*letters entered*/
    mov r7, #0			/*correct letters entered*/

     ldr r0, =message1
     bl printf 

      ldr r0, =message6
     bl printf 

    loop:

     mov r0, r9                /* first parameter: address of the array */
     bl print_word             /* call to print_word */
 
     ldr r0, =message2
     bl printf 

     ldr r0, =format    /* Set &format as the first parameter of scanf */
     mov r1, sp         /* Set the top of the stack as the second parameter of scanf */
     bl scanf           /* Call scanf */
     add r6, r6, #1	/* increase number of letters entered by one*/

     ldr r11, [sp]		    
     
     mov r0, r8
     mov r1, r9
     mov r2, r11
     bl replace_letter

     cmp r0, #0
     beq not_found

     cmp r1, #1
     beq letter_used

     sub r4, r4, #1	/*decrease size of word by 1*/
     add r7, r7, #1	/*increase number of correct letters entered by one*/

     b test

     not_found:
	sub r5, r5, #1		/*decrease number of guesses left*/
        cmp r5, #0
	beq lose

        ldr r0, =message3
        bl printf

        ldr r0, =message4
        mov r1, r5
        bl printf

     b test

     letter_used:
        ldr r0, =message5
        bl printf

    test:
     cmp r4, #0
     bne loop
     beq win

    lose:
      ldr r0, =message7
        bl printf

    b end_main

    win:
      ldr r0, =message8
        bl printf

   end_main:
       vmov s0, r6
       vcvt.f32.s32 s1,s0 

       vmov s2, r7
       vcvt.f32.s32 s3,s2

       vdiv.f32 s4,s3,s1

       vcvt.f64.f32 d6,s4 
       vmov r2,r3,d6 
       ldr r0, =message10
       bl printf  

      ldr r0, =message9
      bl printf

      ldr r0, =word1            /* first parameter: address of the array */
      bl print_word             /* call to print_word */
     
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr   
   
address_of_word1: .word word1 
address_of_message : .word message 

