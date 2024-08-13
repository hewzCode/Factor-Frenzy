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

.globl print_header
.globl print_number_table

print_header:
   	li $v0, 4
   	la $a0, first
   	syscall
   	
   	li $v0, 1
   	move $a0, $s1
   	syscall
   	
   	li $v0, 4
   	la $a0, second
   	syscall
   	
   	li $v0, 1
   	move $a0, $s2
   	syscall 
   	
   	li $v0, 4
   	la $a0, newline
   	syscall 
   	
   	li $v0, 4
   	la $a0, newline
   	syscall 
   	
   	jr $ra
   	   	
print_number_table:
    # Arguments:
    # $a0 - address of the vector (liste)
    # $a1 - address of the zeros_array
    # $a2 - size of the vector (liste)
    
    move $s3, $s5
    move $s4, $s6

    li $t0, 0           # temp = 0
    li $t1, 0
    li $t2, 0
    
    # Loop through the vector
    loop:
    	
        # Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
        
        # Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
        
	# Store array[i] to $t3
        lw $t3, 0($s3) 
        
        # Store zeroes_array[array[i]] to $t5
        mul $t8, $t3, 4
        add $t8, $t8, $s4
        lw $t5, 0($t8)
        
        #move $t5, $zero
        #li $t5, 2
        
        bne $t5, $zero, choosen
        
        bgt $t3, 9, zero_print 
        # Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
        
   	j zero_print
        
        choosen:
       	beq $t5, 2, player_number	
       	la $t6, b1
       	la $t7, b2
       	j skip_player_number
       	
       	player_number:
       	la $t6, p1
       	la $t7, p2
       	
       	skip_player_number:
      	bgt $t3, 9, other_num_print
      	
      	# Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
      	
      	j other_num_print
      	
        # Print the number
        update:
        beq $t1, 35, continue
        
        #update to liste[i + 1]
        addi $s3, $s3, 4
        addi $t1, $t1, 1
        addi $t2, $t2, 1
        
        beq $t2, 6, new_column
        j loop
        
        new_column:
        
        # Print bot player header
        bne $t1, 6, skip_header
        
    	li $v0, 4
    	la $a0, prompt1
    	syscall
    	
    	skip_header:
    	
        # Print leading spaces
        li $v0, 4
        la $a0, newline
        syscall
        
        # Update the value for counting numbers in row
        li $t2, 0
        j loop
        
	continue:
	jr $ra
	
other_num_print:
        li $v0, 4
        move $a0, $t6
        syscall
        
        # Print the number
        li $v0, 1
        move $a0, $t3
        syscall
        
        li $v0, 4
        move $a0, $t7
        syscall
        
        j update
        
zero_print:

	# Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
        
        # Print the number
        li $v0, 1
        move $a0, $t3
        syscall
        
        # Print leading spaces
        li $v0, 4
        la $a0, space
        syscall
        
        j update
