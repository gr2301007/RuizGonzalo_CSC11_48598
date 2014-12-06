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
   
message: .asciz "%d " 
message2: .asciz "\n\nPick a letter: "
message3: .asciz "\nThat letter isn't in the word\n"
message4: .asciz "You have %d guesses left\n"
message5: .asciz "\nYou already used that letter\n"
format:   .asciz " %c" 

letter: .word 0

 .text 

print_each_item: 
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
     push {r4, lr} 

     ldr r0, =message2
     bl printf 

     ldr r0, =format    /* Set &format as the first parameter of scanf */
     ldr r1, address_of_letter          
     bl scanf                     /* Call scanf */

     ldr r4, address_of_letter

     ldr r0, address_of_message 
     mov r1, r4       

     bl printf

     ldr r0, =cover1   /* first parameter: address of the array */
     
     bl print_each_item             /* call to print_each_item */ 
   
     pop {r4, lr} 
     bx lr 
   
address_of_word1: .word word1 
address_of_message : .word message 
address_of_letter : .word letter 



