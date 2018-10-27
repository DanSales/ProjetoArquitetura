.data
	Vetor: .word 2, 102, 41, 52, 3134, 2
	primeiraparte: .asciiz "Indice: "
	segundaparte: .asciiz " que possui valor: "
	terceiraparte: .asciiz " troca com indice: "
	quartaparte: .asciiz " que possui valor: "
	quebralinha: .asciiz "\n"
	space: .asciiz " "
	
.text
	la $a0, Vetor
	addi $a1, $zero, 6
	jal insertion
	j printVetor
	j exit
	
insertion:
	#a1 = tamanho e a0 = endereco do inicio do vetor
	addi $sp,$sp,-8
	sw $a1,0($sp)
	sw $ra,4($sp)
	
	ble $a1,1,return
	
	addi $a1,$a1,-1
	jal insertion
	# $t1 = enderenço de memoria de vetor[tamanho - 1]
	sll $t1, $a1, 2
	add $t1, $a0, $t1
	# $t1 = ultimo
	lw $t1, 0($t1)
	# j = tamanho - 2
	addi $t2, $a1, -1
	# $t3 = j + 4 (Indice do J)
	sll $t3, $t2, 2
	# $t3 = vetor[j]
	add $t3, $a0, $t3
	lw $t3, 0($t3)
loop:
	blt $t2, $zero, exitloop
	ble $t3, $t1, exitloop
	
	#Funcao para printar a troca
	#alocando pilha
	addi $sp, $sp, -8
	#salvando tamanho do vetor e endereco de ra
	sw $a1, 0($sp)
	sw $ra, 4($sp)
	#a1 = j + 1
	addi $a1, $t2, 1
	#a2 = j
	add $a2, $t2, $zero
	#a3 = ultimo
	add $a3, $t1, $zero 
	jal printTroca
	#restaurando a1 e ra
	lw $a1, 0($sp)
	lw $ra, 4($sp)
	#desalocando
	addi $sp, $sp, 8
	#Continuacao do while
	addi $t4, $t2, 1
	sll $t4, $t4, 2
	add $t4, $a0, $t4
	sw $t3, 0($t4)
	addi $t2, $t2, -1
	sll $t3, $t2, 2
	add $t3, $a0, $t3
	lw $t3, 0($t3)
	j loop
exitloop:
	addi $t4, $t2, 1
	sll $t4, $t4, 2
	add $t4, $a0, $t4
	sw $t1, 0($t4)
return:
	lw $a1,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
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
	for:slt $t0, $s0, $a1
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
	j for
	lw $a0, 0($t1)
exit: nop
