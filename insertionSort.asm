.data
	Vetor: .word 2, 102, 41, 52, 3134, 2
.text
	la $a0, Vetor
	addi $a1, $zero, 2
	jal swap
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall
	j exit
	
swap:
	sll $t1, $a1, 2
	add $t1, $a0, $t1
	
	lw $t2, 0($t1)
	lw $t0, 4($t1)
	
	sw $t2, 4($t1)
	sw $t0, 0($t1)
	
	add $v0, $t2, $zero
	
	jr $ra
	
insertion:
	#a1 = tamanho e a0 = endereco do inicio do vetor
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $ra,4($sp)
	
	ble $a1,1,return
	
	addi $a1,$a1,-1
	jal insertion
	# $t1 = vetor[tamanho - 1]
	sll $t1, $a1, 2
	add $t1, $a0, $t1
	# j = tamanho - 2
	addi $t2, $a1, -1
	# $t3 = vetor[j]
	sll $t3, $t2, 2
	add $t3, $a0, $t3
#Loop não completado
loop:   blt $t2, 0, exit
	ble $t3, $t2, exit
	
	       
	
	
return:
	lw $a0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
	

exit: nop