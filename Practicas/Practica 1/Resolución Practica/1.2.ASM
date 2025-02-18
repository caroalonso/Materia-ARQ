
;En este caso, el código tiene una subrutina llamada MUL que realiza la multiplicación. 
;El programa principal pasa los valores de los números a multiplicar usando registros.


; Memoria de Datos
ORG 1000H
NUM1 DB 5H
NUM2 DB 3H

; Memoria de Instrucciones
ORG 3000H ; Subrutina MUL
MUL: CMP AL, 0   ; Si AL es 0, salta al final
JZ FIN
CMP CL, 0       ; Si CL es 0, salta al final
JZ FIN

MOV AH, 0       ; Inicializa AH en 0
MOV DX, 0       ; Inicializa DX en 0
LAZO: ADD DX, AX ; Suma AX (AL * 1) a DX
DEC CL          ; Decrementa CL
JNZ LAZO        ; Si CL no es 0, repite el bucle
FIN: RET         ; Retorna al programa principal

ORG 2000H ; Programa principal
MOV AL, NUM1    ; Carga NUM1 en AL
MOV CL, NUM2    ; Carga NUM2 en CL
CALL MUL        ; Llama a la subrutina MUL

HLT             ; Termina el programa
END
