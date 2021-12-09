include 'emu8086.inc'

;-----------------------------------------
;menu do jogo 
 ;----------------------
;Dinheiro Inicial= 20 definir dinheiro, bl vai ser sempre onde esta o dinheiro

MOV BL,20
;--------------------------

OpcaoVoltarMenu:

 call clear_screen 
;Jogos de casino

;Imprimir texto inicial  

   MOV AH, 9
   LEA DX, TextoMenu1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, TextoMenu2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, TextoMenu3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, TextoMenu4
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
    MOV AH, 9
   LEA DX, TextoMenu5
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, TextoMenu6
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
    
    MOV AH, 9
   LEA DX, TextoMenu7
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, TextoMenu8
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, TextoMenu9
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, TextoMenu10
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, TextoMenu11
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
  
   
       


   MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM  


    MOV AH, 9
   LEA DX, EscolherJogo1
   INT 21H 
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   ;escolher o jogo
  EscolherJogoDeNovo:
  MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL

  cmp cl, '1'
  je JogoRoleta 
  cmp cl,'2'
  je JogoCoinFlip
  cmp cl,'3'
  je JogoRoletaRussa
  jne NumeroErrado
   
  NumeroErrado:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
  
  MOV AH, 9
  LEA DX, ERRO
  INT 21H 
   
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H  
  jmp EscolherJogoDeNovo
  
  
;---------------------------------------------JOGO ROLETA  
 
 
  JogoRoleta:   
  InicioRoleta:
;dar um clear na consola e comeca o jogo 

  call clear_screen 

call Desenho_Jogo_Roleta

;fazer a jogada 
  
  ;--------------------Aparece as opcoes
MOV AH, 9
LEA DX, Paragrafo
INT 21H 
   
   MOV AH, 9
   LEA DX, Jogada
   INT 21H   
   

 

;Escolher Opcao( par ,zero , inpar)               
  EscolherOpcaoDeNovo:
  MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL
  
  cmp cl, '0'
  je OpcaoSair
  cmp cl, '1'
  je OpcaoZero 
  cmp cl,'2'
  je OpcaoPar
  cmp cl,'3'
  je OpcaoImpar
  jne OpcaoErrada
  
  OpcaoSair:
  jmp OpcaoVoltarMenu
   
  OpcaoErrada:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
  
  MOV AH, 9
  LEA DX, ERRO
  INT 21H 
   
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H  
  jmp EscolherOpcaoDeNovo
    ;---------------------------Escolha de par inpar ou zero
  ;-----------------------OPCAO ZERO  
  OpcaoZero:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
   InicioAposta:
  MOV AH, 9
  LEA DX, InsiraValorDaAposta
  INT 21H     
   ;Guarda valor que quer apostar em BL
  CALL SCAN_NUM
  MOV BH,CL
  
   ;Tira do dinheiro atual o valor da aposta
      
   cmp BL,BH
   JGE ApostaPossivelZero   
   JL  ApostaNaoPossivelZero  
      
   ;-----------Erro na aposta
 
 ApostaNaoPossivelZero:
   MOV AH, 9
   LEA DX, ERRO
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
  Jmp InicioAposta 
   
   ;---SE for possivel realizar a aposta
   
ApostaPossivelZero:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
    
   SUB BL,BH 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,10
