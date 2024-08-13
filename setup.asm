.data

.text

.globl setup

setup:
	li $v0, 42  # 42 is system call code to generate random int
	li $a1, 8 # $a1 is where you set the upper bound
	syscall     # your generated number will be at $a0
	
	move $s1, $a0
	addi $s1, $s1, 1
	
	li $v0, 42  # 42 is system call code to generate random int
	li $a1, 8 # $a1 is where you set the upper bound
	syscall     # your generated number will be at $a0
	
	move $s2, $a0
	addi $s2, $s2, 1

	jr $ra

