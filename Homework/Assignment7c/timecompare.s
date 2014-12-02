.data
m1:.asciz"enter the temperature in F int\n"
m4:.asciz"enter the temperature in F float\n"
m2:.asciz"The temperature in C is %d\n"
m5:.asciz"The tremperature in C is %f\n"
m3:.asciz"It take %d seconds\n"
format:.asciz"%d"
format1:.asciz"%f"
.balign 4
store1:.word 0
store2:.word 0
store3:.word 0
f1:.float 9
f2:.float 5
f3:.float 32
f: .word 0

.text

.global main
main:
push {r10,lr}


ldr r0,ad_m1
bl printf

ldr r0,ad_format
ldr r1,ad_store1
bl scanf            @temperature in F

ldr r0,ad_m4
bl printf

ldr r0,ad_format1
ldr r1,ad_store2
bl scanf            @temperature in F

ldr r6,=10000  @loop times

mov r0,#0
bl time
mov r11,r0       @r11 recoder begin time, r12 recorder the end time

loopshift:
cmp r6,#0
ble second


ldr r1,ad_f1
vldr s9,[r1]

ldr r1,ad_f2
vldr s10,[r1]

ldr r1,ad_store2
vldr s11,[r1]

ldr r1,ad_f3
vldr s12,[r1]

vsub.f32 s11,s11,s12
vmul.f32 s11,s10,s11
vdiv.f32 s11,s11,s9

sub r6,r6,#1
b loopshift

second:

mov r0,#0
bl time
mov r12,r0

sub r12,r12,r11

ldr r0,ad_m3
mov r1,r12
bl printf          @take time


vcvt.f64.f32 d7,s11
ldr  r0,ad_m5
vmov r2,r3,d7
bl printf



ldr r6,=10000  @loop times

mov r0,#0
bl time
mov r11,r0

divloop:
cmp r6,#0
ble final


mov r2,#0
mov r4,#0
mov r5,#0
ldr r1,ad_store1
ldr r1,[r1]

mov r2,#5
sub  r1,r1,#32
mul r1,r2,r1

mov r2,#9

bl div

mov r4,r0
mov r5,r1
sub r6,r6,#1
b divloop

final:
mov r0,#0
bl time
mov r12,r0


sub r12,r12,r11

ldr r0,ad_m3
mov r1,r12
bl printf   


ldr r0, ad_m2
mov r1,r4
bl printf

pop {r10,lr}
bx lr
ad_f:.word f
ad_f3:.word f3
ad_f1:.word f1
ad_f2:.word f2
ad_m1:.word m1
ad_m2:.word m2
ad_m3:.word m3
ad_m4:.word m4
ad_store3:.word store3
ad_format:.word format
ad_store1:.word store1
ad_store2:.word store2
ad_format1:.word format1
ad_m5:.word m5
.global printf
.global scanf
