.data
	Vetor: .word  14, 51, 2, 141, 24, 12
	primeiraparte: .asciiz "Indice: "
	segundaparte: .asciiz " que possui valor: "
	terceiraparte: .asciiz " troca com indice: "
	quartaparte: .asciiz " que possui valor: "
	quebralinha: .asciiz "\n"
	space: .asciiz " "
.text
	la $a0, Vetor
	addi $a1, $zero, 6
	jal heapsort
	j printVetor
	j exit
heapsort:
	#a1 = Tamanho do vetor/ a0 = endereço do inicio do vetor
	addi $sp, $sp, -8
	sw $a1, 0($sp)
	sw $ra, 4($sp)
	add $a2, $zero, $a1
	addi $t0, $zero, 2
	div  $a2, $t0
	mflo $a2
	addi $a2, $a2, -1
	
	#Enquanto a2 for maior igual a 0
	for: blt $a2, $zero, saidaprimeirofor
	jal heapify
	addi $a2, $a2, -1
	j for
saidaprimeirofor:
	addi $t1, $a1, -1
	#A3 ficara com o tamanho do vetor
	add $a3, $a1, $zero
	ford: blt  $t1, $zero, saidasegundofor
	#Troca v[0] com v[i]
	lw $t2, 0($a0)
	sll $t3, $t1, 2
	add $t3, $a0, $t3
	lw $t4, 0($t3)
	sw $t4, 0($a0)
	sw $t2, 0($t3)
	#Heapify(a0, a1, a2)
	add $a1, $t1, $zero
	add $a2, $zero, $zero
	jal heapify
	addi $t1, $t1, -1
	j ford
saidasegundofor:
	lw $a1, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra
heapify:
	#Salvando na pilha
	addi $sp, $sp, -8
	sw $a2, 0($sp)
	sw $ra, 4($sp)
	#t5 = maior
	add $t5, $a2, $zero
	#t6 = filho esquerda
	sll $t6, $t5, 1
	addi $t6, $t6, 1
	#t7 = filho direita
	sll $t7, $t5, 1
	addi $t7, $t7, 2
	#s0 = vetor[maior]
	sll $s0, $t5, 2
	add $s0, $a0, $s0
	lw $s0, 0($s0)
	#s1 = vetor[l]
	sll $s1, $t6, 2
	add $s1, $a0, $s1
	lw $s1, 0($s1)
	#s2 = vetor[r]
	sll $s2, $t7, 2
	add $s2, $a0, $s2
	lw $s2, 0($s2)
	bge $t6, $a1, saidaifum
	ble $s1, $s0, saidaifum
	add $t5, $t6, $zero
saidaifum:
	sll $s0, $t5, 2
	add $s0, $a0, $s0
	lw $s0, 0($s0)
	bge $t7, $a1, saidaifdois
	ble $s2, $s0, saidaifdois
	add $t5, $t7, $zero
saidaifdois:
	beq $t5, $a2, return
	#$t8 = endereco de vetor[i]
	sll $t8, $a2, 2
	add $t8, $a0, $t8
	#t9 = endereco de vetor[maior]
	sll $t9, $t5, 2
	add $t9, $a0, $t9
	lw $s3, 0($t8)
	lw $s4, 0($t9)
	sw $s4, 0($t8)
	sw $s3, 0($t9)
	add $a2, $t5, $zero
	jal heapify
return:
	lw $a2, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
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
	 