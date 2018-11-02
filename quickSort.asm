.data
	vector: .word 32,45,6,76,12
	primeiraparte: .asciiz "Indice: "
	segundaparte: .asciiz " que possui valor: "
	terceiraparte: .asciiz " troca com indice: "
	quartaparte: .asciiz " que possui valor: "
	quebralinha: .asciiz "\n"
	space: .asciiz " "
	
.text
	la $a0, vector
	addi $a1, $zero, 0
	addi $a2, $zero, 4
	jal quick
	addi $a1, $zero, 5
	j printArray
	
printArray:
	add $s5, $zero, $zero
	add $a2, $a0, $zero
	forPrint:slt $t6, $s0, $a1
	beq $t6, $zero, exit
	sll $t5, $s5, 2
	add $t5, $a2, $t5
	lw $a0, 0($t5)
	addi $v0, $zero, 1
	syscall
	addi $s5, $s5, 1
	la $a0, space
	addi $v0, $zero, 4
	syscall
	j forPrint
	lw $a0, 0($t5)
	j exit
	
quick:#quick(int vector[], int first_index, int final_index)

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	bge $a1, $a2, exitQ #if( first_index < final_index)
	jal partition
	addi $t1, $t1, -1
	addi $a2, $t1, -1
	jal quick
	addi $a1, $t1, 1
	jal quick	
exitQ:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
partition:#partition(int vector[], int lowest, int highest)
	sll $s0, $a2, 2 #s0 = index_a2*4
	add $s0, $a0, $s0 #s0 = v[a2]	
	lw $t0, 0($s0) #pivot = last number
	
	addi $t1, $a1, -1 #t1 = (lowest-1)
	sll $s1, $t1, 2 #s1 = index_t1*4
	add $s1, $a0, $s1 #s1=v[t1]
	
	add $s2, $a1, $zero #s2=lowest
	addi $s3, $a2, -1 #s3=highest-1
	#ble $s2, $s3, for
for:#(s2=lowest;s2<=s3;s2++)
	bgt $s2, $s3, exitFor	
	sll $s4, $a1, 2 #s4 = index_a1*4
	add $s4, $a0, $s4 #s4 = v[a1]
	lw $t2, 0($s4) #t2 = current number	
	######### IF (t2 - current element < t0 - pivot ####################
	sle $t3, $t2, $t0
	addi $s2, $s2, 1 
	beq $t3, $zero, for #if(t3==0), branch to exitIf
	addi $t1, $zero, 1 #incrementing index of lowest
	sll $s1, $t1, 2 #s1 = index_t1*4
	add $s1, $a0, $s1 #s1=v[t1]
	lw $t4, 0($s1)	
	########TEMPS FOR SWAP############
	add $t9, $t2, $zero #temp = current number	
	######## SWAP ####################
	sw $t2, 0($s1)
	sw $t4, 0($s4)
	j for
	
exitFor:
	addi $t1, $zero, 1 #incrementing index of lowest
	sll $s1, $t1, 2 #s1 = index_t1*4
	add $s1, $a0, $s1 #s1=v[t1]
	lw $t4, 0($s1)
	###########TEMPS FOR SWAP##########
	add $t9, $t0, $zero #t9 = t0 - pivot	
	########### SWAP #################
	sw $t4, 0($s0)
	sw $t9, 0($s1)
	########return i=1###############
	addi $t1, $zero, 1
	
	

	
exit: nop
	
	
