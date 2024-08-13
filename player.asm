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
	second: .asciiz "\nSecond Number: "
	prompt2: .asciiz "\n\nEnter 1 to change the first number: \nEnter 2 to change the second number: \nUser input: "
	valid: .asciiz "\nPlease enter a valid number 1 or 2 to change the numbers!\n"
	wrong22: .asciiz "\nWrong Input for second number\nPlease enter a new number between 1-9\n"
	wrong11:	.asciiz "\nWrong Input for first number\nPlease enter a new number between 1-9\n"
	chs: .asciiz "\nThis number is choosen, please enter a valid number!\n"
.text

.globl player_choose
.globl change_first_number
.globl change_second_number
.globl invalid

chosens:
	li $v0, 4
	la $a0, chs
	syscall
	j player_choose
	
invalid:
	li $v0, 4
	la $a0, valid
	syscall
	
player_choose:

	li $v0, 4
	la $a0, prompt2
	syscall
	
	chos:
	li $v0, 5
	syscall
	move $s0, $v0


	blt $s0, 1, invalid
	bgt $s0, 2, invalid
	# Check user input and execute corresponding code
        beq $s0, 1, change_first_number
        beq $s0, 2, change_second_number
        
        update_zero_array:
       	li $t5, 2
       	sw $t5, 0($s3)
       	
	jr $ra
	
wrong_input1:
	li $v0, 4
	la $a0, wrong11
	syscall
	
change_first_number:
        # Code to change the first number
        li $v0, 4
        la $a0, first
        syscall
        
        li $v0, 5           # System call code for read_int
        syscall             # Make system call
        move $t6, $v0
        
        
        bgt $t6, 9, wrong_input1
        blt $t6, 1, wrong_input1
        
        mul $s3, $t6, $s2
        mul $s3, $s3, 4
         
       	add $s3, $s6, $s3
       	lw $t7, 0($s3)
       	
       	bne $t7, 0, chosens
       
       	
        move $s1, $t6       # Move user input to $t1
      	
        # Use $t1 as the new value for the first number
        j update_zero_array
        
wrong_input2:
	li $v0, 4
	la $a0, wrong22
	syscall
	
 change_second_number:
        # Code to change the second number
        li $v0, 4
        la $a0, second
        syscall
        
        li $v0, 5           # System call code for read_int
        syscall             # Make system call
        move $t6, $v0
        
        
        bgt $t6, 9, wrong_input2
        blt $t6, 1, wrong_input2
        
        mul $s3, $t6, $s1
        mul $s3, $s3, 4
         
       	add $s3, $s6, $s3
       	lw $t7, 0($s3)
       	
       	bne $t7, 0, chosens
        move $s2, $t6       # Move user input to $t2
       
        # Use $t2 as the new value for the second number
       	j update_zero_array
