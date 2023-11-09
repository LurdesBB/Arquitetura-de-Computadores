.data
	vetor: .word -2, 4, 7, -3, 0, -3, 5, 6
	msg1: .asciiz "\nA soma dos valores positivos: "
	msg2: .asciiz "\nA soma dos valores negativos: "
.text
	.globl main
	main:
		addi $s0, $zero, 9 # Cont = 9
		addi $s1, $zero, 0 # somaP = 0
		addi $s2, $zero, 0 # somaN = 0
		addi $s4, $zero, 0 # i = 0
		
		la $t0, vetor
		add $s3, $zero, $t0 # Ponteiro
		
		loop:
			subi $s0, $s0, 1  # Cont = Cont - 1 
			
			beq $s0, $zero, fim # If (cont==0)
			sll $t1, $s4, 2	 # Temp1 = i * 4
			
			add $t1, $t1, $s3 # Temp1 = Ponteiro pro endereço de vetor[i]
			lw $t0, 0($t1)	 # t0 = vetor[i]
			
			addi $s4, $s4, 1 # i = i + 1
			
			slti $t2, $t0, 0  # If (vet[i] < 0) $t2 = 1, ELSE $t2 = 0
			beq $t2, $zero, positivo # Se ele for igual a 0, então pula pra 'positivo' e soma ele no 'somaP'
			
			add $s2, $s2, $t0 # somaN = somaN + vetor[i]

			j loop # Volta pro 'loop' novamente
			
			positivo:

				add $s1, $s1, $t0 # somaP = somaP + vetor[i]

				j Loop # Volta pro 'loop' novamente
				
		fim:

			li $v0, 4 # Imprimi a string 'msg1'
			la $a0, msg1 # Salva 'msg1' em $a0
			syscall
			
			li $v0, 1 # Imprimi a soma dos positivos (somaP)
			add $a0, $zero, $s1 # Salva '$s1' em $a0
			syscall	 
			
			li $v0, 4 # Imprimi a string 'msg2'
			la $a0, msg2 # Salva 'msg2' em $a0
			syscall
			
			li $v0, 1 # Imprimi a soma dos negativos (somaN)
			add $a0, $zero, $s2 # Salva '$s2' em $a0
			syscall