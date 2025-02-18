;c) Imprimir la cadena "USART XON/XOFF POLLING" en la impresora a través de la USART usando el protocolo XON/XOFF realizando la comunicación entre CPU y USART por consulta de estado.

ORG 1000H
; Imprimir "USART XON/XOFF POLLING" usando USART con protocolo XON/XOFF (consulta de estado)

MSG DB 'USART XON/XOFF POLLING', 0  ; Mensaje a imprimir
MOV SI, OFFSET MSG                 ; Dirección del mensaje

PRINT_CHAR:
    MOV AL, [SI]                   ; Cargar el siguiente carácter
    INC SI                         ; Avanzar al siguiente carácter

    CMP AL, 00                     ; Verificar fin del mensaje
    JE FIN                         ; Si es fin, salir

WAIT_READY:
    IN AL, 20H                     ; Leer el estado de la USART (consultar si está lista)
    TEST AL, 01H                   ; Verificar si está lista para enviar
    JZ WAIT_READY                  ; Si no está lista, seguir esperando

    OUT 30H, AL                    ; Enviar carácter a la impresora a través de USART

    JMP PRINT_CHAR                 ; Continuar con el siguiente carácter

FIN:
JMP $
END
