.data
    EhPerfeito: .asciiz " é um número perfeito."
    NaoEhPerfeito: .asciiz " não é um número perfeito."
    inserir: .asciiz "\nDigite um número inteiro positivo (n): "

.text
.globl main

main:

    li $v0, 4 # Pede ao usuário para inserir o valor de n
    la $a0, inserir
    syscall

    li $v0, 5
    syscall
    move $t0, $v0 # Armazena o valor de n em $t0
    
    add $t7, $zero, $zero
    add $t7, $t7, $t0 # $t7 recebe o número que o usuário colocou

    # Inicializa variáveis para a soma e o divisor
    li $t1, 1   # Inicializa o divisor como 1
    li $t2, 0   # Inicializa a soma como 0

loop:
    
    bge $t1, $t0, checando # Verifica se o divisor é maior ou igual a n

    div $t0, $t1 # Divide n pelo divisor

    mfhi $t3 # Verifica se é uma divisão exata
    beqz $t3, Soma

    j ProximoDivisor # Se não for divisão exata, vá para o próximo divisor

Soma:
    
    add $t2, $t2, $t1 # Adiciona o divisor à soma

ProximoDivisor:
    
    addi $t1, $t1, 1 # Incrementa o divisor
    j loop

checando:
    
    beq $t0, $t2, PerfeitoF # Verifica se a soma é igual a n
    j NperfeitoF

PerfeitoF: # PerfeitoF = Função para imprimir se o número é perfeito
    
    li $v0, 1 # Imprime o número (n)
    move $a0, $t7
    syscall
    
    li $v0, 4 # Número perfeito encontrado
    la $a0, EhPerfeito
    syscall
    j Saida

NperfeitoF: # NperfeitoF = Função para imprimir se o número não é perfeito
    
    li $v0, 1 # Imprime o número (n)
    move $a0, $t7
    syscall
    
    li $v0, 4 # Número não é perfeito
    la $a0, NaoEhPerfeito
    syscall

Saida:
    
    li $v0, 10 # Encerra o programa
    syscall
