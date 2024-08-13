.data
array:   	.word   1, 2, 3, 4, 5, 6
            	.word   7, 8, 9, 10, 12, 14
            	.word   15, 16, 18, 20, 21, 24
            	.word   25, 27, 28, 30, 32, 35
            	.word   36, 40, 42, 45, 48, 49
            	.word   54, 56, 63, 64, 72, 81
            	
zeros_array:    .space 324
check_array: 	.space 144
		
    prompt1: .asciiz "\t\tPlayer  : {}   Bot : []"
    newline:    .asciiz "\n"
    space:      .asciiz " "
    p1:         .asciiz "{"
    p2:         .asciiz "}"
    b1:         .asciiz "["
    b2:         .asciiz "]"
    
    	player_won: .asciiz "\n\nPlayer Won!!"
    	bot_won: .asciiz "\n\nBot Won!!"
	first: .asciiz "\nNew First Number: "
	second: .asciiz "\nNew Second Number: "
	prompt2: .asciiz "\n\nEnter 1 to change the first number: \nEnter 2 to change the second number: \nUser input: "
	
.text

.globl main
main:
	la $s5, array
	la $s6, zeros_array
	la $s7, check_array
	
	jal setup
	jal game_loop
