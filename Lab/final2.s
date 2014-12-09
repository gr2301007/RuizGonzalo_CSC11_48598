 .data 
 m1:.asciz"please input the number of years (1-20)\n" 
 m2:.asciz"please input the interest rate (0.05-0.1)\n" 
 m3:.asciz"please input the present value (int 1000-5000)\n" 
 m4:.asciz"value include interests in these years are: %f\n" 
 .balign 4 
 ints:.word 0 
 @.balign 4 
 @ints1:.word 0 
 
 
 .balign 4 
 floats:.word 0 
 .balign 4 
 f:.float 1.0 
 
 
 format:.asciz"%d" 
 formatf:.asciz"%f" 
 .balign 4 
 a:.skip  100 
 .text 
 .global fv 
 fv: 
 
 
 push {r4,lr} 
 ldr r0,=m1 
 bl printf 
 
 
 ldr r0,=format 
 ldr r1,=ints 
 bl scanf 
 
 
 ldr r0,=ints 
 ldr  r5,[r0]  @r5 save the number of the years 
 

 ldr r0,=m2 
 bl printf 
 
 
 ldr r0,=formatf 
 ldr r1,=floats 
 bl scanf 
 
 
 ldr r0,=floats 
 vldr s0,[r0] @s0 store the interest 
 
 
 ldr r0,=m3 
 bl printf 
 
 
 ldr r0,=format 
 ldr r1,=ints 
 bl scanf 
 
 
 ldr r0,=ints 
 ldr r6,[r0]  @present value 
 
 
 ldr r0,=f 
 vldr s6,[r0] 
 
 
 mov r8,#0 @ array index 
 
 
 vmov s2,r6  @prepare to convert to float 
 vcvt.f32.s32 s4,s2       @s4  is present value 
 loop: 
 vadd.f32  s10,s0,s6  @s6=1.0 s0 is interest 
 vmul.f32  s4,s10,s4 
 
 
 ldr r1,=a 
 
 
 vmov r9,s4     @mov float back ready to store in array 
 str r9,[r1,r8,lsl#2] 
 add r8,r8,#1 
 sub r5,r5,#1 
 
 
 cmp r5,#0 
 bgt  loop 
 
 
 outloop: 
 ldr r11,=a 
 ldr r0,[r11,r5,lsl#2]     @float number in the  array 
 vmov s3,r0               @ready to print out 
 vcvt.f64.f32 d5,s3 
 ldr r0,=m4 
 vmov r2,r3,d5 
 bl printf 
 
 
 add r5,r5,#1 
 cmp r5,r8 
 bne outloop 
 
 
 end: 
 pop {r4,lr} 
 bx lr 
  
