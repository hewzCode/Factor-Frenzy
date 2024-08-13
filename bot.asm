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

.globl bot_choose
bot_choose:

	li $v0, 42  # 42 is system call code to generate random int
	li $a1, 2 # $a1 is where you set the upper bound
	syscall     # your generated number will be at $a0
	
	move $t0, $a0
	
	
	li $v0, 42  # 42 is system call code to generate random int
	li $a1, 8 # $a1 is where you set the upper bound
	syscall     # your generated number will be at $a0
	
	move $t1, $a0
	
	# Add one to the random number 0-8 - > 1-9
	addi $t1, $t1, 1
	
	beq $t0, 1, change_first_number_bot
	
	mul $s3, $t1, $s1
       	mul $s3, $s3, 4
        
       	add $s3, $s6, $s3
       	li $t4, 1
       	lw $t5, 0($s3)
       	
       	bne $t5, $zero, bot_choose
       	move $s2, $t1
       	sw $t4, 0($s3)
	jr $ra
	
	change_first_number_bot:
	
	mul $s3, $t1, $s2
       	mul $s3, $s3, 4
        
       	add $s3, $s6, $s3
       	li $t4, 1
       	lw $t5, 0($s3)
       	
       	bne $t5, $zero, bot_choose
       	move $s1, $t1
       	
       	sw $t4, 0($s3)
	jr $ra