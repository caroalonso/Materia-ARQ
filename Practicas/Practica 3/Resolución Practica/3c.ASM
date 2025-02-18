;c) Imprimir "UNIVERSIDAD NACIONAL DE LA PLATA" en la impresora a través del HAND-SHAKE en modo interrupciones:

ORG 1000H
; Imprimir "UNIVERSIDAD NACIONAL DE LA PLATA" usando Handshake (Interrupciones)

MSG DB 'UNIVERSIDAD NACIONAL DE LA PLATA', 0
MOV SI, OFFSET MSG   ; Dirección del mensaje

MOV BX, 0            ; Contador de caracteres

; Habilitar interrupciones
MOV AL, 01H          ; Habilitar interrupciones (máquina o controlador de impresora)
OUT 20H, AL

PRINT_CHAR:
    MOV AL, [SI]     ; Cargar siguiente carácter
    INC SI           ; Avanzar a siguiente carácter
    CMP AL, 00       ; Verificar fin del mensaje
    JE FIN           ; Si es fin del mensaje, saltar

    ; Enviar a la impresora
    OUT 31H, AL      ; Enviar carácter a impresora

    ; Esperar interrupción (manejo de interrupciones se realiza automáticamente)
    JMP PRINT_CHAR   ; Repetir para el siguiente carácter

FIN:
JMP $
END