jle NumeroRoleta0
cmp dl,21
jle NumeroRoleta1  
cmp dl,32
jle NumeroRoleta2  
cmp dl,43
jle NumeroRoleta3  
cmp dl,54
jle NumeroRoleta4  
cmp dl,65
jle NumeroRoleta5  
cmp dl,76
jle NumeroRoleta6  
cmp dl,87
jle NumeroRoleta7
cmp dl,99
jle NumeroRoleta8      
  
   
    
  NumeroRoleta0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar0
   
   NumeroRoleta1:  
    Mov [BX],'1' 
     jmp continuar0
      
     NumeroRoleta2:  
    Mov [BX],'2' 
     jmp continuar0 
     
      NumeroRoleta3:  
    Mov [BX],'3' 
     jmp continuar0 
     
      NumeroRoleta4:  
    Mov [BX],'4' 
     jmp continuar0
     
      NumeroRoleta5:  
    Mov [BX],'5' 
     jmp continuar0
     
      NumeroRoleta6:  
    Mov [BX],'6' 
     jmp continuar0
     
      NumeroRoleta7:  
    Mov [BX],'7' 
     jmp continuar0
     
      NumeroRoleta8:  
    Mov [BX],'8' 
     jmp continuar0
     
   
   
   continuar0:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceNumero0
  cmp [BX],'1'
  je ApareceNumero1
  cmp [BX],'2'
  je ApareceNumero2
  cmp [BX],'3'
  je ApareceNumero3
  cmp [BX],'4'
  je ApareceNumero4
  cmp [BX],'5'
  je ApareceNumero5
  cmp [BX],'6'
  je ApareceNumero6
  cmp [BX],'7'
  je ApareceNumero7
  cmp [BX],'8'
  je ApareceNumero8
  
    ApareceNumero0:
    call DesenhoNumero0
    jmp GanhouZero 
    
     ApareceNumero1:
    call DesenhoNumero1
    jmp PerdeuZero
    
     ApareceNumero2:
    call DesenhoNumero2
    jmp PerdeuZero
    
     ApareceNumero3:
    call DesenhoNumero3
    jmp PerdeuZero
    
     ApareceNumero4:
    call DesenhoNumero4
    jmp PerdeuZero
    
     ApareceNumero5:
    call DesenhoNumero5
    jmp PerdeuZero
    
     ApareceNumero6:
    call DesenhoNumero6
    jmp PerdeuZero
    
     ApareceNumero7:
    call DesenhoNumero7
    jmp PerdeuZero
    
     ApareceNumero8:
    call DesenhoNumero8
    jmp PerdeuZero
    
  

   
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouZero:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 8  
  add BH,BH
  add BH,BH
  add BH,BH
  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar2
    
  PerdeuZero:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar2
   
   continuar2:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioRoleta
;----------------------------------------------------FimOpcaoZero 
  
;---------------------------------------------Opcao Par  
  OpcaoPar: 
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
   InicioApostaPar:
  MOV AH, 9
  LEA DX, InsiraValorDaAposta
  INT 21H     
   ;Guarda valor que quer apostar em BL
  CALL SCAN_NUM
  MOV BH,CL
  
   ;Tira do dinheiro atual o valor da aposta
      
   cmp BL,BH
   JGE ApostaPossivelPar   
   JL  ApostaNaoPossivelPar  
      
   ;-----------Erro na aposta
 
 ApostaNaoPossivelPar:
   MOV AH, 9
   LEA DX, ERRO
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
  Jmp InicioApostaPar 
   
   ;---SE for possivel realizar a aposta
   
ApostaPossivelPar:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
    
   SUB BL,BH 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,10
jle NumeroRoletaPar0
cmp dl,21
jle NumeroRoletaPar1  
cmp dl,32
jle NumeroRoletaPar2  
cmp dl,43
jle NumeroRoletaPar3  
cmp dl,54
jle NumeroRoletaPar4  
cmp dl,65
jle NumeroRoletaPar5  
cmp dl,76
jle NumeroRoletaPar6  
cmp dl,87
jle NumeroRoletaPar7
cmp dl,99
jle NumeroRoletaPar8      
  
   
    
  NumeroRoletaPar0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar3
   
   NumeroRoletaPar1:  
    Mov [BX],'1' 
     jmp continuar3
      
     NumeroRoletaPar2:  
    Mov [BX],'2' 
     jmp continuar3 
     
      NumeroRoletaPar3:  
    Mov [BX],'3' 
     jmp continuar3 
     
      NumeroRoletaPar4:  
    Mov [BX],'4' 
     jmp continuar3
     
      NumeroRoletaPar5:  
    Mov [BX],'5' 
     jmp continuar3
     
      NumeroRoletaPar6:  
    Mov [BX],'6' 
     jmp continuar3
     
      NumeroRoletaPar7:  
    Mov [BX],'7' 
     jmp continuar3
     
      NumeroRoletaPar8:  
    Mov [BX],'8' 
     jmp continuar3
     
   
   
   continuar3:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceNumeroPar0
  cmp [BX],'1'
  je ApareceNumeroPar1
  cmp [BX],'2'
  je ApareceNumeroPar2
  cmp [BX],'3'
  je ApareceNumeroPar3
  cmp [BX],'4'
  je ApareceNumeroPar4
  cmp [BX],'5'
  je ApareceNumeroPar5
  cmp [BX],'6'
  je ApareceNumeroPar6
  cmp [BX],'7'
  je ApareceNumeroPar7
  cmp [BX],'8'
  je ApareceNumeroPar8
  
    ApareceNumeroPar0:
    call DesenhoNumero0
    jmp PerdeuPar 
    
     ApareceNumeroPar1:
    call DesenhoNumero1
    jmp PerdeuPar
    
     ApareceNumeroPar2:
    call DesenhoNumero2
    jmp GanhouPar
    
     ApareceNumeroPar3:
    call DesenhoNumero3
    jmp PerdeuPar
    
     ApareceNumeroPar4:
    call DesenhoNumero4
    jmp GanhouPar
    
     ApareceNumeroPar5:
    call DesenhoNumero5
    jmp PerdeuPar
    
     ApareceNumeroPar6:
    call DesenhoNumero6
    jmp GanhouPar
    
     ApareceNumeroPar7:
    call DesenhoNumero7
    jmp PerdeuPar
    
     ApareceNumeroPar8:
    call DesenhoNumero8
    jmp GanhouPar
    
  

   
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouPar:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 2  
  add BH,BH

  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar4
    
  PerdeuPar:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar4
   
   continuar4:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioRoleta
