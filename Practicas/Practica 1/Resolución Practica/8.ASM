;8) Usando la subrutina ROTARIZ del ejercicio 4, escriba una subrutina ROTARDER que haga una rotación hacia la
;derecha de un byte almacenado en la memoria del microprocesador. Dicho byte y el número de posiciones a rotar
;deben pasarse por valor desde el programa principal a la subrutina a través de registros.


ORG 1000H                 ; Dirección de inicio del programa
DATO    DB   193          ; Valor inicial: 193 (11000001 en binario)
ROTADE  DB   3            ; Número de posiciones a rotar (3)

; Subrutina ROTARIZ: Realiza una rotación a la izquierda
ORG 3000H
ROTARIZ:  
    ADD AL, AL            ; Desplaza los bits de AL hacia la izquierda (AL = AL * 2)
    JNC SIGO              ; Si no hay acarreo, salta a SIGO (sin acarreo)
    ADC AL, 0             ; Si hubo acarreo, agrega 1 a AL
SIGO:  
    DEC CL                ; Decrementa el contador de posiciones a rotar (CL)
    JNZ ROTARIZ           ; Si aún hay posiciones por rotar, repite la rotación
    RET                   ; Regresa de la subrutina

; Subrutina ROTADER: Realiza una rotación a la derecha
ORG 4000H
ROTADER:  
    MOV AH, 8             ; Carga el valor 8 en AH (número de bits en un byte)
    SUB AH, CL            ; AH = 8 - CL (calculando las posiciones equivalentes a rotar a la izquierda)
    MOV CL, AH            ; Guarda el resultado en CL (número de posiciones a rotar a la izquierda)
    CALL ROTARIZ          ; Llama a la subrutina ROTARIZ para realizar la rotación a la izquierda
    RET                   ; Regresa de la subrutina

; Programa principal: Realiza la rotación a la derecha
ORG 2000H
    MOV AL, DATO          ; Carga el valor de DATO (193) en AL
    MOV CL, ROTADE        ; Carga el número de posiciones a rotar (3) en CL
    CALL ROTADER          ; Llama a ROTADER para realizar la rotación a la derecha
    HLT                   ; Fin del programa

END
