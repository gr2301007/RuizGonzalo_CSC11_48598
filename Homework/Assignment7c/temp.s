

.data 

m1:.asciz "Enter fahrenheit (32 - 212) as float: "
m2:.asciz "Celsius(Float multiplication) = %f\n"
message5: .asciz "Time it took: %d (secs)\n"
format:.asciz"%f"
f1:.float 9
f2:.float 5
f3:.float 32
f: .word 0

.text

.global main
main:

	push  {r4,lr}

	ldr r1,ad_f1
	vldr s9,[r1]

	ldr r0,ad_m1
	bl printf


	ldr r1,ad_f2
	vldr s10,[r1]


	ldr r0,ad_format
	ldr r1,ad_f
	bl scanf

	ldr r1,ad_f
	vldr s11,[r1]

	ldr r1,ad_f3
	vldr s12,[r1]

	ldr r7, =0x989680           /*Number of loops*/
     
     	mov r0, #0 
     	bl time
     	mov r9, r0

	loopFloat:
	    vsub.f32 s11,s11,s12
	    vmul.f32 s11,s10,s11
	    vdiv.f32 s11,s11,s9
	    sub r7, r7, #1
            cmp r7, #0
            bne loopFloat

	mov r0, #0 
        bl time
        mov r4, r0
        sub r6, r4, r9

	vcvt.f64.f32 d7,s11
	ldr  r0,ad_m2
	vmov r2,r3,d7
	bl printf

	mov r1, r6
        ldr r0, address_of_message5  /* Set &message5 as the first parameter of printf */ 
        bl printf                    /* Call printf */



	pop {r4,lr}
	bx lr

address_of_message5: .word message5
ad_m2:.word m2
ad_f:.word f
ad_f3:.word f3
ad_f1:.word f1
ad_f2:.word f2
ad_m1:.word m1
ad_format:.word format

