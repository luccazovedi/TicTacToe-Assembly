#INTEGRANTES: Lucca Zovedi, Matheus Gelio, Vinicius Dapper.
	
	.data
msgEntrada:	.asciiz "\n\nBem-vindo(a) ao Jogo da Velha!\n"
msgJ1:	.asciiz "\nJogador 1 (1), digite uma posição: "
msgJ2:	.asciiz "\nJogador 2 (-1), digite uma posição: "
msgMaquina:	.asciiz "\nA Máquina gerou a posição: "
msgErroPosicaoOcupadaJ1:	.asciiz "\nJogador 1 (1), essa posição já está ocupada! Tente novamente."
msgErroPosicaoOcupadaJ2:	.asciiz "\nJogador 2 (-1), essa posição já está ocupada! Tente novamente."
msgErroPosicaoInvalidaJ1:	.asciiz "\nJogador 1 (1), essa posição é inválida! Tente novamente."
msgErroPosicaoInvalidaJ2:	.asciiz "\nJogador 2 (-1), essa posição é inválida! Tente novamente."
msgVitoriaJ1:	.asciiz "\nParabéns, Jogador 1! Você ganhou!"
msgVitoriaJ2:	.asciiz "\nParabéns, Jogador 2! Você ganhou!"
msgVitoriaMaquina:	.asciiz "\nVocê perdeu para a máquina, que vergonha!"
msgEmpate:	.asciiz "\nBelo duelo! No entanto, houve um empate."
msgModoDeJogo:	.asciiz "\nEscolha o modo de jogo: (1) Jogador x Máquina - (2) Jogador x Jogador: "
msgJogarNovamente: .asciiz "\n\nDeseja jogar novamente? (S/s) Sim - (N/n) Não: "
pularLinha:	.asciiz "\n"
espaco:	.asciiz "  "
	
	.text
	.globl main
	
main:	
	li $v0, 4	#Mostra na tela a mensagem de entrada.
	la $a0, msgEntrada
	syscall
	
	li $v0, 4	#Mostra na tela a mensagem da escolha do modo de jogo.
	la $a0, msgModoDeJogo
	syscall
	
	li $v0, 5	#Armazena no registrador S2 a escolha do usuário, sendo 1 para JxM e 2 para JxJ.
	syscall
	move $s2, $v0
	
	move $t0, $zero	#Registradores para cada posição do tabuleiro de Jogo da Velha.
	move $t1, $zero	#Todos eles são setados como zero para "esvaziar" o tabuleiro.
	move $t2, $zero
	move $t3, $zero
	move $t4, $zero
	move $t5, $zero
	move $t6, $zero
	move $t7, $zero
	move $t8, $zero
	
	move $s3, $zero	#Zera o registrador S3 (contador de turnos para a lógica de empate).
	
	#Inicia o jogo e, enquanto não houver um vencedor ou um empate, toda a lógica irá se repetir.
	
j1Digitar:	
	li $v0, 4	#Imprime a mensagem pedindo para o J1 digitar a posição.
	la $a0, msgJ1
	syscall

	li $v0, 5	#Armazena a posição digitada pelo J1 no registrador S0.
	syscall
	move $s0 ,$v0
	
	jal testeRegistradoresJ1 #Vai para a função que testa o conteúdo registradores.
	
	add $s3, $s3, 1	#Conta os turnos para a lógica de empate.
	
	jal tabuleiro	#Imprime o tabuleiro na tela.
	jal checarEventoJ1 #Vai para a função que checa os eventos de vitória e empate.
	
	beq $s2, 1, maquinaDigitar #Se a escolha for 1 (JxM), vai para a função geradora de uma posição pela máquina.
	
	jal j2Digitar #Se a escolha for 2 (JxJ), vai para a função que pede para o J2 digitar a posição.
			#Além disso, caso não seja necessário gerar algum evento, o jogo segue a vez para o próximo jogador.
	