;----------------------------------------------------FimOpcaoPar

  
  
  
  
  
    
  
  ;---------------------------------------------Opcao Impar  
  OpcaoImpar: 
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
   InicioApostaImpar:
  MOV AH, 9
  LEA DX, InsiraValorDaAposta
  INT 21H     
   ;Guarda valor que quer apostar em BL
  CALL SCAN_NUM
  MOV BH,CL
  
   ;Tira do dinheiro atual o valor da aposta
      
   cmp BL,BH
   JGE ApostaPossivelImpar   
   JL  ApostaNaoPossivelImpar  
      
   ;-----------Erro na aposta
 
 ApostaNaoPossivelImpar:
   MOV AH, 9
   LEA DX, ERRO
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
  Jmp InicioApostaImpar 
   
   ;---SE for possivel realizar a aposta
   
ApostaPossivelImpar:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
    
   SUB BL,BH 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,10
jle NumeroRoletaImpar0
cmp dl,21
jle NumeroRoletaImpar1  
cmp dl,32
jle NumeroRoletaImpar2  
cmp dl,43
jle NumeroRoletaImpar3  
cmp dl,54
jle NumeroRoletaImpar4  
cmp dl,65
jle NumeroRoletaImpar5  
cmp dl,76
jle NumeroRoletaImpar6  
cmp dl,87
jle NumeroRoletaImpar7
cmp dl,99
jle NumeroRoletaImpar8      
  
   
    
  NumeroRoletaImpar0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar5
   
   NumeroRoletaImpar1:  
    Mov [BX],'1' 
     jmp continuar5
      
     NumeroRoletaImpar2:  
    Mov [BX],'2' 
     jmp continuar5 
     
      NumeroRoletaImpar3:  
    Mov [BX],'3' 
     jmp continuar5 
     
      NumeroRoletaImpar4:  
    Mov [BX],'4' 
     jmp continuar5
     
      NumeroRoletaImpar5:  
    Mov [BX],'5' 
     jmp continuar5
     
      NumeroRoletaImpar6:  
    Mov [BX],'6' 
     jmp continuar5
     
      NumeroRoletaImpar7:  
    Mov [BX],'7' 
     jmp continuar5
     
      NumeroRoletaImpar8:  
    Mov [BX],'8' 
     jmp continuar5
     
   
   
   continuar5:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceNumeroImpar0
  cmp [BX],'1'
  je ApareceNumeroImpar1
  cmp [BX],'2'
  je ApareceNumeroImpar2
  cmp [BX],'3'
  je ApareceNumeroImpar3
  cmp [BX],'4'
  je ApareceNumeroImpar4
  cmp [BX],'5'
  je ApareceNumeroImpar5
  cmp [BX],'6'
  je ApareceNumeroImpar6
  cmp [BX],'7'
  je ApareceNumeroImpar7
  cmp [BX],'8'
  je ApareceNumeroImpar8
  
    ApareceNumeroImpar0:
    call DesenhoNumero0
    jmp PerdeuImpar 
    
     ApareceNumeroImpar1:
    call DesenhoNumero1
    jmp GanhouImpar
    
     ApareceNumeroImpar2:
    call DesenhoNumero2
    jmp PerdeuImpar
    
     ApareceNumeroImpar3:
    call DesenhoNumero3
    jmp GanhouImpar
    
     ApareceNumeroImpar4:
    call DesenhoNumero4
    jmp PerdeuImpar
    
     ApareceNumeroImpar5:
    call DesenhoNumero5
    jmp GanhouImpar
    
     ApareceNumeroImpar6:
    call DesenhoNumero6
    jmp PerdeuImpar
    
     ApareceNumeroImpar7:
    call DesenhoNumero7
    jmp GanhouImpar
    
     ApareceNumeroImpar8:
    call DesenhoNumero8
    jmp PerdeuImpar
    
  

   
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouImpar:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 2  
  add BH,BH

  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar6
    
  PerdeuImpar:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar6
   
   continuar6:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioRoleta
