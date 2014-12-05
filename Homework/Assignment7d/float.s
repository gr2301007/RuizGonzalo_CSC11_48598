 .data 
 
 
 m1:.asciz"the temperature F  is %f \n" 
 m2:.asciz"The C-temperatrue is %f \n" 
 
 
 .balign 4 
 f1:.float 32.0 
.balign 4 
 f2:.float 5.0 
 .balign 4 
 f3:.float 9.0 
 
 
 .balign 4 
 first:.skip 200 
 .text 
 
.global main 
 main: 
 push {r4,lr} 
 
 ldr r9,=first 
 mov r10,#0 
 mov r5,#212 
 mov r6,#32 
 
 loop: 
 vmov s0,r6      @prepare for conversion 
 vcvt.f32.s32 s1,s0   @convert to float 
 vmov r7, s1 
 str r7, [r9,r10,lsl#2] 
 
 add r10,r10,#1 
 add r6,r6,#5 
 cmp r6,r5 
 ble loop 
 
 mid: 
 
 
 mov r11,#0 
 loop1: 
 ldr r9,=first 
 
 
ldr r1,[r9,r11,lsl#2] 
 vmov s14,r1 
 
 
 vcvt.f64.f32 d5,s14 
 vmov r2,r3,d5 
 ldr r0,=m1		@out in array 
 bl printf 
 

 ldr r1, [r9, r11, lsl#2] 
 vmov s14,r1         @move float to s prepare to calculate 
 add r11, r11, #1 
 
 
 ldr r2,=f1 
 vldr s0,[r2] 
 
 vsub.f32  s0,s14,s0   @begin convert F to C 
 
 
 ldr r2,=f2 
 vldr s4,[r2] 
 vmul.f32 s0,s4,s0 
 
 
 ldr r2,=f3 
 vldr s6,[r2] 
 vdiv.f32 s0,s0,s6 
 
 
 ldr r0,=m2 
 vcvt.f64.f32 d6,s0 
 vmov r2,r3,d6 
 bl printf 
 
cmp r10,r11 
 bne loop1 
 
 
 pop {r4,lr} 
 bx lr 
 
 ad_m1:.word m1 
 ad_m2:.word m2 
 addr_f1:.word f1 
 ad_first:.word first 
 .global printf 
 .global scanf  