testeRegistradoresJ1:
	beq $s0, 1, r1J1
	beq $s0, 2, r2J1
	beq $s0, 3, r3J1
	beq $s0, 4, r4J1
	beq $s0, 5, r5J1	#Vai para a posição digitada checar se ela está vazia ou não.
	beq $s0, 6, r6J1
	beq $s0, 7, r7J1
	beq $s0, 8, r8J1
	beq $s0, 9, r9J1
	jal rErroPosicaoInvalidaJ1	#Se a posição digitada não estiver entre 1 e 9, imprime uma mensagem de erro e pede-se ao J1 para digitar novamente.
	
r1J1:
	bne $t0, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 1 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t0, $t0, 1	#Se a posição 1 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r2J1:
	bne $t1, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 2 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t1, $t1, 1	#Se a posição 2 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r3J1:
	bne $t2, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 3 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t2, $t2, 1	#Se a posição 3 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r4J1:
	bne $t3, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 4 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t3, $t3, 1	#Se a posição 4 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r5J1:
	bne $t4, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 5 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t4, $t4, 1	#Se a posição 5 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r6J1:
	bne $t5, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 6 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t5, $t5, 1	#Se a posição 6 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r7J1:
	bne $t6, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 7 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t6, $t6, 1	#Se a posição 7 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r8J1:
	bne $t7, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 8 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t7, $t7, 1	#Se a posição 8 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
r9J1:
	bne $t8, 0, rErroPosicaoOcupadaJ1	#Checa se a posição 9 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J1 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t8, $t8, 1	#Se a posição 9 estiver vazia, seta o número 1 (representando o J1) no tabuleiro.
	jr $ra
	
rErroPosicaoOcupadaJ1:
	li $v0, 4	#Se a posição digitada estiver ocupada,
	la $a0, msgErroPosicaoOcupadaJ1		#imprime a mensagem de erro do J1 e pede para ele digitar novamente.
	syscall
	jal j1Digitar
	
rErroPosicaoInvalidaJ1:
	li $v0, 4	#Se o número digitado não estiver entre 1 e 9,
	la $a0, msgErroPosicaoInvalidaJ1	#imprime a mensagem de erro do J1 e pede para ele digitar novamente.
	syscall
	jal j1Digitar
	
checarEventoJ1:
	add $t9, $zero, $zero	#Checando posições 1, 2 e 3 (Primeira linha).
	add $t9, $t0, $t1
	add $t9, $t9, $t2
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 4, 5 e 6 (Segunda linha).
	add $t9, $t3, $t4
	add $t9, $t9, $t5
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 7, 8 e 9 (Terceira linha).
	add $t9, $t6, $t7
	add $t9, $t9, $t8
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 1, 4, e 7 (Primeira coluna).
	add $t9, $t0, $t3
	add $t9, $t9, $t6
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 2, 5 e 8 (Segunda coluna).
	add $t9, $t1, $t4
	add $t9, $t9, $t7
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 3, 6 e 9 (Terceira coluna).
	add $t9, $t2, $t5
	add $t9, $t9, $t8
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 1, 5 e 9 (Diagonal principal).
	add $t9, $t0, $t4
	add $t9, $t9, $t8
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	add $t9, $zero, $zero	#Checando posições 3, 5 e 7 (Diagonal secundária).
	add $t9, $t2, $t4
	add $t9, $t9, $t6
	
	beq $t9, 3, eventoVitoriaJ1	#Se a soma dos valores do tabuleiro for igual a 3, o J1 vence.
	
	beq $s3, 9, eventoEmpate #Se a soma dos turnos for igual a 9, o jogo é finalizado em um empate.
	
	jr $ra	#Caso não ocorra uma vitória ou um empate, troca o turno do jogador.
	
eventoVitoriaJ1:
	li $v0, 4	#Imprime a mensagem de vitória do J1 e vai para a função de finalização.
	la $a0, msgVitoriaJ1
	syscall
	j saida
	
