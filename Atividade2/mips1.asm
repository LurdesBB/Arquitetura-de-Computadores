.data
    EhPerfeito: .asciiz " � um n�mero perfeito."
    NaoEhPerfeito: .asciiz " n�o � um n�mero perfeito."
    inserir: .asciiz "\nDigite um n�mero inteiro positivo (n): "

.text
.globl main

main:

    li $v0, 4 # Pede ao usu�rio para inserir o valor de n
    la $a0, inserir
    syscall

    li $v0, 5
    syscall
    move $t0, $v0 # Armazena o valor de n em $t0
    
    add $t7, $zero, $zero
    add $t7, $t7, $t0 # $t7 recebe o n�mero que o usu�rio colocou

    # Inicializa vari�veis para a soma e o divisor
    li $t1, 1   # Inicializa o divisor como 1
    li $t2, 0   # Inicializa a soma como 0

loop:
    
    bge $t1, $t0, checando # Verifica se o divisor � maior ou igual a n

    div $t0, $t1 # Divide n pelo divisor

    mfhi $t3 # Verifica se � uma divis�o exata
    beqz $t3, Soma

    j ProximoDivisor # Se n�o for divis�o exata, v� para o pr�ximo divisor

Soma:
    
    add $t2, $t2, $t1 # Adiciona o divisor � soma

ProximoDivisor:
    
    addi $t1, $t1, 1 # Incrementa o divisor
    j loop

checando:
    
    beq $t0, $t2, PerfeitoF # Verifica se a soma � igual a n
    j NperfeitoF

PerfeitoF: # PerfeitoF = Fun��o para imprimir se o n�mero � perfeito
    
    li $v0, 1 # Imprime o n�mero (n)
    move $a0, $t7
    syscall
    
    li $v0, 4 # N�mero perfeito encontrado
    la $a0, EhPerfeito
    syscall
    j Saida

NperfeitoF: # NperfeitoF = Fun��o para imprimir se o n�mero n�o � perfeito
    
    li $v0, 1 # Imprime o n�mero (n)
    move $a0, $t7
    syscall
    
    li $v0, 4 # N�mero n�o � perfeito
    la $a0, NaoEhPerfeito
    syscall

Saida:
    
    li $v0, 10 # Encerra o programa
    syscall
