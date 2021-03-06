/* 
   Gonzalo Ruiz
   project 1, word1 */

.data 

message1: .asciz "%c "
message2: .asciz "\n\nPick a letter: "
message3: .asciz "\nThat letter isn't in the word\n"
message4: .asciz "You have %d guesses left\n"
message5: .asciz "\nYou already used that letter\n"
format:   .asciz " %c" 

.text 

.global main

main: 
    str lr, [sp,#-4]!            /* Push lr onto the top of the stack */ 
    sub sp, sp, #4               /* Make room for one 4 byte integer in the stack */

    mov r4, #95			 /* Cover word with "_" ascii code = 95 */
    mov r5, #95
    mov r6, #95
    mov r7, #95
    mov r9, #4			 /*length of the word*/
    mov r10, #5			 /*Guesses left */

    loop:
	/* Print the word one character at a time (no arrays yet) */
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

       ldr r0, address_of_message2
       bl printf 

       ldr r0, address_of_format    /* Set &format as the first parameter of scanf */
       mov r1, sp                   /* Set the top of the stack as the second parameter */
                                    /* of scanf */
       bl scanf                     /* Call scanf */
       ldr r11, [sp]		    /* Load character read into r0 */

       cmp r11, #105		    /* letter i, ascii code = 105 */
       beq letter_i

       cmp r11, #114		    /* letter r, ascii code = 114 */
       beq letter_r

       cmp r11, #97		    /* letter a, ascii code = 97 */
       beq letter_a

       cmp r11, #113		    /* letter q, ascii code = 113 */
       beq letter_q

       b wrong			    /* If none of this, the letter is not in the word */

    letter_i:
	cmp r11, r4		    /* check if letter is already used in the word */
	beq repeated
	mov r4, r11		    /* replace '_' with the correct letter */
	sub r9, r9, #1		    /* decrease size of word by one (letter is correct) */
	b test			    /* test the condition to repeat the loop */
    letter_r:
	cmp r11, r5
	beq repeated
	mov r5, r11
	sub r9, r9, #1
	b test
    letter_a:			    /* do this for every single character in the word */
	cmp r11, r6
	beq repeated
	mov r6, r11
	sub r9, r9, #1
	b test
    letter_q:
	cmp r11, r7
	beq repeated
	mov r7, r11
	sub r9, r9, #1
	b test
    
    repeated:				/* letter already used */
	ldr r0, address_of_message5
        bl printf
	b loop
	

    wrong:
	sub r10, r10, #1		/* if wrong decrease guesses left by one*/
        cmp r10, #0			/* if gueses left = 0, user loses */
        beq lose

        ldr r0, address_of_message3
        bl printf 

        mov r1, r10
        ldr r0, address_of_message4
        bl printf 

    test:
       cmp r9, #0		/* if size of word = 0, no more letters to guess (win) */
       bne loop
    
    mov r0, #0			/* if win, return 0 */
    b end

    lose:
    mov r0, #1			/* if lose return 1 */
    
    end:
     add sp, sp, #4              /* Discard the integer read by scanf */     
     ldr lr, [sp], #+4           /* Pop the top of the stack and put it in lr */ 
     bx lr                       /* Leave word3 */ 
   
address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_format:   .word format