eventoEmpate:
	li $v0, 4	#Imprime a mensagem de empate e vai para a função de finalização.
	la $a0, msgEmpate
	syscall
	j saida
	
maquinaDigitar:
	li $v0, 42	#Gera um número aleatório entre 1 e 9 e armazena ele no registrador S1.
    	li $a1, 9
    	syscall
    	move $s1, $a0
	
	jal testeRegistradoresJ2 #Vai para a função que testa o conteúdo registradores.
	
	add $s3, $s3, 1	#Contagem dos turnos para a lógica de empate
	
	li $v0, 4	
	la $a0, msgMaquina
	syscall
			#Imprime uma mensagem dizendo qual posição foi gerada.
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4	#Pula uma linha.
	la $a0, pularLinha
	syscall
	
	jal tabuleiro	#Imprime o tabuleiro na tela.
	jal checarEventoJ2 #Vai para a função que checa os eventos de vitória e empate.
	jal j1Digitar #Caso não seja necessário gerar algum evento, o jogo segue a vez para o próximo jogador.
	
j2Digitar:
	beq $s2, 1, maquinaDigitar	#Se o modo de jogo for 1 (JxM), pula para a função da Máquina.

	li $v0, 4	#Pede
	la $a0, msgJ2
	syscall
			#Pede para o Jogador 2 digitar uma posição.
	li $v0, 5
	syscall
	move $s1, $v0
	
	jal testeRegistradoresJ2 #Vai para a função que testa o conteúdo registradores.
	
	add $s3, $s3, 1	#Conta os turnos para a lógica de empate
	
	jal tabuleiro	#Imprime o tabuleiro na tela.
	jal checarEventoJ2 #Vai para a função que checa os eventos de vitória e empate.
	jal j1Digitar #Caso não seja necessário gerar algum evento, o jogo segue a vez para o próximo jogador.
	
testeRegistradoresJ2:
	beq $s1, 1, r1J2
	beq $s1, 2, r2J2
	beq $s1, 3, r3J2
	beq $s1, 4, r4J2
	beq $s1, 5, r5J2	#Vai para a posição digitada checar se ela está vazia ou não.
	beq $s1, 6, r6J2
	beq $s1, 7, r7J2
	beq $s1, 8, r8J2
	beq $s1, 9, r9J2
	jal rErroPosicaoInvalidaJ2	#Se a posição digitada não estiver entre 1 e 9, imprime uma mensagem de erro e pede-se ao J2 para digitar novamente.
	
r1J2:
	bne $t0, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 1 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t0, $t0, -1	#Se a posição 1 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r2J2:
	bne $t1, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 2 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t1, $t1, -1	#Se a posição 2 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r3J2:
	bne $t2, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 3 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t2, $t2, -1	#Se a posição 3 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r4J2:
	bne $t3, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 4 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t3, $t3, -1	#Se a posição 4 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r5J2:
	bne $t4, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 5 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t4, $t4, -1	#Se a posição 5 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r6J2:
	bne $t5, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 6 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t5, $t5, -1	#Se a posição 6 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r7J2:
	bne $t6, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 7 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t6, $t6, -1	#Se a posição 7 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r8J2:
	bne $t7, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 8 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t7, $t7, -1	#Se a posição 8 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra

r9J2:
	bne $t8, 0, rErroPosicaoOcupadaJ2	#Checa se a posição 9 está vazia, se não estiver,
				#mostra uma mensagem de erro, volta e pede para o J2 digitar novamente até a posição digitada ser uma posição vazia.
	
	add $t8, $t8, -1	#Se a posição 9 estiver vazia, seta o número -1 (representando o J2) no tabuleiro.
	jr $ra
	
rErroPosicaoOcupadaJ2:
	beq $s2, 1, j2Digitar	#Se a escolha for 1 (JxM), não é mostrada na tela a mensagem de erro para a Máquina, é apenas gerado um novo número até ele ser válido.

	li $v0, 4	#Se a posição digitada estiver ocupada,
	la $a0, msgErroPosicaoOcupadaJ2		#imprime a mensagem de erro do J2 e pede para ele digitar novamente.
	syscall
	jal j2Digitar

