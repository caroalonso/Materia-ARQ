;Este programa realiza una multiplicación de dos números sin signo, NUM1 y NUM2, utilizando un enfoque repetitivo con un bucle.


; Memoria de Datos
ORG 1000H
NUM1 DW 5H   ; Primer número
NUM2 DW 3H   ; Segundo número

; Memoria de Instrucciones
ORG 3000H ; Subrutina MUL
MUL: 
    MOV AX, [NUM1]   ; Carga el valor de NUM1 en AX
    MOV BX, [NUM2]   ; Carga el valor de NUM2 en BX
    MOV DX, 0        ; Inicializa DX (resultado de la multiplicación)
    
LAZO:
    ADD DX, AX       ; Suma AX (valor de NUM1) a DX
    DEC BX           ; Decrementa BX (contador)
    JNZ LAZO         ; Repite el bucle si BX no es cero

    RET              ; Retorna al programa principal

ORG 2000H ; Programa principal
    MOV [NUM1], 5H  ; Define el valor de NUM1 (5)
    MOV [NUM2], 3H  ; Define el valor de NUM2 (3)
    CALL MUL         ; Llama a la subrutina MUL

HLT                 ; Termina el programa
END
