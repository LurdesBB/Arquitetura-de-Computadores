.data
	msg1: .asciiz "\nDigite o valor de A: "
	msg2: .asciiz "Digite o valor de B: "
	saida: .ascii "\nOs multiplos de A entre A e (A * B): "

.text
	.globl main

	main:
    
    	li $v0, 4 # Pede ao usuário para digitar A
    	la $a0, msg1
    	syscall

    	li $v0, 5 # Lê o valor de A
    	syscall
    	move $t0, $v0 # Salva o valor de A em $t0

    	blez $t0, fim # Verifica se A é menor ou igual a 0

    	li $v0, 4 # Pede ao usuário para digitar B
    	la $a0, msg2
    	syscall

    	li $v0, 5 # Lê o valor de B
    	syscall
    	move $t1, $v0 # Salva o valor de B em $t1

    	blez $t1, fim # Verifica se B é menor ou igual a 0
    
    	mul $t1, $t0, $t1 # A * B
    
    	add $t7, $zero, $t0 # $t7 = A
    
    	li $v0, 4 # Escreve o cabeçalho
    	la $a0, saida
    	syscall

	loop:

    		bgt $t7, $t1, fim # Verifica se $t7(que contém A) é maior que $t1(A * B)
    
    		li $v0, 1 # Imprimi o valor que está em $t7
    		move $a0, $t7 # Salva $t7 em $a0
    		syscall
    
    		li $v0, 11 # Imprime um espaço
    		li $a0, 32
    		syscall
    
    		add $t7, $t7, $t0 # $t7 = $t7 + A
    
    		j loop # Volta pro 'loop' novamente

		fim:
    
    		li $v0, 10 # Encerra o programa
    		syscall
