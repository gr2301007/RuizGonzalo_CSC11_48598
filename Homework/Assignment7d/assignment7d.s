/*  
    Gonzalo Ruiz
    Assignment7d
 */
 
 .data 

 .balign 4 
 f1:.float 32.0 
.balign 4 
 f2:.float 5.0 
 .balign 4 
 f3:.float 9.0 


.align 4 
 array : 
 .skip 152 

.align 4 
 f_array : 
 .skip 152 

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
     mov r5, #32
   
     b .Lcheck_loop_f_array 
     .Lloop_f_array: 

       vmov s0, r5
       vcvt.f32.s32 s1,s0 
       vmov r7, s1 
       str r7, [r1, r4, LSL #2]

       add r5, r5, #5

      add r4, r4, #1             /* r4 ? r4 + 1 */ 
      .Lcheck_loop_f_array: 
       cmp r4, r0                 /* r4 - r0 and update cpsr */ 
       bne .Lloop_f_array    /* if r4 != r0 go to .Lloop_array_double */ 
   
     pop {r4, r5, r6, lr} 
   
     bx lr 


print_each_item: 
     push {r4, r5, r6, r7, r8, lr} /* r8 is unused */ 
   
     mov r4, #0      /* r4 ? 0 */ 
     mov r6, r0      /* r6 ? r0. Keep r0 because we will overwrite it */ 
     mov r7, r1      /* r7 ? r1. Keep r1 because we will overwrite it */
     mov r11, r2
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
       vmov s14,r5 

       ldr r2,=f1 
       vldr s0,[r2] 
 
       vsub.f32  s0,s14,s0   @begin convert F to C 
 
       ldr r2,=f2 
       vldr s4,[r2] 
       vmul.f32 s0,s4,s0 
 
 
       ldr r2,=f3 
       vldr s6,[r2] 
       vdiv.f32 s0,s0,s6 
 
 
       vcvt.f64.f32 d6,s0 
       vmov r2,r3,d6 
       ldr r0, address_of_message1
       bl printf 
 
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
     bl float_array               /* call to double_array */  

     
     /* second call print_each_item */ 
     mov r0, #37                   /* first_parameter: number of items */ 
     ldr r1, address_of_array   /* second parameter: address of the array */
     ldr r2, address_of_f_array   /* second parameter: address of the array */
     bl print_each_item             /* call to print_each_item */ 
   
     pop {r4, lr} 
     bx lr 
   
address_of_array : .word array
address_of_f_array : .word f_array
address_of_message : .word message
address_of_message1 : .word message1


