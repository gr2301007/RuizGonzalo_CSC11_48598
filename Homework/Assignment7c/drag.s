.data
m1:.asciz"Floating Dynamic Pressure=%f lbs\n"
m2:.asciz"Cross Sectional Area*32 =%f fit^2\n"
m3:.asciz"Floating Drag*32=%f lbs\n"
m4:.asciz"Enter the v\n"
m5:.asciz"Enter the radius\n"
f1:.float 0.5
f2:.float 0.00237
f3:.float 3.1415926
f4:.float 0.0069444
f5:.float 0.4
f6:.float 32.0
format:.asciz"%f"
.balign
store:.word 0
.balign
store1:.word 0

.text
.global main
main:
push {lr}

ldr r0,ad_m4
bl printf

ldr r0,ad_foramt
ldr r1,ad_store
bl scanf

ldr r0,ad_m5
bl printf

ldr r0, ad_foramt
ldr r1,ad_store1
bl scanf

ldr r1,ad_f1
vldr s14,[r1]
vcvt.f64.f32 d4,s14  @d4:fhalf

ldr r1,ad_f2
vldr s14,[r1]
vcvt.f64.f32 d5,s14  @d5:frho

ldr r1,ad_f3
vldr s14,[r1]
vcvt.f64.f32 d6,s14   @d6:pi

ldr r1,ad_f4
vldr s24,[r1]
vcvt.f64.f32 d7,s24   @Conv

ldr r1,ad_f5
vldr s24,[r1]
vcvt.f64.f32 d8,s24   @Cd


ldr r1,ad_store
vldr s24,[r1]
vcvt.f64.f32 d9,s24   @vel


ldr r1,ad_store1
vldr s24,[r1]
vcvt.f64.f32 d10,s24 @radius

vmul.f64 d4,d5,d4 
vmul.f64 d4,d9,d4
vmul.f64 d4,d9,d4    @dynp

vmul.f64 d6,d10,d6
vmul.f64 d6,d10,d6
vmul.f64 d6,d7,d6  @area


vmul.f64 d11,d6,d4
vmul.f64 d11,d8,d11@drag

ldr r1,ad_f6
vldr s24,[r1]
vcvt.f64.f32 d5,s24
vmul.f64  d6,d5,d6
vmul.f64  d11,d5,d11


ldr r0,ad_m1
vmov r2,r3,d4
bl printf


ldr r0,ad_m2
vmov r2,r3,d6
bl printf

ldr r0,ad_m3
vmov r2,r3,d11
bl printf


pop {lr}
bx lr



.global printf
.global scanf


ad_m1:.word m1
ad_m2:.word m2
ad_m3:.word m3
ad_m4:.word m4
ad_m5:.word m5
ad_f1:.word f1
ad_f2:.word f2
ad_f3:.word f3
ad_f4:.word f4
ad_f5:.word f5
ad_f6:.word f6
ad_foramt:.word format
ad_store:.word store
ad_store1:.word store1
