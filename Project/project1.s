/* 
   Gonzalo Ruiz
   project 1 */

.data 

message1: .asciz "Welcome to hangman...Guess a country name\n"
message2: .asciz "You have 5 tries to guess the word\n"
message3: .asciz "Sorry you've been hanged\n"
message4: .asciz "Congratulations you win!\n"
message5: .asciz "The word was: "
message6: .asciz "China\n"
message7: .asciz "Spain\n"
message8: .asciz "Iraq\n"
message9: .asciz "Haiti\n"
message10: .asciz "Cuba\n"



.text 

.globl main 

main: 
    push {lr}

    ldr r0, address_of_message1
    bl printf 

    ldr r0, address_of_message2
    bl printf 

    mov r0, #0
    bl time
    bl srand
    bl rand
    mov r1, r0, ASR #1
    mov r2, #5
    bl divMod
    add r1, #1

    mov r1, #1

    cmp r1, #1
    beq w1
    cmp r1, #2
    beq w2
    cmp r1, #3
    beq w3
    cmp r1, #4
    beq w4
    cmp r1, #5
    beq w5

    w1:
    bl word1
    b test
    w2:
    w3:
    w4:
    w5:


    test:
    cmp r0, #1
    beq lose
    
    ldr r0, address_of_message4
    bl printf
    b output

    lose:
    ldr r0, address_of_message3
    bl printf

    output:
    ldr r0, address_of_message5
    bl printf 

    cmp r1, #1
    beq o1
  
    cmp r1, #2
    beq o2
   
    cmp r1, #3
    beq o3
   
    cmp r1, #4
    beq o4
   
    cmp r1, #5
    beq o5

    o1:
    ldr r0, address_of_message6
    bl printf 
    b end
    o2:
    o3:
    o4:
    o5:
    
    
    

    end:
    pop {lr}             /* Leave main */ 
   
address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_message6: .word message6
address_of_message7: .word message7
address_of_message8: .word message8
address_of_message9: .word message9
address_of_message10: .word message4

