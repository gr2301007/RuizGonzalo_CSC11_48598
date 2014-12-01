


.data

value1: .float 0.55556
message11: .asciz "\nCelsius(Float multiplication) = %f\n"

.text

.global main
main:
	mov r0, #100
	sub r2, r0, #32
	vldr s0, [r2]
	
	ldr r1, =value1
	vldr s1, [r1]

	vmul.f32 s2, s0, s1
	vcvt.f64.f32 d2, s2
	
	ldr r0, =message11
	vmov r2, r3, d2
	bl printf

	mov r7, #1
	swi 0

addr_value1: .word value1