;----------------------------------------------------FimOpcaoImpar
  
  
   
;------------------------------------------------FimJogoRoleta   
   

;-----------------------------------InicioJogoCoinFlip
 
  JogoCoinFlip:   
  InicioCoinFlip:
;dar um clear na consola e comeca o jogo 

  call clear_screen 

call Desenho_Jogo_CoinFlip

;fazer a jogada 
  
  ;--------------------Aparece as opcoes
MOV AH, 9
LEA DX, Paragrafo
INT 21H 
   
   MOV AH, 9
   LEA DX, JogadaCoinFlip
   INT 21H   
   

 

;Escolher Opcao( par ,zero , inpar)               
  EscolherOpcaoDeNovoCoinFlip:
  MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL
  
  cmp cl, '0'
  je OpcaoSairCoinflip
  cmp cl, '1'
  je OpcaoCara 
  cmp cl,'2'
  je OpcaoCoroa
  jne OpcaoErradaCoinFlip
  
  OpcaoSairCoinFlip:
  jmp OpcaoVoltarMenu
   
  OpcaoErradaCoinFlip:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
  
  MOV AH, 9
  LEA DX, ERRO
  INT 21H 
   
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H  
  jmp EscolherOpcaoDeNovoCoinFlip
    ;---------------------------Escolha de par inpar ou zero
  ;-----------------------OPCAO Cara  
  OpcaoCara:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
   InicioApostaCoinFlip:
  MOV AH, 9
  LEA DX, InsiraValorDaAposta
  INT 21H     
   ;Guarda valor que quer apostar em BL
  CALL SCAN_NUM
  MOV BH,CL
  
   ;Tira do dinheiro atual o valor da aposta
      
   cmp BL,BH
   JGE ApostaPossivelCara   
   JL  ApostaNaoPossivelCara  
      
   ;-----------Erro na aposta
 
 ApostaNaoPossivelCara:
   MOV AH, 9
   LEA DX, ERRO
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
  Jmp InicioApostaCoinFlip 
   
   ;---SE for possivel realizar a aposta
   
ApostaPossivelCara:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
    
   SUB BL,BH 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,49
jle NumeroCoinFlipCara0
cmp dl,99
jle NumeroCoinFlipCara1  
   
  
   
    
  NumeroCoinFlipCara0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar7
   
   NumeroCoinFlipCara1:  
    Mov [BX],'1' 
     jmp continuar7
      

     
   
   
   continuar7:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceCara0
  cmp [BX],'1'
  je ApareceCoroa0
  
  
    ApareceCara0:
    call DesenhoCara
    jmp GanhouCara 
    
     ApareceCoroa0:
    call DesenhoCoroa
    jmp PerdeuCara
    
     
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouCara:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 2  
  add BH,BH
  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar8
    
  PerdeuCara:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar8
   
   continuar8:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioCoinFlip
;----------------------------------------------------FimOpcaoCara 
  
  ;-----------------------OPCAO Coroa 
  OpcaoCoroa:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
   InicioApostaCoinFlip1:
  MOV AH, 9
  LEA DX, InsiraValorDaAposta
  INT 21H     
   ;Guarda valor que quer apostar em BL
  CALL SCAN_NUM
  MOV BH,CL
  
   ;Tira do dinheiro atual o valor da aposta
      
   cmp BL,BH
   JGE ApostaPossivelCoroa   
   JL  ApostaNaoPossivelCoroa  
      
   ;-----------Erro na aposta
 
 ApostaNaoPossivelCoroa:
   MOV AH, 9
   LEA DX, ERRO
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
  Jmp InicioApostaCoinFlip1 
   
   ;---SE for possivel realizar a aposta
   
