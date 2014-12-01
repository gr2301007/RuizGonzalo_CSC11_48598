


.data

value1: .float 0.55556
message11: .asciz "\nCelsius(Float multiplication) = %f\n"

.text

.global main
main:
	
	ldr r1, =value1
	vldr s2, [r1]

	vcvt.f64.f32 d0, s2
	
	ldr r0, =message11
	vmov r2, r3, d0
	bl printf

	mov r7, #1
	swi 0

addr_value1: .word value1