rErroPosicaoInvalidaJ2:
	beq $s2, 1, j2Digitar	#Se a escolha for 1 (JxM), não é mostrada na tela a mensagem de erro para a Máquina, é apenas gerado um novo número até ele ser válido.

	li $v0, 4	#Se o número digitado não estiver entre 1 e 9,
	la $a0, msgErroPosicaoInvalidaJ2	#imprime a mensagem de erro do J2 e pede para ele digitar novamente.
	syscall
	jal j2Digitar
	
checarEventoJ2:
	add $t9, $zero, $zero	#Checando posições 1, 2 e 3 (Primeira linha).
	add $t9, $t0, $t1
	add $t9, $t9, $t2
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 4, 5 e 6 (Segunda linha).
	add $t9, $t3, $t4
	add $t9, $t9, $t5
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 7, 8 e 9 (Terceira linha).
	add $t9, $t6, $t7
	add $t9, $t9, $t8
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 1, 4, e 7 (Primeira coluna).
	add $t9, $t0, $t3
	add $t9, $t9, $t6
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 2, 5 e 8 (Segunda coluna).
	add $t9, $t1, $t4
	add $t9, $t9, $t7
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 3, 6 e 9 (Terceira coluna).
	add $t9, $t2, $t5
	add $t9, $t9, $t8
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 1, 5 e 9 (Diagonal principal).
	add $t9, $t0, $t4
	add $t9, $t9, $t8
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	add $t9, $zero, $zero	#Checando posições 3, 5 e 7 (Diagonal secundária).
	add $t9, $t2, $t4
	add $t9, $t9, $t6
	
	beq $t9, -3, eventoVitoriaJ2	#Se a soma dos valores do tabuleiro for igual a -3, o J2 vence.
	
	jr $ra	#Caso não ocorra uma vitória ou um empate, troca o turno do jogador.
	
eventoVitoriaMaquina:
	li $v0, 4	#Imprime a mensagem de vitória da Máquina e vai para a função de finalização.
	la $a0, msgVitoriaMaquina
	syscall
	j saida
	
eventoVitoriaJ2:
	beq $s2, 1, eventoVitoriaMaquina	#Se a escolha do modo de jogo for 1 (JxM), é pulado para o evento da vitória da Máquina.

	li $v0, 4	#Imprime a mensagem de vitória do J2 e vai para a função de finalização.
	la $a0, msgVitoriaJ2
	syscall
	j saida
	
tabuleiro:	#Função que imprime o tabuleiro.
	li $v0, 4
	la $a0, pularLinha	#Pula uma linha.
	syscall

	li $v0, 1
	move $a0, $t0	#Imprime a primeira posição.
	syscall
	
	li $v0, 4
	la $a0, espaco	#Espaçamento.
	syscall
	
	li $v0, 1
	move $a0, $t1	#Imprime a segunda posição.
	syscall
	
	li $v0, 4
	la $a0, espaco #Espaçamento.
	syscall
	
	li $v0, 1
	move $a0, $t2	#Imprime a terceira posição.
	syscall
	
	li $v0, 4
	la $a0, pularLinha #Pula uma linha.
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, espaco
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, espaco
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, espaco
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, espaco
	syscall
	
	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	jr $ra
	
saida:	
	li $v0, 4	#Imprime a mensagem da escolha de jogar novamente na tela.
	la $a0, msgJogarNovamente
	syscall
	
	li $v0, 12	#Armazena a escolha de jogar novamente no registrador S2.
	syscall
	move $s2, $v0
	
	beq $s2, 'S', main	#Se a escolha de jogar novamente for 'S', o jogo recomeça.
	beq $s2, 's', main	#Se a escolha de jogar novamente for 's', o jogo recomeça.
				#Caso contrário, o programa é finalizado.
	
	li $v0, 10	#Finaliza o programa.
	syscall
