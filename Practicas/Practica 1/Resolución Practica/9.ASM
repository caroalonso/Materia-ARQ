;9) Escriba la subrutina ROTARDER del ejercicio anterior, pero sin usar la subrutina ROTARIZ. Compare que ventajas
;tiene cada una de las soluciones.

ORG 1000H                 ; Dirección de inicio del programa
NUM     DB   4            ; Número a rotar (4 = 00000100 en binario)
VECES   DB   3            ; Número de posiciones a rotar (3)

; Subrutina ROTARDER: Realiza una rotación a la derecha sin usar ROTARIZ
ORG 3000H
ROTADER:  
    CMP AH, 0             ; Compara el valor de AH con 0 (si es 0, fin de la rotación)
    JZ FINAL1             ; Si AH es 0, salta a FINAL1 (termina la rotación)
ROTAD:  
    MOV DL, 0             ; Inicializa DL en 0 (usado para almacenar el valor de rotación temporal)
SIGO:  
    SUB AH, 2             ; Resta 2 de AH (para calcular el número de posiciones a rotar)
    JC FIN                ; Si hubo acarreo (el valor de AH se volvió negativo), salta a FIN
    INC DL                ; Incrementa DL (contabiliza una posición rotada)
    CMP AH, 0             ; Compara AH con 0 (si AH llega a 0, fin de la rotación)
    JZ FINAL              ; Si AH es 0, salta a FINAL
    JMP SIGO              ; Si no, repite el ciclo (rotación continúa)
FIN:    
    ADD DL, 80H           ; Agrega 0x80 a DL para simular la rotación (deja el bit de acarreo en DL)
FINAL:  
    MOV AH, DL            ; Mueve el valor rotado de DL a AH
    DEC CL                ; Decrementa el contador de rotaciones (CL)
    JNZ ROTAD             ; Si todavía hay rotaciones por hacer, repite ROTAD
FINAL1:  
    RET                   ; Regresa de la subrutina (termina la rotación)

; Programa principal: Realiza la rotación a la derecha
ORG 2000H
    MOV AH, NUM           ; Carga el valor de NUM (4) en AH
    MOV CL, VECES         ; Carga el número de veces (3) en CL
    CALL ROTADER          ; Llama a ROTADER para hacer la rotación a la derecha
    HLT                   ; Fin del programa

END
