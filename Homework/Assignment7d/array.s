/*  
 	How to pass large amounts of data into a function,  
 	i.e. an Array.  Of course, Pass by Reference!!! 
 	 
 	Think In Geek Article 17!!! 
 */ 
 .data 
   
.align 4 
 big_array : 
 .skip 1028 
   
 .align 4 
 message: .asciz "The sum of 0 to 255 is %d\n" 
   
 .text 
 .globl main 
   
 sum_array_ref : 
     /* Parameters:  
            r0  Number of items 
            r1  Address of the array 
     */ 
     push {r4, r5, r6, lr} 
   
     /* We have passed all the data by reference */ 
   
     /* r4 will hold the sum so far */ 
     mov r4, #0      /* r4 ? 0 */ 
     mov r5, #0      /* r5 ? 0 */ 
   
     b .Lcheck_loop_array_sum 
     .Lloop_array_sum: 
 	  str r5, [r1, r5, LSL #2]   /*Inititialize the array 0..255 */ 
       ldr r6, [r1, r5, LSL #2]   /* r6 ? *(r1 + r5 * 4) */ 
       add r4, r4, r6             /* r4 ? r4 + r6 */ 
       add r5, r5, #1             /* r5 ? r5 + 1 */ 
     .Lcheck_loop_array_sum: 
       cmp r5, r0                 /* r5 - r0 and update cpsr */ 
       bne .Lloop_array_sum       /* if r5 != r0 go to .Lloop_array_sum */ 
   
     mov r0, r4  /* r0 ? r4, to return the value of the sum */ 
     pop {r4, r5, r6, lr} 
   
     bx lr 
   
   
 main: 
     push {r4, lr} 
     /* we will not use r4 but we need to keep the function 8-byte aligned */ 
   
     mov r0, #255
     ldr r1, address_of_big_array 
   
     bl sum_array_ref 
   
     /* prepare the call to printf */ 
     mov r1, r0                  /* second parameter, the sum itself */ 
     ldr r0, address_of_message  /* first parameter, the message */ 
     bl printf 
   
     pop {r4, lr} 
     bx lr 
   
 address_of_big_array : .word big_array 
 address_of_message : .word message 
