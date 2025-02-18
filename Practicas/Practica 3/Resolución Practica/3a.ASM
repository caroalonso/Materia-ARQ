;a) Imprimir "INGENIERIA E INFORMATICA" en la impresora a través del HAND-SHAKE en modo consulta de estado (polling):

ORG 1000H
; Imprimir "INGENIERIA E INFORMATICA" usando Handshake (Polling)

MSG DB 'INGENIERIA E INFORMATICA', 0

MOV SI, OFFSET MSG   ; Dirección del mensaje
PRINT_CHAR:
    MOV AL, [SI]     ; Cargar el siguiente carácter en AL
    INC SI           ; Avanzar al siguiente carácter

    CMP AL, 00       ; Verificar si es el fin del mensaje
    JE FIN           ; Si es 0, fin del mensaje

    ; Esperar que la impresora esté lista (check strobe)
CHECK_BUSY:
    IN AL, 20H       ; Leer el estado del puerto PA (bit busy)
    TEST AL, 01H     ; Verificar si está ocupado
    JZ CHECK_BUSY    ; Si está ocupado, seguir esperando

    OUT 31H, AL      ; Enviar carácter a la impresora (PB)
    
    ; Esperar que la impresora no esté ocupada
    MOV AL, 02H      ; Preparar strobe
    OUT 20H, AL      ; Enviar strobe (PA)
    MOV AL, 00H      ; Limpiar strobe
    OUT 20H, AL      ; Limpiar strobe

    JMP PRINT_CHAR   ; Repetir para el siguiente carácter

FIN:
JMP $
END
