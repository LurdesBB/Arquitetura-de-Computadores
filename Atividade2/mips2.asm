.data
	quadrados: .space 256  # Alocar espa�o para um array de 64 inteiros (64 * 4 bytes)
	iniciar: .asciiz "\nDigite um n�mero: "
	somaq: .asciiz "\nA soma dos quadrados de 0 at� "
	somaqq: .asciiz " �: "

.text
.globl main

main:
    
    li $v0, 4 # Leia o valor de upTo
    la $a0, iniciar
    syscall
    
    li $v0, 5
    syscall
    
    add $t7, $t7, $v0
    
    move $a0, $v0 # Coloque o valor lido em $a0 para pass�-lo como argumento

    jal guardarValores # Chame guardarValores para preencher o array quadrados

    jal Somar # Chame computarSoma para calcular a soma dos quadrados

    li $v0, 4 # Imprima o cabe�alho
    la $a0, somaq
    syscall
    
    li $v0, 1 # Imprime o n�mero (n)
    move $a0, $t7
    syscall
    
    li $v0, 4 # Imprima o cabe�alho
    la $a0, somaqq
    syscall

    li $v0, 1 # Imprima a soma
    move $a0, $t3 # Coloque o resultado em $a0 para imprimi-lo
    syscall

    li $v0, 10 # Encerre o programa
    syscall

guardarValores:

    # Argumento n est� em $a0
    # $t0 � o contador i
    # $t1 � o endere�o base do array squares

    li $t0, 0 # Inicialize i (contador) com 0
    la $t1, quadrados # Carregue o endere�o base de squares em $t1

guardarNoVetor:

    beq $t0, $a0, fimGuardar # Se i == n, saia do loop
    mul $t2, $t0, $t0 # Calcule i * i e armazene em $t2
    sw $t2, 0($t1) # Armazene o valor de $t2 em squares[i]
    addi $t0, $t0, 1 # Incremente i
    addi $t1, $t1, 4 # Avance o endere�o em 4 bytes
    j guardarNoVetor

fimGuardar:
    jr $ra

Somar:

    # Argumento n est� em $a0
    # $t0 � o contador i
    # $t1 � o endere�o base do array squares
    # $t3 � a vari�vel de soma (sum)

    li $t0, 0 # Inicialize i (contador) com 0
    li $t3, 0 # Inicialize a vari�vel de soma com 0
    la $t1, quadrados # Carregue o endere�o base de squares em $t1

Loop:

    beq $t0, $a0, fimSoma # Se i == n, saia do loop
    lw $t2, 0($t1) # Carregue o valor de squares[i] em $t2
    add $t3, $t3, $t2 # Adicione $t2 � vari�vel de soma
    addi $t0, $t0, 1 # Incremente i
    addi $t1, $t1, 4 # Avance o endere�o em 4 bytes
    j Loop

fimSoma:
    move $v0, $t3 # Coloque o resultado na vari�vel de retorno $v0
    jr $ra