ApostaPossivelCoroa:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
    
   SUB BL,BH 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,49
jle NumeroCoinFlipCoroa0
cmp dl,99
jle NumeroCoinFlipCoroa1  
   
  
   
    
  NumeroCoinFlipCoroa0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar9
   
   NumeroCoinFlipCoroa1:  
    Mov [BX],'1' 
     jmp continuar9
      

     
   
   
   continuar9:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceCara1
  cmp [BX],'1'
  je ApareceCoroa1
  
  
    ApareceCara1:
    call DesenhoCara
    jmp PerdeuCoroa 
    
     ApareceCoroa1:
    call DesenhoCoroa
    jmp GanhouCoroa
    
     
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouCoroa:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 2  
  add BH,BH
  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar10
    
  PerdeuCoroa:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar10
   
   continuar10:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioCoinFlip
;----------------------------------------------------FimOpcaoCoroa 
 

;---------------------------------------------FimJogoCoinFlip

;---------------------------------------------InicioJogoRoletaRussa

  JogoRoletaRussa:   
  InicioRoletaRussa:
;dar um clear na consola e comeca o jogo 

  call clear_screen 

call Desenho_Jogo_RoletaRussa

;fazer a jogada 
  
  ;--------------------Aparece as opcoes
MOV AH, 9
LEA DX, Paragrafo
INT 21H 
   
   MOV AH, 9
   LEA DX, JogadaRoletaRussa
   INT 21H   
   

 

;Escolher Opcao( par ,zero , inpar)               
  EscolherOpcaoDeNovoRoletaRussa:
  MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL
  
  cmp cl, '0'
  je OpcaoSairRoletaRussa
  cmp cl, '1'
  je OpcaoApostar
  jne OpcaoErradaRoletaRussa
  
  OpcaoSairRoletaRussa:
  jmp OpcaoVoltarMenu
   
  OpcaoErradaRoletaRussa:
  
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H 
  
  MOV AH, 9
  LEA DX, ERRO
  INT 21H 
   
  MOV AH, 9
  LEA DX, Paragrafo
  INT 21H  
  jmp EscolherOpcaoDeNovoRoletaRussa
    ;---------------------------Escolha de par inpar ou zero
  ;-----------------------OPCAO Cara  
  OpcaoApostar:    
     
      MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
   MOV BH,BL
   SUB BL,BL 
   ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
     ;antes de se escolher a opçao a roleta ja foi lancada mas nao se sabe
  ;fazer o lancamento da roleta
 
 call ALEATORIO

 


;faz um aleatorio e guarda em dl, agora vamos transformar esse aleatorio em um numero de 0 a 8
   
cmp dl,59
jle NumeroRoletaRussaVives0
cmp dl,99                    
jle NumeroRoletaRussaVives1  
   
  
   
    
  NumeroRoletaRussaVives0:
    ;vai definir bx a 0
    ;como o bh vai ser utilizado para buscar os valores das apostas estará sempre a ser chamado
    ;por isso pode ser utilizado aqui que nao vai fazer diferenca
     Mov [BX],'0' 
     jmp continuar11
   
   NumeroRoletaRussaVives1:  
    Mov [BX],'1' 
     jmp continuar11
      

     
   
   
   continuar11:  
 

    
 ; vai aparecer o numero da roleta e dizer se ganhou ou nao 
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
  
 
    
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
   
  
   
  cmp [BX],'0'
  je ApareceVives
  cmp [BX],'1'
  je ApareceMorres
  
  
    ApareceVives:
    call DesenhoVives
    jmp GanhouVives 
    
     ApareceMorres:
    call DesenhoMorres
    jmp PerdeuMorres
    
     
   ;vai aparecer se ganhou ou nao e fazer as seguintes contas ao dinheiro
  
  
  
  GanhouVives:
  
  MOV AH, 9
  LEA DX, Ganhou
  INT 21H
   
