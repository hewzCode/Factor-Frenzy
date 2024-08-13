.data
prompt1: .asciiz "\t\tPlayer  : {}   Bot : []"
    newline:    .asciiz "\n"
    space:      .asciiz " "
    p1:         .asciiz "{"
    p2:         .asciiz "}"
    b1:         .asciiz "["
    b2:         .asciiz "]"
    
    	player_won: .asciiz "\n\nPlayer Won!!"
    	bot_won: .asciiz "\n\nBot Won!!"
	first: .asciiz "\nFirst Number: "
	second: .asciiz "   Second Number: "
	prompt2: .asciiz "\n\nEnter 1 to change the first number: \nEnter 2 to change the second number: \nUser input: "
.text
.globl game_loop
.globl  b_continue
.globl p_continue

game_loop:
        # Call print_number_table function
        jal print_header
        jal print_number_table
        # Call player_choose function
        jal player_choose
        jal update_check_array
        pla:
        li $t9, 2
	jal check_win_condition
	p_continue:
        # Call print_number_table function
        #jal print_number_table

        # Call bot_choose function
        jal bot_choose
        jal update_check_array
        bo: 
        li $t9, 1
        jal check_win_condition
        b_continue:
        # Jump back to the game loop
        j game_loop

        # Exit the program
        li $v0, 10
        syscall