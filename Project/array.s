/*  
 	How to pass large amounts of data into a function,  
 	i.e. an Array.  Of course, Pass by Reference!!! 
 	 
 	Think In Geek Article 17!!! 
 */ 
 .data 
   
 .align 4 
 
word1: .word 6, 99, 104, 105, 110, 97
cover1: .word 6, 95, 95, 95, 95, 95


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
   

 .globl main 
main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */

    mov r4, #5			/*size of the word*/
    mov r5, #5			/*guesses left*/
    mov r6, #0			/*letters entered*/
    mov r7, #0			/*correct letters entered*/

     ldr r0, =message1
     bl printf 

      ldr r0, =message6
     bl printf 

    loop:

     ldr r0, =cover1       /* first parameter: address of the array */
     bl print_word             /* call to print_word */
 
     ldr r0, =message2
     bl printf 

     ldr r0, =format    /* Set &format as the first parameter of scanf */
     mov r1, sp         /* Set the top of the stack as the second parameter of scanf */
     bl scanf           /* Call scanf */
     add r6, r6, #1	/* increase number of letters entered by one*/

     ldr r11, [sp]		    
     
     ldr r0, =word1
     ldr r1, =cover1
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

      ldr r0, =word1       /* first parameter: address of the array */
      bl print_word             /* call to print_word */
     
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr   
   
address_of_word1: .word word1 
address_of_message : .word message 

