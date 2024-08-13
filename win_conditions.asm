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

.globl check_win_condition
.globl check_final
.globl win
.globl check_others
.globl check_row

check_win_condition:
	jal check_row
	check_col:
	li $t8, 24
	jal check_others
	check_dia_left:
	li $t8, 20
	jal check_others
	check_dia_right:
	li $t8, 28
	jal check_others
	
	j check_final
	
check_final:
	beq $t9, 2, asd
	j b_continue
	asd:
	j p_continue
	
win:	

	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	beq $t9, 2, p_won
	la $t0, bot_won
	j fin
	p_won:
	la $t0, player_won
	
	fin:
	
	li $v0, 4
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	
check_row:
	
	move $t0, $s7
	
	li $t1, 0 	# temp
	li $t2, 0	# max
	li $t3, 0	# i
	
	loop_row:
		# $t4 = check_row[i]
		lw $t4, 0($t0)
	
		beq $t4, $t9, increase
		bgt $t1, $t2, update_max
		li $t1, 0
		j finish
		
		update_max:
		move $t2, $t1
		li $t1, 0
		j finish
		
		increase:
		addi $t1, $t1, 1
		
		finish:
		
		beq $t3, 35, devam
		
		addi $t3, $t3, 1
		addi $t0, $t0, 4
		
		j loop_row
		
		devam:
		
		bge $t1, 4, win
		bge $t2, 4, win
		
		jr $ra
		
		
check_others:
	move $t0, $s7

	li $t1, 0	# max
	li $t2, 0	# i
	li $t3, 0	# temp
	
	loop_other:
		# $t4 = check_array[i]
		lw $t4, 0($t0)
		
		bne $t4, $t9, bitir
		move $t5, $t2
		move $t6, $t0
		
		while_loop:
			bge $t5, 36, updat
			lw $t7, 0($t6)
			bne $t7, $t9, updat
			
			addi $t5, $t5, 6
			add $t6, $t6, $t8
			addi $t3, $t3, 1
			
			j while_loop
		
		updat:
		ble $t3, $t1, skip_upd
		move $t1, $t3
		
		skip_upd:
		li $t3, 0
		
		bitir:
		beq $t2, 35, devam_iki
		addi $t2, $t2, 1
		addi $t0, $t0, 4
		
		j loop_other
		
		devam_iki:
	
		bge $t1, 4, win
		bge $t3, 4, win
		
		jr $ra
