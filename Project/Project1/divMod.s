

.text 

scaleRight: 
 	push {lr}             
 	loop:     
 		mov r3,r3,ASR #1
 		mov r2,r2,ASR #1 
 	cmp r1,r2 
 	blt loop 
 	pop {lr}
     bx lr
  
 
addSub: 
 	push {lr} 
 	loop2: 
 		add r0,r0,r3 
 		sub r1,r1,r2 
 		bl scaleRight 
 	cmp r3,#1 
 	bge loop2 
     pop {lr} 
     bx lr 

 
scaleLeft: 
 	push {lr}  
 	loop3:   
 		mov r3,r3,LSL #1 
 		mov r2,r2,LSL #1 
 		cmp r1,r2 
 	bge loop3 
 	mov r3,r3,ASR #1  
 	mov r2,r2,ASR #1   
 	pop {lr}  
     bx lr  
  
 
.global divMod

divMod: 
 	push {lr}  
 	
 	mov r0,#0 
 	mov r3,#1 
 	cmp r1,r2 
 	blt end 
 		bl scaleLeft 
 		bl addSub 
 	end: 
 	pop {lr}  
     bx lr 

