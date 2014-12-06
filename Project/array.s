/*  
 	How to pass large amounts of data into a function,  
 	i.e. an Array.  Of course, Pass by Reference!!! 
 	 
 	Think In Geek Article 17!!! 
 */ 
 .data 
   
 .align 4 
 
word1: 
 .word 6, 99, 104, 105, 110, 97
 
 cover1:
 .word 6, 95, 95, 95, 95, 95
 .align 4 
   
message: .asciz "%c " 
message2: .asciz "\n\nPick a letter: "
message3: .asciz "\nThat letter isn't in the word\n"
message4: .asciz "You have %d guesses left\n"
message5: .asciz "\nYou already used that letter\n"
format:   .asciz " %c" 

letter: .word 0

 .text 

replace_letter: 
     push {r4, r5, r6, r7, r8, lr} 
   
     mov r4, #0      /* r4 ? 0 */ 
     
     ldr r6, [r0, r4, LSL #2] 
     mov r4, #1   
     mov r7, #0
     
   b .Lcheck_loop_items 
     .Lloop_items: 
       ldr r5, [r0, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
       
	cmp r2, r5
	beq replace

        b continue

	replace:
           str r2, [r1, r4, LSL #2]
	   mov r7, #1  		/* flag letter found*/
       
        continue:
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_items: 
       cmp r4, r6                 /* r4 - r6 and update cpsr */ 
       bne .Lloop_items       /* if r4 != r6 goto .Lloop_print_items */ 

     mov r0, r7
   
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

     ldr r0, =message2
     bl printf 

     ldr r0, =format    /* Set &format as the first parameter of scanf */
     mov r1, sp                   /* Set the top of the stack as the second parameter */
                                    /* of scanf */
     bl scanf                     /* Call scanf */
     ldr r11, [sp]		    
     
     ldr r0, address_of_message 
     mov r1, r11       

     bl printf

     ldr r0, =word1
     ldr r1, =cover1
     mov r2, r11
     bl replace_letter

     cmp r0, #1
     beq not_found
     b output

     not_found:
        ldr r0, =message3
        bl printf 

     output:
     ldr r0, =cover1       /* first parameter: address of the array */
     bl print_word             /* call to print_word */ 
   
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr   
   
address_of_word1: .word word1 
address_of_message : .word message 
address_of_letter : .word letter 



