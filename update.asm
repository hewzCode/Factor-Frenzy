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

.globl update_check_array
update_check_array:

	move $t0, $s7
	move $t1, $s5
	move $t2, $s6
	
	
	li $t3, 0
	out_loop:
		# store array[i]
		lw $t4, 0($t1) 
		
		# store zeros_array[liste[i]]
		mul $t8, $t4, 4
        	add $t8, $t8, $t2
        	lw $t5, 0($t8)
        	
        	sw $t5, 0($t0)
        	
        	beq $t3, 35, exit1
        
        	#update to liste[i + 1]
        	addi $t1, $t1, 4
        	addi $t0, $t0, 4
        	addi $t3, $t3, 1
        	
        	j out_loop
        	
        	exit1:
        	jr $ra
