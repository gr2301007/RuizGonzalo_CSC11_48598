/*  
    Gonzalo Ruiz
    Assignment7d
 */
 
 .data 

value1: .float 32
value2: .float 5
value3: .float 0.55556

.align 4 
 array : 
 .skip 148 

.align 4 
 f_array : 
 .skip 148 


.align 4 
message: .asciz "fahrenheit = %d, celsius(int) = %d " 
message1: .asciz "float = %f\n" 


.text 
 .globl main 
 
 
 fill_array :  
     /* Parameters:  
            r0  Number of items 
            r1  Address of the array 
     */ 
     push {r4, r5, r6, lr} 
   
     mov r4, #0      /* r4 ? 0 */ 
     mov r5, #32
   
     b .Lcheck_loop_array 
     .Lloop_array: 
       str r5, [r1, r4, LSL #2]   /* *(r1 + r4 * 4) ? r5 */ 
       add r5, r5, #5
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_array: 
       cmp r4, r0                 /* r4 - r0 and update cpsr */ 
       bne .Lloop_array    /* if r4 != r0 go to .Lloop_array_double */ 
   
     pop {r4, r5, r6, lr} 
   
     bx lr 

float_array :  
     /* Parameters:  
            r0  Number of items 
            r1  Address of the array 
     */ 
     push {r4, r5, r6, lr} 
   
     mov r4, #0      /* r4 ? 0 */ 
     ldr r5, =value1
     ldr r6, =value2
     vldr s15, [r6]
   
     b .Lcheck_loop_float_array 
     .Lloop_float_array: 
       str r5, [r1, r4, LSL #2]   /* *(r1 + r4 * 4) ? r5 */

       vldr s14, [r5]
       vadd.f32 s14, s14, s15
       vmov s14, s15, r5, r6
       
       add r4, r4, #1             /* r4 ? r4 + 1 */ 
     .Lcheck_loop_float_array: 
       cmp r4, r0                 /* r4 - r0 and update cpsr */ 
       bne .Lloop_float_array    /* if r4 != r0 go to .Lloop_array_double */ 
   
     pop {r4, r5, r6, lr} 
   
     bx lr 

 print_each_item: 
     push {r4, r5, r6, r7, r8, lr} /* r8 is unused */ 
   
     mov r4, #0      /* r4 ? 0 */ 
     mov r6, r0      /* r6 ? r0. Keep r0 because we will overwrite it */ 
     mov r7, r1      /* r7 ? r1. Keep r1 because we will overwrite it */
     mov r11, r2     /* r11 ? r2. Keep r2 because we will overwrite it */
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

       ldr r5, [r11, r4, LSL #2]
       vldr s14, [r5]
       vcvt.f64.f32 d5, s14

       ldr r0, address_of_message1 /* first parameter of the call to printf below */ 
       vmov r2, r3, d5
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
     
     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_array   /* second parameter: address of the array */ 
     bl fill_array               /* call to double_array */ 

     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_f_array   /* second parameter: address of the array */ 
     bl float_array   
   
     /* second call print_each_item */ 
     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_array   /* second parameter: address of the array */
     ldr r2, address_of_f_array
     bl print_each_item             /* call to print_each_item */ 
   
     pop {r4, lr} 
     bx lr 
   
address_of_array : .word array
address_of_f_array : .word f_array
address_of_message : .word message
address_of_message1 : .word message1

