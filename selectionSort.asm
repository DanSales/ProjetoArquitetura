.data
	vector: .word 5, 16, 2, 67, 23
	
.text
	la $a0, vector
	addi $a1, $zero, 0
	addi $a2, $zero, 4
	jal swap
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall
	add $a0, $v1, $zero
	syscall
	j exit
	
swap:#swap(int vector[], int index1, int index2)
	sll $t1, $a1, 2 #t1 = index_a1*4
	sll $t3, $a2, 2 #t3 = index_a2*4
	add $t1, $a0, $t1 #t1 = v[a1]
	lw $t0, 0($t1)
	add $t1, $a0, $t3 #t1 = v[a2]
	lw $t2, 0($t1)
	
	sw $t2, 0($t1)
	#sw $t0, 0($t1)
	
	add $v0, $t0, $zero
	add $v1, $t2, $zero
	jr $ra
	
minIndex:#minIndex(int vector[], int index, int size)
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	
	beq $a1, $a2, returnI
	sll $t1, $a1, 2 #t1 = index*4
	add $t1, $a0, $t1 #t1 = vector[index]
	lw $t2, 0($t1)
	addi $a1, $a1, 1 #index = index + 1
	add $t0, $a1, $zero #t0 = index+1
	sll $t0, $a1, 2 #t0 = index*4
	add $t1, $a0, $t0 #t1 = vector[index+1]
	lw $t3, 0($t1)
	
	blt $t2, $t3, returnIndex
	blt $t3, $t2, returnIndex2

	jal minIndex
	
returnI:#In case index==size, return index
	add $v0, $a1, $zero
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
returnIndex:#If vector[index] is smaller than vector[index+1], execute this label
	add $v0, $t2, $zero
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra

returnIndex2:#If vector[index+1] is smaller than vector[index], execute this label
	add $v0, $t3, $zero
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra

	
selection:#selection(int vector[], int size)
	add $t0, $zero, $zero #index = 0
	beq $a1, $t0, exitSelection
		
exit: nop