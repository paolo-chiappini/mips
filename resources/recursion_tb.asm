.text
.globl main

main: 	addi $a0, $a0, 2
	jal rec
	addi $s0, $v0, 0
	sw $s0, 0($sp)
	nop
	nop
	nop
	nop
	# li $v0, 10
	# syscall
rec:	addi $sp, $sp, -20
	sw $fp, 8($sp)
	addi $fp, $sp, 8
	sw $a0, 8($fp)
	sw $ra, 4($fp)
if: 	bne $a0, $zero, else
then:	addi $t0, $t0, 1
	sw $t0, -8($fp)
	addi $t1, $t1, 0
	beq $t1, 0, ret  
else:	addi $a0, $a0, -1
	sw $a0, -4($fp)
	lw $a0, -4($fp)
	jal rec 		# recursion
	lw $t0, 8($fp)		# t0 = n
	add $t0, $t0, $v0	
	sw $t0, -8($fp)		# n * rec(n)
ret: 	lw $v0, -8($fp)		# retval 
	lw $ra, 4($fp)		# saved ra
	lw $fp, 0($fp)		# saved fp
	addi $sp, $sp, 20  	# restore fp
	jr $ra 
