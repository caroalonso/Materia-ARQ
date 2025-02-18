;Este programa realiza la multiplicación de dos números almacenados en memoria, NUM1 y NUM2, sin utilizar subrutinas. 


; Memoria de Datos
ORG 1000H
NUM1 DB 5H   ; Primer número (5)
NUM2 DB 3H   ; Segundo número (3)

; Memoria de Instrucciones
ORG 2000H
MOV AL, NUM1      ; Carga NUM1 en AL
CMP AL, 0         ; Compara AL con 0
JZ FIN            ; Si AL es 0, salta al final (no hacer nada)

MOV AH, 0         ; Inicializa AH en 0
MOV DX, 0         ; Inicializa DX en 0
MOV CL, NUM2      ; Carga NUM2 en CL

LOOP: CMP CL, 0   ; Compara CL con 0
JZ FIN            ; Si CL es 0, salta al final
ADD DX, AX        ; Suma AX (AL * 1) a DX
DEC CL            ; Decrementa CL
JMP LOOP          ; Salta al inicio del bucle

FIN: HLT          ; Termina el programa
END