;o BH e o dinheiro apostado entao a este vai se multiplicar por 8 e sumar ao BL que e o saldo
 ;---o mesmo que multiplicar por 2  
  add BH,BH
  ;:------
  ;adiciona a carteira o dinheiro ganho
  add BL,BH 
    
    JMP continuar12
    
  PerdeuMorres:
  
   MOV AH, 9
   LEA DX, Perdeu
   INT 21H
   
   JMP continuar12
   
   continuar12:
  ;escrever o numero
 
     MOV AH, 9
   LEA DX, DinheiroAtual
   INT 21H  
;aparecer o valor do dinheiro
MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 
  
  MOV AH, 9
   LEA DX, Paragrafo
   INT 21H

   
    MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
        
    MOV AH, 1  ;escrever tecla e guarda-la em cl
  INT 21H
  MOV CL,AL 
  
  
  JMP InicioRoletaRussa
;----------------------------------------------------FimOpcaoCara 


   
;-------------------------------------------- funcoes
clear_screen proc
    mov ah,0
    mov al,3
    int 10h  
    clear_screen endp  
jmp FIM


Desenho_Jogo_Roleta proc   
    
     
          MOV AH, 9
   LEA DX, DesenhoRoleta1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoRoleta2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoleta3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoleta4
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
    MOV AH, 9
   LEA DX, DesenhoRoleta5
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoleta6
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
    
    MOV AH, 9
   LEA DX, DesenhoRoleta7
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, DesenhoRoleta8
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoleta9
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoleta10
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoleta11
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoleta12
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoleta13
   INT 21H 
   
   MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 

MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    Desenho_Jogo_Roleta endp 
    jmp FIM
 
 
 ALEATORIO PROC NEAR
MOV AH,2CH ;VAI BUSCAR A HORA DO SISTEMA
INT 21H
MOV Al,Dl ;Guarda em AX os milisegundos(DL)
RET
ALEATORIO ENDP   
 jmp FIM
 
 
DesenhoNumero0 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero00
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero01
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero02
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero03
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero0 endp
     jmp FIM
 
DesenhoNumero1 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero10
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero11
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero12
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero13
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero1 endp
     jmp FIM 
 
DesenhoNumero2 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero20
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero21
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero22
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero23
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero2 endp
     jmp FIM 
     
     
    DesenhoNumero3 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero30
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero31
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero32
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero33
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero3 endp
     jmp FIM
   
   
   DesenhoNumero4 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero40
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero41
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero42
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero43
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero4 endp
     jmp FIM
  
   DesenhoNumero5 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero50
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero51
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero52
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero53
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero5 endp
     jmp FIM
  
   DesenhoNumero6 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero60
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero61
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero62
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero63
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero6 endp
     jmp FIM
  
   
   DesenhoNumero7 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero70
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero71
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero72
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero73
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero7 endp
     jmp FIM
    
    
   DesenhoNumero8 proc 
    
          MOV AH, 9
   LEA DX, DesenhoNumero80
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoNumero81
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoNumero82
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoNumero83
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoNumero8 endp
     jmp FIM 
     
   
   Desenho_Jogo_CoinFlip proc   
    
     
          MOV AH, 9
   LEA DX, DesenhoCoinFlip1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoCoinFlip2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip4
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip5
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip6
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
    
    MOV AH, 9
   LEA DX, DesenhoCoinFlip7
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip8
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip9
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip10
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip11
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip12
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCoinFlip13
   INT 21H 
   
   MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 

MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    Desenho_Jogo_CoinFlip endp 
    jmp FIM


   DesenhoCara proc 
    
          MOV AH, 9
   LEA DX, DesenhoCara0
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoCara1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCara2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCara3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoCara endp
     jmp FIM 
     
 
    DesenhoCoroa proc 
    
          MOV AH, 9
   LEA DX, DesenhoCoroa0
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoCoroa1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoCoroa2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoCoroa3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoCoroa endp
     jmp FIM     

;desenhos roleta russa

   Desenho_Jogo_RoletaRussa proc   
    
     
          MOV AH, 9
   LEA DX, DesenhoRoletaRussa1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoRoletaRussa2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa4
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa5
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa6
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
    
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa7
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa8
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa9
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa10
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa11
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa12
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoRoletaRussa13
   INT 21H 
   
   MOV AH,0              
MOV AL, BL
CALL PRINT_NUM 

MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    Desenho_Jogo_RoletaRussa endp 
    jmp FIM



    DesenhoVives proc 
    
          MOV AH, 9
   LEA DX, DesenhoVives0
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoVives1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoVives2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoVives3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoVives endp
     jmp FIM    


    DesenhoMorres proc 
    
          MOV AH, 9
   LEA DX, DesenhoMorres0
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
   MOV AH, 9
   LEA DX, DesenhoMorres1
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H 
   
    MOV AH, 9
   LEA DX, DesenhoMorres2
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H  
   
    MOV AH, 9
   LEA DX, DesenhoMorres3
   INT 21H
   
   MOV AH, 9
   LEA DX, Paragrafo
   INT 21H   
   
     DesenhoMorres endp
     jmp FIM 
    
   
 FIM:
  

  
  
RET 

define_scan_num
define_print_num
define_print_num_uns



Paragrafo DB 13,10,'','$'
TextoMenu1 DB '__________________________________________________________','$'
TextoMenu2 DB '__________________________________________________________','$'
TextoMenu3 DB '__________________________________________________________','$'
TextoMenu4 DB '__________________                    ____________________','$'
TextoMenu5 DB '__________________                    ____________________','$'
TextoMenu6 DB '__________________ JOGOS  DE  CASINO  ____________________','$'
TextoMenu7 DB '__________________                    ____________________','$'
TextoMenu8 DB '__________________________________________________________','$'  
TextoMenu9 DB '__________________________________________________________','$'
TextoMenu10 DB '__________________________________________________________','$' 
TextoMenu11 DB '                                Criado Por :Pedro Monteiro','$' 

DinheiroAtual DB 'Dinheiro Atual:','$'
EscolherJogo1 DB ,13,10,13,10,'Escolha o jogo que quer jogar :',13,10,'1-Roleta',,13,10,'2-CoinFlip',,13,10,'3-RoletaRussa','$' 
ERRO DB 'Erro!!','$'

DesenhoRoleta1 DB ' _______________________________________________','$'   
DesenhoRoleta2 DB '|                                               |','$'
DesenhoRoleta3 DB '|                    ROLETA                     |','$'
DesenhoRoleta4 DB '|_______________________________________________|','$'
DesenhoRoleta5 DB '|  ___  ___  ___  ___  ___  ___  ___  ___  ___  |','$'
DesenhoRoleta6 DB '| |   ||   ||   ||   ||   ||   ||   ||   ||   | |','$'
DesenhoRoleta7 DB '| | 1 || 2 || 3 || 4 || 0 || 5 || 6 || 7 || 8 | |','$'
DesenhoRoleta8 DB '| |___||___||___||___||___||___||___||___||___| |','$'
DesenhoRoleta9 DB '|                                               |','$'
DesenhoRoleta10 DB '|                                               |','$'
DesenhoRoleta11 DB '|(Par) Win 2x  |  (Zero)Win 8x  | (Impar)Win 2x |','$'
DesenhoRoleta12 DB '|_______________________________________________|','$'
DesenhoRoleta13 DB '                               Dinheiro Atual:','$'

Jogada DB 'Insira a opcao que quer apostar:',13,10,'1-Zero',,13,10,'2-Par',,13,10,'3-Impar',13,10,'0-Sair',13,10,'$'
InsiraValorDaAposta DB 'Insira quanto quer apostar:',13,10,'$'

DesenhoNumero00 DB ' ___ ','$'        
DesenhoNumero01 DB '|   |','$'
DesenhoNumero02 DB '| 0 |','$'
DesenhoNumero03 DB '|___|','$'

DesenhoNumero10 DB ' ___ ','$'        
DesenhoNumero11 DB '|   |','$'
DesenhoNumero12 DB '| 1 |','$'
DesenhoNumero13 DB '|___|','$' 

DesenhoNumero20 DB ' ___ ','$'        
DesenhoNumero21 DB '|   |','$'
DesenhoNumero22 DB '| 2 |','$'
DesenhoNumero23 DB '|___|','$'

DesenhoNumero30 DB ' ___ ','$'        
DesenhoNumero31 DB '|   |','$'
DesenhoNumero32 DB '| 3 |','$'
DesenhoNumero33 DB '|___|','$' 

DesenhoNumero40 DB ' ___ ','$'        
DesenhoNumero41 DB '|   |','$'
DesenhoNumero42 DB '| 4 |','$'
DesenhoNumero43 DB '|___|','$' 

