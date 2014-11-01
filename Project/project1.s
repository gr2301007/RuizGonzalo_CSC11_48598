/* 
   Gonzalo Ruiz
   project 1 */

.data 

message1: .asciz "Welcome to hangman...Guess a country name\n"
message2: .asciz "You have 5 tries to guess the word\n"
message3: .asciz "Sorry you've been hanged\n"
message4: .asciz "Congratulations you win!\n"
format:   .asciz "%c" 


.text 

.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */

    mov r0, #0
    bl time
    bl srand
    bl rand

    mov r1, r0

    ldr r0, address_of_format
    bl printf 
    
    end:
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr                       /* Leave main */ 
   
address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_format:   .word format