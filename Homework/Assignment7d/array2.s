/*  
 	How to pass large amounts of data into a function,  
 	i.e. an Array.  Of course, Pass by Reference!!! 
 	 
	Think In Geek Article 17!!! 
 */ 
 .data 
   
 .align 4 
 big_array : 
 .skip 148 
   
 .align 4 
 message: .asciz "fahrenheit = %d, celsius = %d\n" 
   
 .text 
 .globl main 
 
 
 double_array :  
     /* Parameters:  
            r0  Number of items 
            r1  Address of the array 
     */ 
     push {r4, r5, r6, lr} 
   
     mov r4, #0      /* r4 ? 0 */ 
     mov r5, #32
   
     b .Lcheck_loop_array_double 
     .Lloop_array_double: 
       str r5, [r1, r4, LSL #2]   /* *(r1 + r4 * 4) ? r5 */ 
       add r5, r5, #5
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_array_double: 
       cmp r4, r0                 /* r4 - r0 and update cpsr */ 
       bne .Lloop_array_double    /* if r4 != r0 go to .Lloop_array_double */ 
   
     pop {r4, r5, r6, lr} 
   
     bx lr 
   
 print_each_item: 
     push {r4, r5, r6, r7, r8, lr} /* r8 is unused */ 
   
     mov r4, #0      /* r4 ? 0 */ 
     mov r6, r0      /* r6 ? r0. Keep r0 because we will overwrite it */ 
     mov r7, r1      /* r7 ? r1. Keep r1 because we will overwrite it */
     ldr r8, =0x8e38f 
   
   
     b .Lcheck_loop_print_items 
     .Lloop_print_items: 
       ldr r5, [r7, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
       mov r10, r5 
       sub r9, r5, #32
       mul r5, r9, r8
       mov r5, r5, ASR #20	
   
       /* Prepare the call to printf */ 
       ldr r0, address_of_message /* first parameter of the call to printf below */ 
       mov r1, r10      /* second parameter: item position */ 
       mov r2, r5      /* third parameter: item value */ 
       bl printf       /* call printf */ 
   
       str r5, [r7, r4, LSL #2]   /* *(r7 + r4 * 4) ? r5 */ 
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_print_items: 
       cmp r4, r6                 /* r4 - r6 and update cpsr */ 
       bne .Lloop_print_items       /* if r4 != r6 goto .Lloop_print_items */ 
   
     pop {r4, r5, r6, r7, r8, lr} 
     bx lr 
   
 main: 
     push {r4, lr} 
     /* we will not use r4 but we need to keep the function 8-byte aligned */ 
 	 
     /* call to double_array */ 
     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_big_array   /* second parameter: address of the array */ 
     bl double_array               /* call to double_array */ 
   
     /* second call print_each_item */ 
     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_big_array   /* second parameter: address of the array */ 
     bl print_each_item             /* call to print_each_item */ 
   
     pop {r4, lr} 
     bx lr 
   
 address_of_big_array : .word big_array 
 address_of_message : .word message 