DesenhoNumero50 DB ' ___ ','$'        
DesenhoNumero51 DB '|   |','$'
DesenhoNumero52 DB '| 5 |','$'
DesenhoNumero53 DB '|___|','$'

DesenhoNumero60 DB ' ___ ','$'        
DesenhoNumero61 DB '|   |','$'
DesenhoNumero62 DB '| 6 |','$'
DesenhoNumero63 DB '|___|','$'

DesenhoNumero70 DB ' ___ ','$'        
DesenhoNumero71 DB '|   |','$'
DesenhoNumero72 DB '| 7 |','$'
DesenhoNumero73 DB '|___|','$'

DesenhoNumero80 DB ' ___ ','$'        
DesenhoNumero81 DB '|   |','$'
DesenhoNumero82 DB '| 8 |','$'
DesenhoNumero83 DB '|___|','$'
         
Ganhou DB ,13,10,'Ganhou!',13,10,'$' 
Perdeu DB ,13,10,'Perdeu!',13,10,'$'          



DesenhoCoinFlip1 DB  ' ___________________________________','$'   
DesenhoCoinFlip2 DB  '|                                   |','$'
DesenhoCoinFlip3 DB  '|            CoinFlip               |','$'
DesenhoCoinFlip4 DB  '|___________________________________|','$'
DesenhoCoinFlip5 DB  '|     ______           _______      |','$'
DesenhoCoinFlip6 DB  '|    |      |         |       |     |','$'
DesenhoCoinFlip7 DB  '|    | Cara |         | Coroa |     |','$'
DesenhoCoinFlip8 DB  '|    |______|         |_______|     |','$'
DesenhoCoinFlip9 DB  '|                                   |','$'
DesenhoCoinFlip10 DB '|                                   |','$'
DesenhoCoinFlip11 DB '| (Cara) Win 2x  |  (Coroa)Win 2x   |','$'
DesenhoCoinFlip12 DB '|___________________________________|','$'
DesenhoCoinFlip13 DB '                    Dinheiro Atual:','$'

JogadaCoinFlip DB 'Insira a opcao que quer apostar:',13,10,'1-Cara',13,10,'2-Coroa',13,10,'0-Sair',13,10,'$'

DesenhoCara0 DB ' ______ ','$'        
DesenhoCara1 DB '|      |','$'
DesenhoCara2 DB '| Cara |','$'
DesenhoCara3 DB '|______|','$'

DesenhoCoroa0 DB ' _______','$'        
DesenhoCoroa1 DB '|       |','$'
DesenhoCoroa2 DB '| Coroa |','$'
DesenhoCoroa3 DB '|_______|','$'         



DesenhoRoletaRussa1 DB  ' ______________________________________','$'   
DesenhoRoletaRussa2 DB  '|                                      |','$'
DesenhoRoletaRussa3 DB  '|            Roleta Russa              |','$'
DesenhoRoletaRussa4 DB  '|______________________________________|','$'
DesenhoRoletaRussa5 DB  '|  ______  _____  _____  _____  ______ |','$'
DesenhoRoletaRussa6 DB  '| |      ||     ||     ||     ||      ||','$'
DesenhoRoletaRussa7 DB  '| |Morres||Vives||Vives||Vives||Morres||','$'
DesenhoRoletaRussa8 DB  '| |______||_____||_____||_____||______||','$'
DesenhoRoletaRussa9 DB  '|                                      |','$'
DesenhoRoletaRussa10 DB '|                                      |','$'
DesenhoRoletaRussa11 DB '|     Apostar(ALL IN!!) winx2          |','$'
DesenhoRoletaRussa12 DB '|______________________________________|','$'
DesenhoRoletaRussa13 DB '                    Dinheiro Atual:','$'

DesenhoVives0 DB ' _______ ','$'        
DesenhoVives1 DB '|       |','$'
DesenhoVives2 DB '| Vives |','$'
DesenhoVives3 DB '|_______|','$' 

DesenhoMorres0 DB ' ________ ','$'        
DesenhoMorres1 DB '|        |','$'
DesenhoMorres2 DB '| Morres |','$'
DesenhoMorres3 DB '|________|','$'

JogadaRoletaRussa DB 'Insira a opcao que quer:',13,10,'1-Apostar(All in)',13,10,'0-Sair',13,10,'$'
                                                       
END