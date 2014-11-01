/* 
   Gonzalo Ruiz
   project 1 */

.data 

message1: .asciz "%c "
message2: .asciz "Welcome to hangman...Guess a country name\n"
message3: .asciz "You have 5 tries to guess the word\n"
message4: .asciz "\n\nPick a letter: "
message5: .asciz "\nThat letter isn't in the word\n"
message6: .asciz "You have %d guesses left\n"
message7: .asciz "Sorry you've been hanged\n"
message8: .asciz "Congratulations you win!\n"
message9: .asciz "\nYou already used that letter\n"
format:   .asciz " %c" 

.text 

.globl main 

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */

    mov r4, #95			 /* Cover word with "_" ascii code 95 */
    mov r5, #95
    mov r6, #95
    mov r7, #95
    mov r8, #95
    mov r9, #5			 /*length of the word*/
    mov r10, #5			 /*Guesses left */

    ldr r0, address_of_message2
    bl printf
    ldr r0, address_of_message3
    bl printf 
    
    loop:
       mov r1, r4
       ldr r0, address_of_message1  /* Set &message1 as the first parameter of printf */ 
       bl printf                    /* Call printf */ 

       mov r1, r5
       ldr r0, address_of_message1
       bl printf 

       mov r1, r6
       ldr r0, address_of_message1
       bl printf 

       mov r1, r7
       ldr r0, address_of_message1
       bl printf 

       mov r1, r8
       ldr r0, address_of_message1
       bl printf 
    
       ldr r0, address_of_message4
       bl printf 

       ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
       mov r1, sp                   /* Set the top of the stack as the second parameter */
                                    /* of scanf */
       bl scanf                     /* Call scanf */
       ldr r1, [sp]		    /* Load character read into r1*/

       cmp r1, #99
       beq letter_c

       cmp r1, #104
       beq letter_h

       cmp r1, #105
       beq letter_i

       cmp r1, #110
       beq letter_n

       cmp r1, #97
       beq letter_a
    
       b wrong

    letter_c:
	cmp r1, r4
	beq repeated
	mov r4, r1
	sub r9, r9, #1
	b test
    letter_h:
	cmp r1, r5
	beq repeated
	mov r5, r1
	sub r9, r9, #1
	b test
    letter_i:
	cmp r1, r6
	beq repeated
	mov r6, r1
	sub r9, r9, #1
	b test
    letter_n:
	cmp r1, r7
	beq repeated
	mov r7, r1
	sub r9, r9, #1
	b test
    letter_a:
	cmp r1, r8
	beq repeated
	mov r8, r1
	sub r9, r9, #1
	b test

    repeated:
	ldr r0, address_of_message9
        bl printf
	b loop
	

    wrong:
	sub r10, r10, #1
        cmp r10, #0
        beq lose

        ldr r0, address_of_message5
        bl printf 

        mov r1, r10
        ldr r0, address_of_message6
        bl printf 

    test:
       cmp r9, #0
       bne loop
    
    ldr r0, address_of_message8
    bl printf
    b end

    lose:
    ldr r0, address_of_message7
    bl printf
    
    end:
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr                       /* Leave main */ 
   
address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_message6: .word message6
address_of_message7: .word message7
address_of_message8: .word message8
address_of_message9: .word message9
address_of_format:   .word format
