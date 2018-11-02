.data
	Vetor: .word  39, 541, 1, 123, 44, 27
	Tamanho: .word 6
.text
################################## Não consegui achar um jeito de criar um vetor auxiliar de forma eficiente #####################################
	la $a0, Vetor
	la $a2, Tamanho
	lw $a2, 0($a1)
	add $a1, $zero, $zero
	jal mergeSort
mergeSort:
	#Alocando pilha
	addi $sp, $sp, 12
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	sw $ra, 8($sp)
	#a1 = Tamanho do Vetor/ a0 = Endereço do primeiro elemento do vetor
	bge $a1, $a2, return
	# a1 + a2
	add $s0, $a1, $a2
	# (a1 + a2)/2
	div $s0, $s0, 2
	mflo $s0
	add $a2, $s0, $zero
	jal mergeSort
	lw $a2, 4($sp)
	addi $a1, $s0, 1
	jal mergeSort
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	add $a3, $s0, $zero
	jal merge
return:
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
merge:
	#n1 = meio - inicio + 1
	mul $s1, $a1, -1
	add $s1, $s1, $a3
	addi $s1, $s1, 1
	#n2 = final - meio
	mul $s2, $a3, -1
	add $s2, $a2, $s2
	# n1 * 4
	sll $t2, $s1, 2
	# n2 * 4
	sll $t3, $s2, 2
	# n1 * -1
	mul $t4, $t2, -1
	# n2 * -1
	mul $t5, $t3, -1
	#Alocar o tamanho do vetor esquerda
	add $t6, $zero, $zero
	sll $t7, $a1, 2
	add $t7, $a0, $t7
	for:
	bge $t6, $s1, saidafor
	addi $sp, $sp, -4
	lw $t8, 0($t7)
	sw $t8, 0($sp)
	addi $t6, $t6, 4
	addi $t7, $t7, 4
	j for
saidafor:
	sll $t7, $a3, 2
	addi $t7, $t7, 4
	add $t7, $a0, $t7
	add $t6, $zero, $zero 
	ford:
	bge $t6, $s2, saidaford
	addi $sp, $sp, -4
	lw $t8, 0($t7)
	sw $t8, 0($sp)
	addi $t6, $t6, 4
	addi $t7, $t7, 4
	j ford
saidaford:
	add $t6, $zero, $zero
	add $t9, $zero, $zero
	
	
	
	