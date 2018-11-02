.data
	Vetor: .word  39, 541, 1, 123, 44, 27
	Tamanho: .word 6
	primeiraparte: .asciiz "Indice: "
	segundaparte: .asciiz " que possui valor: "
	terceiraparte: .asciiz " troca com indice: "
	quartaparte: .asciiz " que possui valor: "
	quebralinha: .asciiz "\n"
	space: .asciiz " "
.text
	la $a0, Vetor
	add $a1, $zero, $zero
	la $a2, Tamanho
	lw $a2, 0($a2)
	addi $a2, $a2, -1
	jal quick
	la $a1, Tamanho
	lw $a1, 0($a1)
	j printVetor
	j exit

quick:
	addi $sp, $sp, -12
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	sw $ra, 8($sp)
	bge $a1, $a2, return
	jal particao
	addi $a2, $a3, -1
	jal quick
	addi $a1, $a3, 1
	lw $a2, 4($sp)
	jal quick
return:
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
particao:
	#Vetor[maior]
	sll $t1, $a2, 2
	add $t1, $a0, $t1
	lw $t1, 0($t1)	
	#menor - 1
	addi $t2, $a1, -1
	#s0 = menor
	add $s0, $a1, $zero
	#s1 = maior - 1
	addi $s1, $a2, -1
	for:
	bgt $s0, $s1, saidafor
	sll $t3, $s0, 2
	add $t3, $a0, $t3
	lw $t4, 0($t3)
	bge $t4, $t1, saidaif
	addi $t2, $t2, 1
	
	#Alocando para printTroca
	addi $sp, $sp, -16
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	sw $a3, 8($sp)
	sw $ra, 12($sp)
	# a1 = i
	add $a1, $t2, $zero
	sll $t5, $t2, 2
	add $t5, $a0, $t5
	# a3 = vetor[i]
	lw $a3, 0($t5)
	# a2 = j
	add $a2, $s0, $zero
	jal printTroca
	#Desalocando
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	lw $a3, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	lw $t6, 0($t5)
	sw $t4, 0($t5)
	sw $t6, 0($t3)
	saidaif:
	addi $s0, $s0, 1
	j for
saidafor:
	addi $t2, $t2, 1
	sll $t5, $t2, 2
	add $t5, $a0, $t5
	#Alocando pilha para print troca
	addi $sp, $sp, -16
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	sw $a3, 8($sp)
	sw $ra, 12($sp)
	#a1 = maior
	add $a1, $a2, $zero
	#a3 = vetor[maior]
	add $a3, $t1, $zero
	#a2 = i + 1
	add $a2, $t2, $zero
	jal printTroca
	#Desalocando
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	lw $a3, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	lw $t6, 0($t5)
	sll $t7, $a2, 2
	add $t7, $a0, $t7
	lw $t8, 0($t7)
	sw $t8, 0($t5)
	sw $t6, 0($t7)
	add $a3, $t2, $zero
	jr $ra

printTroca:
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	la $a0, primeiraparte
	addi $v0, $zero, 4
	syscall
	add $a0, $a1, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, segundaparte
	addi $v0, $zero, 4
	syscall
	add $a0, $a3, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, terceiraparte
	addi $v0, $zero, 4
	syscall
	add $a0, $a2, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, quartaparte
	addi $v0, $zero, 4
	syscall
	lw $a0, 0($sp)
	sll $t8, $a2, 2
	add $t8, $t8, $a0
	lw $t8, 0($t8)
	add $a0, $t8, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, quebralinha
	addi $v0, $zero, 4
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	jr $ra


printVetor:
	add $s0, $zero, $zero
	add $a2, $a0, $zero
	fore:slt $t0, $s0, $a1
	beq $t0, $zero, exit
	sll $t1, $s0, 2
	add $t1, $a2, $t1
	lw $a0, 0($t1)
	addi $v0, $zero, 1
	syscall
	addi $s0, $s0, 1
	la $a0, space
	addi $v0, $zero, 4
	syscall
	j fore
	lw $a0, 0($t1)
	
exit: nop
	
	
	